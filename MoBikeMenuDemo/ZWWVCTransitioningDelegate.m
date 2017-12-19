//
//  ZWWVCTransitioningDelegate.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "ZWWVCTransitioningDelegate.h"

@implementation ZWWVCTransitioningDelegate

#pragma mark --- present系统动画协议
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    return [ZWWPresentTransitioning transitionWithTransitionType:ZWWPresentTransitionTypePresent];
}

#pragma mark --- dismissed系统动画协议
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    return [ZWWPresentTransitioning transitionWithTransitionType:ZWWPresentTransitionTypeDismiss];
}

#pragma mark --- 手势驱动dismissed系统动画协议
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveDismiss.interation ? _interactiveDismiss : nil;
}

#pragma mark --- 手势驱动present系统动画协议
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return self.interactivePresent.interation ? self.interactivePresent : nil;
}



@end
