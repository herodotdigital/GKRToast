//
//  AIMLoader.h
//  GKRToast
//
//  Created by Maciej Gad on 19.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMToast.h"
#import "FLAnimatedImageView.h"

@protocol AIMLoderColor <NSObject>
+ (UIColor *)loaderTextBackground;
@end

@interface AIMLoader : AIMToast
+ (void)show:(NSString *)text gifName:(NSString *)name;
@end

@interface UIColor (AIMLoader)

+ (UIColor *)AIMLoaderTextBackground;

@end

@interface GKRToastConfigure (AIMLoader)
@property (strong, nonatomic) FLAnimatedImageView *loaderView;
@end