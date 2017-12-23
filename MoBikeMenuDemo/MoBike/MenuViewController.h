//
//  MenuViewController.h
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWWInteractiveTransition.h"
#import "ZWWVCTransitioningDelegate.h"
@interface MenuViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)ZWWVCTransitioningDelegate *VCDelegate;

@end
