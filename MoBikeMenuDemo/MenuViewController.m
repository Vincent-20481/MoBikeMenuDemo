//
//  MenuViewController.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//


#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (instancetype)init{
    if (self = [super init]) {
        self.VCDelegate = [[ZWWVCTransitioningDelegate alloc]init];
        self.transitioningDelegate =  self.VCDelegate;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backGroundImageView = [UIImageView new];
    backGroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.height*0.456, self.view.frame.size.height);
    backGroundImageView.image = [UIImage imageNamed:@"MoBike"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    backGroundImageView.userInteractionEnabled = YES;
    [backGroundImageView addGestureRecognizer:tap];
    [self.view addSubview:backGroundImageView];
    
    ZWWInteractiveTransition *interactiveDismiss = [ZWWInteractiveTransition interactiveTransitionWithTransitionType:ZWWInteractiveTransitionTypeDismiss GestureDirection:ZWWInteractiveTransitionGestureDirectionLeft];
    [interactiveDismiss addPanGestureForViewController:self];
    self.VCDelegate.interactiveDismiss = interactiveDismiss;
   
}

- (void)tapClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc{
    NSLog(@"%@ 控制器释放了",self);
}

//- 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
