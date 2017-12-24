//
//  OFOMenuViewController.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/23.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "OFOMenuViewController.h"
#import "ZWWOFOPresentTransitioning.h"
#import "ZWWInteractiveTransition.h"
/**
 *  获取mainScreen的bounds
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height

@interface OFOMenuViewController ()<UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)ZWWInteractiveTransition *interactiveDismiss;
@end

@implementation OFOMenuViewController

- (instancetype)init{
    if (self = [super init]) {
        //代理方法我就不分离了,直接用当前控制器
        self.transitioningDelegate =  self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
    self.yellowView.backgroundColor = [UIColor yellowColor];
    
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/3-30, kScreenWidth, kScreenHeight-(kScreenHeight/3-30))];
    self.whiteView.backgroundColor = [UIColor whiteColor];

    
    _userImaegView = [[UIView alloc]initWithFrame:CGRectMake(40, self.whiteView.frame.origin.y-40, 80, 80)];
    _userImaegView.backgroundColor = [UIColor redColor];
    _userImaegView.layer.cornerRadius = 40;
    
    self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80, 30, 80, 20)];
    [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.yellowView];
    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.userImaegView];
    [self.yellowView addSubview:self.closeButton];
    
    
    //给当前view 添加下拉手势
    self.interactiveDismiss = [ZWWInteractiveTransition interactiveTransitionWithTransitionType:ZWWInteractiveTransitionTypeDismiss GestureDirection:ZWWInteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addPanGestureForViewController:self];
}

- (void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark --- UIViewControllerTransitioningDelegate
#pragma mark --- present系统动画协议
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    return [ZWWOFOPresentTransitioning transitionWithTransitionType:ZWWPresentTransitionTypePresent];
}

#pragma mark --- dismissed系统动画协议
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    return [ZWWOFOPresentTransitioning transitionWithTransitionType:ZWWPresentTransitionTypeDismiss];
}

#pragma mark --- 手势驱动dismissed系统动画协议
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveDismiss.interation ? self.interactiveDismiss : nil;
}


- (void)dealloc{
    NSLog(@"%@释放了",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
