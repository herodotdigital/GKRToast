//
//  AIMFancyToast.h
//
//  Created by Maciej Gad on 15.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMToast.h"

@interface AIMFancyToast : AIMToast

@end

@interface UIColor (AIMToastInactiveColor)

+ (UIColor *)AIMToastBacgroundIactiveColor;

@end

@protocol AIMAppInactiveColors <AIMAppColors>

+ (UIColor *)inactiveColor;

@end
