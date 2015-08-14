//
//  GKRToast.m
//
//  Created by Maciej Gad on 12.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GKRToast.h"

@interface UIApplication (GKRToast)

+ (UIWindow*)GKRToasttWindow;

@end


@interface GKRToast ()

@property (strong, nonatomic) GKRToastConfigure *config;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIView *textContainer;
@property (strong, nonatomic) UITapGestureRecognizer *backgroundGesture;
@property (strong, nonatomic) UITapGestureRecognizer *textLabelGesture;
@property (readonly, nonatomic) UIWindow *window;
@property (strong, nonatomic) MASConstraint *centerX;
@property (strong, nonatomic) MASConstraint *centerY;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *configuredForClass;
@end

@implementation GKRToast

+ (instancetype)sharedInstance {
    static GKRToast *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GKRToast alloc] init];
    });
    return instance;
}

+ (void)setupNewConfig {
    GKRToastConfigure *config = [self configure];
    [self setConfiguration:config];
}

+ (GKRToastConfigure *)configure {
    return [GKRToastConfigure new];
}

+ (void)setConfiguration:(GKRToastConfigure *)config {
    [GKRToast sharedInstance].configuredForClass = NSStringFromClass(self);
    [GKRToast sharedInstance].config = config;
}


+ (void)show:(NSString *)text {
    GKRToast *toast = [self sharedInstance];
    [self configureIfNeeded];
    [toast show:text];
}

+ (void)configureIfNeeded {
    NSString *currentClass = NSStringFromClass(self);
    NSString *currentlyConfiguredForClass = [GKRToast sharedInstance].configuredForClass;
    if (![currentlyConfiguredForClass isEqualToString:currentClass]) {
        [self setupNewConfig];
    }
}

- (void)show:(NSString *)text {
    [self setupTextContainer];
    [self setupTextLabel:text];
    [self setupBackgroundView];
    [self animations];
    [self startTimer];
}

- (void)setupTextContainer {
    self.textContainer = self.config.textContainer;
    [self.window addSubview:self.textContainer];
    UIView *superview = self.window;
    [self.textContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        self.centerX = make.centerX.equalTo(superview.mas_centerX);
        self.centerY = make.centerY.equalTo(superview.mas_centerY);
        make.width.lessThanOrEqualTo(superview.mas_width).and.multipliedBy(0.8f);
        make.height.lessThanOrEqualTo(superview.mas_height).and.multipliedBy(0.8f);
    }];
    [self.textContainer addGestureRecognizer:self.textLabelGesture];
}

- (void)setupTextLabel:(NSString *)text {
    self.textLabel = self.config.textLabel;
    self.textLabel.text = text;
    [self.textContainer addSubview:self.textLabel];
    UIView *superview = self.textContainer;
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).insets(self.config.textEdgeInsets);
    }];
    [self.textLabel addGestureRecognizer:self.textLabelGesture];
}

- (void)setupBackgroundView {
    self.backgroundView = self.config.backgroundView;
    [self.window addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView.superview.mas_top);
        make.left.equalTo(self.backgroundView.superview.mas_left);
        make.bottom.equalTo(self.backgroundView.superview.mas_bottom);
        make.right.equalTo(self.backgroundView.superview.mas_right);
    }];
    [self.backgroundView addGestureRecognizer:self.backgroundGesture];
}

- (void)animations {
    if (self.config.animateShowLabel) {
        self.config.animateShowLabel(self.textContainer, self.textLabel, self.centerX, self.centerY);
    }
    if (self.config.animateShowBackground) {
        self.config.animateShowBackground(self.backgroundView);
    }
}

- (void)startTimer {
    [self.timer invalidate];
    if (self.config.hideTimeOut > 0.f) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.config.hideTimeOut target:self selector:@selector(hide) userInfo:nil repeats:NO];
    }
}

- (void)hide{
    if (self.config.animateHideBackground) {
        self.config.animateHideBackground(self.backgroundView);
    } else {
        [self.backgroundView removeFromSuperview];
    }
    if (self.config.animateHideLabel) {
        self.config.animateHideLabel(self.textContainer, self.textLabel, self.centerX, self.centerY);
    } else {
        [self.textLabel removeFromSuperview];
    }
}

#pragma mark - setters & getters

- (void)setBackgroundView:(UIView *)backgroundView {
    [_backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    [backgroundView removeFromSuperview];
}

- (void)setTextLabel:(UILabel *)textLabel {
    [_textLabel removeFromSuperview];
    _textLabel = textLabel;
    [textLabel removeFromSuperview];
}

- (void)setTextContainer:(UIView *)textContainer {
    [_textContainer removeFromSuperview];
    _textContainer = textContainer;
    [textContainer removeFromSuperview];
}

- (UITapGestureRecognizer *)backgroundGesture {
    if (_backgroundGesture) {
        return _backgroundGesture;
    }
    _backgroundGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    return _backgroundGesture;
}

- (UITapGestureRecognizer *)textLabelGesture {
    if (_textLabelGesture) {
        return _textLabelGesture;
    }
    _textLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    return _textLabelGesture;
}


- (UIWindow *)window {
   return [UIApplication GKRToasttWindow];
}

@end

@implementation GKRToastConfigure

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textEdgeInsets = (UIEdgeInsets){10, 10, 10, 10};
        self.hideTimeOut = 5.0f;
    }
    return self;
}

- (UILabel *)textLabel {
    if (_textLabel) {
        return _textLabel;
    }
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.numberOfLines = 0;
    return _textLabel;
}

- (UIView *)backgroundView {
    if (_backgroundView) {
        return _backgroundView;
    }
    _backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.300];
    return _backgroundView;
}

- (UIView *)textContainer {
    if (_textContainer) {
        return _textContainer;
    }
    _textContainer = [[UIView alloc] init];
    _textContainer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
    _textContainer.layer.cornerRadius = 5.0f;
    return _textContainer;
}

- (void(^)(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY))animateShowLabel {
    if (_animateShowLabel) {
        return _animateShowLabel;
    }
    _animateShowLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY) {
        textContainer.alpha = 0.0f;
        [UIView animateWithDuration:0.5f animations:^{
            textContainer.alpha = 1.0f;
        }];
    };
    return _animateShowLabel;
}

- (void(^)(UIView *textContainer, UILabel *textField, MASConstraint *centerX, MASConstraint *centerY))animateHideLabel {
    if (_animateHideLabel) {
        return _animateHideLabel;
    }
    _animateHideLabel = ^(UIView *textContainer, UILabel *textLabel, MASConstraint *centerX, MASConstraint *centerY){
        [UIView animateWithDuration:0.5f animations:^{
            textContainer.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [textContainer removeFromSuperview];
            textContainer.alpha = 1.0f;
        }];
    };
    return _animateHideLabel;
}


- (void(^)(UIView *background))animateShowBackground {
    if (_animateShowBackground) {
        return _animateShowBackground;
    }
    _animateShowBackground = ^(UIView *view) {
        view.alpha = 0.0f;
        [UIView animateWithDuration:0.5f animations:^{
            view.alpha = 1.0f;
        }];
    };
    return _animateShowBackground;
}

- (void(^)(UIView *background))animateHideBackground {
    if (_animateHideBackground) {
        return _animateHideBackground;
    }
    _animateHideBackground = ^(UIView *background){
        [UIView animateWithDuration:0.5f animations:^{
            background.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [background removeFromSuperview];
            background.alpha = 1.0f;
        }];
    };
    return _animateHideBackground;
}

@end

@implementation UIApplication (GKRToast)

+ (UIWindow*)GKRToasttWindow {
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    if (window == nil) {
        NSArray* windows = [[UIApplication sharedApplication] windows];
        if ([windows count]) {
            return [windows firstObject];
        }
    }
    return window;
}
@end

