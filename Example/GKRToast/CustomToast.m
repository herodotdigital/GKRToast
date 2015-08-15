//
//  CustomToast.m
//  GKRToast
//
//  Created by Maciej Gad on 15.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "CustomToast.h"

@implementation CustomToast

+ (GKRToastConfigure *)configure {
    GKRToastConfigure *configure = [GKRToastConfigure new];
    
    CGFloat offset = CGRectGetWidth([UIScreen mainScreen].bounds) * 0.5f + 100;
    
    configure.animateShowLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        centerX.offset = -offset;
        [textContainer layoutIfNeeded];
        centerX.offset = 0;
        [UIView animateWithDuration:1.0f animations:^{
            [textContainer layoutIfNeeded];
        }];
    };
    return configure;
};

@end
