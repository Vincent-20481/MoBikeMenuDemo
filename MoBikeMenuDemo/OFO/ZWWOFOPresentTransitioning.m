//
//  ZWWOFOPresentTransitioning.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/23.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "ZWWOFOPresentTransitioning.h"
#import "OFOMenuViewController.h"
/**
 *  获取mainScreen的bounds
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height

@implementation ZWWOFOPresentTransitioning

+ (instancetype)transitionWithTransitionType:(ZWWPresentTransitionType)type{
    return [[self alloc]initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(ZWWPresentTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}


/**
 动画时间
 
 @param transitionContext transitionContext
 @return 动画时间
 */
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75;
}


/**
 动画逻辑
 
 @param transitionContext transitionContext
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //为了将两种动画的逻辑分开，变得更加清晰，我们分开书写逻辑，
    switch (_type) {
        case ZWWPresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
            
        case ZWWPresentTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}
//实现present动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    OFOMenuViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.alpha = 0;
    UIView *containerView = [transitionContext containerView];
    UIView *tempView0 = [toVC.yellowView snapshotViewAfterScreenUpdates:YES];
    tempView0.frame = CGRectMake(0, -kScreenHeight/3, kScreenWidth, kScreenHeight/3);
    UIView *tempView1 = [toVC.whiteView snapshotViewAfterScreenUpdates:YES];
    tempView1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-(kScreenHeight/3-30));
    UIView *tempView2 = [toVC.userImaegView snapshotViewAfterScreenUpdates:YES];
    tempView2.frame = CGRectMake(40,kScreenHeight, 80, 80);
    //我们用视图的截图做动画,动画完成移除
    [containerView addSubview:tempView0];
    [containerView addSubview:tempView1];
    [containerView addSubview:tempView2];
    [containerView addSubview:toVC.view];
    //开始动画，使用产生动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        tempView0.frame = toVC.yellowView.frame;
        tempView1.frame = toVC.whiteView.frame;
        tempView2.frame = toVC.userImaegView.frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        toVC.view.alpha = 1;
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //然后移除截图视图，因为下次触发present会重新截图
            [tempView0 removeFromSuperview];
            [tempView1 removeFromSuperview];
            [tempView2 removeFromSuperview];
        }
    }];
}
//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *temp0 = [transitionContext containerView].subviews[0];
    UIView *temp1 = [transitionContext containerView].subviews[1];
    UIView *temp2 = [transitionContext containerView].subviews[2];
    OFOMenuViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.alpha = 0;
    //动画吧
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        temp0.frame = CGRectMake(0, -kScreenHeight/3, kScreenWidth, kScreenHeight/3);
        temp1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-(kScreenHeight/3-30));
        temp2.frame = CGRectMake(40,kScreenHeight, 80, 80);
        
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
            fromVC.view.alpha = 1;
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
        }
    }];
}



@end
