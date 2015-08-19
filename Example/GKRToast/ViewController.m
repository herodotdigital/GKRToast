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
#import "AIMImageToast.h"
#import "AIMLoader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

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

- (IBAction)showImageNotification:(UIButton *)sender {
    [AIMImageToast show:[sender titleForState:UIControlStateNormal] image:[UIImage imageNamed:@"logo"]];
}

- (IBAction)showLoader:(UIButton *)sender {
    [AIMLoader show:[sender titleForState:UIControlStateNormal] gifName:@"animation"];
    [self performSelector:@selector(hide) withObject:nil afterDelay:10.0f];
}

- (void)hide {
    [AIMLoader hide];
}

@end
