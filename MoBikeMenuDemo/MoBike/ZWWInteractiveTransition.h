//
//  ZWWInteractiveTransition.h
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConifg)(void);

typedef NS_ENUM(NSUInteger, ZWWInteractiveTransitionGestureDirection) {//手势的方向
    ZWWInteractiveTransitionGestureDirectionLeft = 0,
    ZWWInteractiveTransitionGestureDirectionRight,
    ZWWInteractiveTransitionGestureDirectionUp,
    ZWWInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, ZWWInteractiveTransitionType) {//手势控制哪种转场
    ZWWInteractiveTransitionTypePresent = 0,
    ZWWInteractiveTransitionTypeDismiss,
    ZWWInteractiveTransitionTypePush,
    ZWWInteractiveTransitionTypePop,
};

@interface ZWWInteractiveTransition : UIPercentDrivenInteractiveTransition

/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg pushConifg;

//初始化方法

+ (instancetype)interactiveTransitionWithTransitionType:(ZWWInteractiveTransitionType)type GestureDirection:(ZWWInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(ZWWInteractiveTransitionType)type GestureDirection:(ZWWInteractiveTransitionGestureDirection)direction;


/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;


@end
