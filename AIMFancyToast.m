//
//  AIMFancyToast.m
//
//  Created by Maciej Gad on 15.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMFancyToast.h"

@implementation AIMFancyToast

+ (GKRToastConfigure *)configure {
    GKRToastConfigure *configure = [super configure];
    
    UIColor *activeColor = [UIColor AIMToastBacgroundColor];
    UIColor *inactiveColor = [UIColor AIMToastBacgroundIactiveColor];
    
    CGFloat offset = CGRectGetHeight([UIScreen mainScreen].bounds) * 0.5f;
    CGAffineTransform transform = CGAffineTransformMakeScale(AIMToastStartScale, AIMToastStartScale);
    transform = CGAffineTransformRotate(transform, M_PI);
    
    
    configure.hideTimeOut = 3.f;
    
    configure.animateShowLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        
        centerY.offset = offset;
        textContainer.transform = transform;
        [textContainer layoutIfNeeded];
        
        centerY.offset = 0;
        [UIView AIMToastAnimation:^{
            [textContainer layoutIfNeeded];
            textContainer.transform = CGAffineTransformIdentity;
        } completion:NULL];
        
        [UIView animateWithDuration:3.f animations:^{
            textContainer.layer.backgroundColor = inactiveColor.CGColor;
        }];
        
    };
    
    configure.animateHideLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        centerY.offset = -offset;
        [UIView AIMToastAnimation:^{
            [textContainer layoutIfNeeded];
            textContainer.transform = transform;
        } completion:^(BOOL finished) {
            textContainer.transform = CGAffineTransformIdentity;
            textContainer.layer.backgroundColor = activeColor.CGColor;
            [textContainer removeFromSuperview];
        }];
    };
    
    return configure;
}

@end

@implementation UIColor (AIMToastInactiveColor)

+ (UIColor *)AIMToastBacgroundIactiveColor {
    Class colorClass = [UIColor class];
    if ([colorClass respondsToSelector:@selector(inactiveColor)] ) {
        return [colorClass performSelector:@selector(inactiveColor)];
    } else {
        return  [UIColor colorWithRed:0.5647 green:0.5373 blue:0.5373 alpha:1.0000];
    }
}

@end