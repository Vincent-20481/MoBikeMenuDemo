//
//  ZWWVCTransitioningDelegate.h
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWWPresentTransitioning.h"
#import "ZWWInteractiveTransition.h"
@interface ZWWVCTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) ZWWInteractiveTransition *interactivePresent;
@property (nonatomic, strong) ZWWInteractiveTransition *interactiveDismiss;

@end
