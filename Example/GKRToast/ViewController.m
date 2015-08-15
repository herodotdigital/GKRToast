//
//  ViewController.m
//
//  Created by Maciej Gad on 12.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "ViewController.h"
#import "GKRToast.h"
#import "AIMToast.h"
#import "AIMFancyToast.h"
#import "CustomToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showDefaultNotification:(UIButton *)sender {
    [GKRToast show:[sender titleForState:UIControlStateNormal]];
}


- (IBAction)showCustomNotification:(UIButton *)sender {
    [AIMToast show:[sender titleForState:UIControlStateNormal]];
}

- (IBAction)showComplexAnimationNotification:(UIButton *)sender {
    [AIMFancyToast show:[sender titleForState:UIControlStateNormal]];
}

- (IBAction)showCustomSimpleNotification:(UIButton *)sender {
    [CustomToast show:[sender titleForState:UIControlStateNormal]];
}

@end
