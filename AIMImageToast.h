//
//  AIMImageToast.h
//  GKRToast
//
//  Created by Maciej Gad on 18.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMToast.h"

@interface AIMImageToast : AIMToast
+ (void)show:(NSString *)text image:(UIImage *)image;
@end

@interface GKRToastConfigure (AIMImageToast)
@property (strong, nonatomic) UIImageView *imageView;
@end