//
//  AIMToast.h
//
//  Created by Maciej Gad on 12.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "GKRToast.h"

@interface AIMToast : GKRToast

@end

extern const CGFloat AIMToastStartScale;

@interface UIColor (AIMToastColor)

+ (UIColor *)AIMToastBacgroundColor;
+ (UIColor *)AIMToastTextColor;

@end

@interface UIView (AIMToastAnimation)

+ (void)AIMToastAnimation:(void (^)(void))animation completion:(void (^)(BOOL finished))completion;

@end

@protocol AIMAppColors <NSObject>

+ (UIColor *)activeColor;
+ (UIColor *)lightMainColor;

@end

@protocol AIMAnimations <NSObject>

+ (void)customAnimation:(void (^)(void))animation completion:(void (^)(BOOL finished))completion;

@end

