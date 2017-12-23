//
//  MaskView.m
//  MoBikeMenuDemo
//
//  Created by EwenMac on 2017/12/17.
//  Copyright © 2017年 zww. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)tapClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MASKTAP" object:self];
}

- (void)handleGesture:(UIPanGestureRecognizer *)pan {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MASKPAN" object:pan];
    
}


@end
