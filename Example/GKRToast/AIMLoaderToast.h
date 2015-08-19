//
//  AIMLoaderToast.h
//  GKRToast
//
//  Created by Maciej Gad on 19.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMToast.h"
#import "FLAnimatedImageView.h"

@interface AIMLoaderToast : AIMToast

+ (void)show:(NSString *)text gifName:(NSString *)name;

@end


@interface GKRToastConfigure (AIMLoaderToast)
@property (strong, nonatomic) FLAnimatedImageView *loaderView;
@end