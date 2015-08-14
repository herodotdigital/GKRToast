//
//  AIMToast.m
//
//  Created by Maciej Gad on 12.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMToast.h"

const CGFloat AIMToastStartScale = 0.001f;

@implementation AIMToast

+ (GKRToastConfigure *)configure {
    GKRToastConfigure *configure = [GKRToastConfigure new];

    [self setupContainer:configure];
    [self setupText:configure];
    [self setupShowAnimation:configure];
    [self setupHideAnimation:configure];
    
    return configure;
}

+ (void)setupContainer:(GKRToastConfigure *)configure {
    configure.textContainer.backgroundColor = [UIColor AIMToastBacgroundColor];
    configure.textContainer.layer.masksToBounds = YES;
}

+ (void)setupText:(GKRToastConfigure *)configure {
        configure.textLabel.textColor = [UIColor AIMToastTextColor];
}


+ (void)setupShowAnimation:(GKRToastConfigure *)configure {
    configure.animateShowLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        
        textContainer.transform = CGAffineTransformMakeScale(AIMToastStartScale, AIMToastStartScale);
        
        void (^animation)() = ^{
            textContainer.transform = CGAffineTransformIdentity;
        };
        
        [UIView AIMToastAnimation:animation completion:NULL];
    };
    configure.animateShowBackground = ^(UIView *background) {
        background.backgroundColor = [UIColor clearColor];
    };
}

+ (void)setupHideAnimation:(GKRToastConfigure *)configure {
    configure.animateHideLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        
        void (^animation)() = ^{
            textContainer.transform = CGAffineTransformMakeScale(AIMToastStartScale, AIMToastStartScale);
        };
        
        void (^completion)(BOOL) = ^(BOOL finished){
            [textContainer removeFromSuperview];
            textContainer.transform = CGAffineTransformIdentity;
        };
        [UIView AIMToastAnimation:animation completion:completion];
    };
}

@end

@implementation UIColor (AIMToastColor)

+ (UIColor *)AIMToastBacgroundColor {
    Class colorClass = [UIColor class];
    if ([colorClass respondsToSelector:@selector(activeColor)] ) {
        return [colorClass performSelector:@selector(activeColor)];
    } else {
        return  [UIColor colorWithRed:0.9647 green:0.3020 blue:0.0392 alpha:1.0000];
    }
}

+ (UIColor *)AIMToastTextColor {
    Class colorClass = [UIColor class];
    if ([colorClass respondsToSelector:@selector(lightMainColor)] ) {
        return [colorClass performSelector:@selector(lightMainColor)];
    } else {
        return [UIColor whiteColor];
    }
}

@end


@implementation UIView (AIMToastAnimation)

+ (void)AIMToastAnimation:(void (^)(void))animation completion:(void (^)(BOOL finished))completion {
    
    Class viewClass = [UIView class];
    if ([viewClass respondsToSelector:@selector(customAnimation:completion:)] ) {
        [viewClass performSelector:@selector(customAnimation:completion:) withObject:animation withObject:completion];
    } else {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:1.f options:0 animations:animation completion:completion];
    }
}

@end
