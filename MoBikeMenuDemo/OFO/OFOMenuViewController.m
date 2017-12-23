//
//  OFOMenuViewController.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/23.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "OFOMenuViewController.h"
#import "ZWWOFOPresentTransitioning.h"
/**
 *  获取mainScreen的bounds
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height

@interface OFOMenuViewController ()<UIViewControllerTransitioningDelegate>

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
    
    [self.view addSubview:self.yellowView];
    [self.view addSubview:self.whiteView];
    [self.view addSubview:self.userImaegView];
    
    self.closeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80, 30, 80, 20)];
    [self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.yellowView addSubview:self.closeButton];
}

- (void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIView *)yellowView{
    if (!_yellowView) {
        _yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
        _yellowView.backgroundColor = [UIColor yellowColor];
    }
    return _yellowView;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/3-30, kScreenWidth, kScreenHeight-(kScreenHeight/3-30))];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

- (UIView *)userImaegView{
    if (!_userImaegView) {
        _userImaegView = [[UIView alloc]initWithFrame:CGRectMake(40, self.whiteView.frame.origin.y-40, 80, 80)];
        _userImaegView.backgroundColor = [UIColor redColor];
        _userImaegView.layer.cornerRadius = 40;
    }
    return _userImaegView;
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
