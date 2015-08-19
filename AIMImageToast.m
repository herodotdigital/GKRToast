//
//  AIMImageToast.m
//  GKRToast
//
//  Created by Maciej Gad on 18.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMImageToast.h"

@implementation AIMImageToast

+ (void)show:(NSString *)text image:(UIImage *)image {
    GKRToastConfigure *config = [self currentConfig];
    config.imageView.image = image;
    [super show:text];
}

+ (GKRToastConfigure *)configure {
    GKRToastConfigure *config = [super configure];

    config.imageView = [[UIImageView alloc] init];
    config.imageView.contentMode = UIViewContentModeScaleAspectFit;
    __weak __typeof(config) weakConfig = config;
    config.setupContainer = ^{
        [weakConfig.textContainer addSubview:weakConfig.imageView];
        
        [weakConfig.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakConfig.textContainer.mas_top).with.offset(weakConfig.textEdgeInsets.top);
            make.left.equalTo(weakConfig.textContainer.mas_left).with.offset(weakConfig.textEdgeInsets.left);
            make.right.equalTo(weakConfig.textContainer.mas_right).with.offset(-weakConfig.textEdgeInsets.right);
        }];

        [weakConfig.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakConfig.imageView.mas_bottom).with.offset(weakConfig.textEdgeInsets.top);
            make.left.equalTo(weakConfig.textContainer.mas_left).with.offset(weakConfig.textEdgeInsets.left);
            make.right.equalTo(weakConfig.textContainer.mas_right).with.offset(-weakConfig.textEdgeInsets.right);
            make.bottom.equalTo(weakConfig.textContainer.mas_bottom).with.offset(-weakConfig.textEdgeInsets.bottom);
        }];
    };
    
    return config;
}

@end

@implementation GKRToastConfigure (AIMImageToast)

- (void)setImageView:(UIImageView *)imageView {
    [self.additionalConfig setObject:imageView forKey:@"imageView"];
}

- (UIImageView *)imageView {
    return [self.additionalConfig objectForKey:@"imageView"];
}

@end
