//
//  AIMLoader.m
//  GKRToast
//
//  Created by Maciej Gad on 19.08.2015.
//  Copyright (c) 2015 All in Mobile. All rights reserved.
//

#import "AIMLoader.h"
#import "FLAnimatedImage.h"

@implementation AIMLoader

+ (void)show:(NSString *)text gifName:(NSString *)name {
    GKRToastConfigure *config = [self currentConfig];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:name ofType:@"gif"];
    if (path) {
        NSData *gifData = [NSData dataWithContentsOfFile:path];
        config.loaderView.animatedImage =[FLAnimatedImage animatedImageWithGIFData:gifData];
    } else {
        config.loaderView.animatedImage = nil;
    }
    //    ;
    [super show:text];
}

+ (GKRToastConfigure *)configure {
    GKRToastConfigure *config = [super configure];
    
    config.loaderView = [[FLAnimatedImageView alloc] init];
    config.loaderView.contentMode = UIViewContentModeScaleAspectFit;
    config.textContainer.backgroundColor = [UIColor clearColor];
//    config.hideOnTouch = NO;
    config.hideTimeOut = 0.0f;
    __weak __typeof(config) weakConfig = config;
    config.setupContainer = ^{
        [weakConfig.textContainer addSubview:weakConfig.loaderView];
        [weakConfig.loaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakConfig.textContainer.mas_top).with.offset(weakConfig.textEdgeInsets.top);
            make.left.equalTo(weakConfig.textContainer.mas_left).with.offset(weakConfig.textEdgeInsets.left);
            make.right.equalTo(weakConfig.textContainer.mas_right).with.offset(-weakConfig.textEdgeInsets.right);
        }];
        UIView *textMargin = [UIView new];
        textMargin.backgroundColor = [UIColor AIMToastBacgroundColor];
        [textMargin addSubview:weakConfig.textLabel];
        
        [weakConfig.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(textMargin).with.insets(weakConfig.textEdgeInsets);
            
        }];
        [weakConfig.textContainer addSubview:textMargin];
        [textMargin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakConfig.loaderView.mas_bottom).with.offset(weakConfig.textEdgeInsets.top);
            make.left.equalTo(weakConfig.textContainer.mas_left).with.offset(weakConfig.textEdgeInsets.left);
            make.right.equalTo(weakConfig.textContainer.mas_right).with.offset(-weakConfig.textEdgeInsets.right);
            make.bottom.equalTo(weakConfig.textContainer.mas_bottom).with.offset(-weakConfig.textEdgeInsets.bottom);
        }];
    };
    
    return config;
}

@end


@implementation GKRToastConfigure (AIMLoader)

- (void)setLoaderView:(FLAnimatedImageView *)loaderView{
    [self.additionalConfig setObject:loaderView forKey:@"loaderView"];
}

- (FLAnimatedImageView *)loaderView {
    return [self.additionalConfig objectForKey:@"loaderView"];
}

@end
