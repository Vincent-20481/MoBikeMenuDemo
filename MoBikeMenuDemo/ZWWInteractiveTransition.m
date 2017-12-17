//
//  ZWWInteractiveTransition.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "ZWWInteractiveTransition.h"

@interface ZWWInteractiveTransition()

@property (nonatomic, weak) UIViewController *vc;
/**手势方向*/
@property (nonatomic, assign) ZWWInteractiveTransitionGestureDirection direction;
/**手势类型*/
@property (nonatomic, assign) ZWWInteractiveTransitionType type;

@end

@implementation ZWWInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(ZWWInteractiveTransitionType)type GestureDirection:(ZWWInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(ZWWInteractiveTransitionType)type GestureDirection:(ZWWInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mask_tap:) name:@"MASKTAP" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mask_handleHiddenPan:) name:@"MASKPAN" object:nil];
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}


/**
 遮罩滑动

 @param note 携带参数
 */
- (void)mask_handleHiddenPan:(NSNotification *)note {
    UIPanGestureRecognizer *pan = note.object;
    [self handleGesture:pan];
}

/**
 遮罩点击
 
 @param note 携带参数
 */
- (void)mask_tap:(NSNotification *)note {
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case ZWWInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case ZWWInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case ZWWInteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case ZWWInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            persent = fminf(fmaxf(persent, 0.001), 1.0);
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.33) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}


- (void)startGesture{
    switch (_type) {
        case ZWWInteractiveTransitionTypePresent:{
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
            
        case ZWWInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case ZWWInteractiveTransitionTypePush:{
            if (_pushConifg) {
                _pushConifg();
            }
        }
            break;
        case ZWWInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}



@end
