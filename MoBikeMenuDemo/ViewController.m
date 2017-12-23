//
//  ViewController.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "ZWWVCTransitioningDelegate.h"
#import "ZWWInteractiveTransition.h"
#import "OFOMenuViewController.h"
@interface ViewController ()
@property(nonatomic,strong)ZWWInteractiveTransition *interactivePresent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //给当前view 添加侧边栏手势
    self.interactivePresent = [ZWWInteractiveTransition interactiveTransitionWithTransitionType:ZWWInteractiveTransitionTypePresent GestureDirection:ZWWInteractiveTransitionGestureDirectionRight];
    typeof(self)weakSelf = self;
    self.interactivePresent.presentConifg = ^(){
        [weakSelf setting:nil];
    };
    [self.interactivePresent addPanGestureForViewController:self];
}
- (IBAction)setting:(id)sender {
    //模态转场动画 可以全手势驱动
    MenuViewController *menu = [MenuViewController new];
    menu.VCDelegate.interactivePresent = self.interactivePresent;
    [self presentViewController:menu animated:YES completion:nil];
}
- (IBAction)ofoSetting:(id)sender {
    //模态转场动画 手势懒得写了,膜拜那个够清晰了
    OFOMenuViewController *OFOMenu = [OFOMenuViewController new];
    [self presentViewController:OFOMenu animated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"%@释放了",self);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
