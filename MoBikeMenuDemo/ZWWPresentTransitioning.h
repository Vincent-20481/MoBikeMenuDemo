//
//  ZWWPresentTransitioning.h
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZWWPresentTransitionType){
    ZWWPresentTransitionTypePresent = 0,//管理present动画
    ZWWPresentTransitionTypeDismiss//管理dismiss动画
};

@interface ZWWPresentTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) ZWWPresentTransitionType type;

//根据定义的枚举初始化的两个方法
+ (instancetype)transitionWithTransitionType:(ZWWPresentTransitionType)type;
- (instancetype)initWithTransitionType:(ZWWPresentTransitionType)type;



@end
