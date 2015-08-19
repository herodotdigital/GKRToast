//
//  GKRToast.h
//
//  Created by Maciej Gad on 12.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"

@class GKRToastConfigure;


@interface GKRToast : NSObject

+ (void)show:(NSString *)text;
+ (void)hide;

+ (GKRToastConfigure *)configure;

+ (void)setConfiguration:(GKRToastConfigure *)config;
+ (GKRToastConfigure *)currentConfig;

@end

@interface GKRToastConfigure : NSObject

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *textContainer;
@property (strong, nonatomic) UILabel *textLabel;
@property (assign, nonatomic) UIEdgeInsets textEdgeInsets;

@property (strong, nonatomic) NSMutableDictionary *additionalConfig;

@property (assign, nonatomic) NSTimeInterval hideTimeOut;

@property (assign, nonatomic) BOOL hideOnTouch;

@property (copy, nonatomic) void(^setupContainer)();

@property (copy, nonatomic) void(^animateShowLabel)(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY);

@property (copy, nonatomic) void(^animateShowBackground)(UIView *backgroundView);

//remember to call [textLabel removeFromSuperview] and [textContainer removeFromSuperview] after animation is ended
@property (copy, nonatomic) void(^animateHideLabel)(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY);

//remember to call [backgroundView removeFromSuperview] after animation is ended
@property (copy, nonatomic) void(^animateHideBackground)(UIView *backgroundView);

@end
