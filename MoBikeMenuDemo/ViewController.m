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
@interface ViewController ()
@property(nonatomic,strong)ZWWInteractiveTransition *interactivePresent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePresent = [ZWWInteractiveTransition interactiveTransitionWithTransitionType:ZWWInteractiveTransitionTypePresent GestureDirection:ZWWInteractiveTransitionGestureDirectionRight];
    typeof(self)weakSelf = self;
    self.interactivePresent.presentConifg = ^(){
        [weakSelf setting:nil];
    };
    [self.interactivePresent addPanGestureForViewController:self];
}
- (IBAction)setting:(id)sender {
    MenuViewController *menu = [MenuViewController new];
    menu.VCDelegate.interactivePresent = self.interactivePresent;
    [self presentViewController:menu animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
