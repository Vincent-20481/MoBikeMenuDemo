//
//  ZWWPresentTransitioning.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "ZWWPresentTransitioning.h"
#import "MaskView.h"//黑色遮罩视图

@implementation ZWWPresentTransitioning

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
    return 0.5;
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
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVc就是MenuViewController、fromVC就是ViewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    
    MaskView *maskView = [MaskView new];
    maskView.frame = toVC.view.frame;
    maskView.backgroundColor = [UIColor clearColor];
    
    [containerView addSubview:maskView];
    [containerView addSubview:toVC.view];

//    0.456为膜拜的那个图片比例
    toVC.view.frame = CGRectMake(-([[UIScreen mainScreen]bounds].size.height*0.456), 0, [[UIScreen mainScreen]bounds].size.height*0.456, containerView.frame.size.height);
    //开始动画，使用产生动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation([[UIScreen mainScreen]bounds].size.height*0.456, 0);
        maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            [maskView removeFromSuperview];
        }
    }];
}
//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //注意在dismiss的时候fromVC就是MenuViewController了，toVC才是ViewController了，注意这个关系
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是mask视图，我们将
    UIView *maskView = [transitionContext containerView].subviews[0];
    //动画吧
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        maskView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            [maskView removeFromSuperview];
        }
    }];
}





@end
