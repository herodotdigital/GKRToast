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

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showDefaultNotification:(UIButton *)sender {
    [GKRToast show:[sender titleForState:UIControlStateNormal]];
}


- (IBAction)showCustomNotification:(id)sender {
    [AIMToast show:[sender titleForState:UIControlStateNormal]];
}

- (IBAction)showComplexAnimationNotification:(id)sender {
    [AIMFancyToast show:[sender titleForState:UIControlStateNormal]];
}



@end
