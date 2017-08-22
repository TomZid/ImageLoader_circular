//
//  VPImageView.m
//  ImageLoader_circular
//
//  Created by tom.zhu on 2017/8/22.
//  Copyright © 2017年 zhb111lizhb111xi@gmail.com. All rights reserved.
//

#import "VPImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CircularImageLoader.h"

@implementation VPImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        CircularImageLoader *loadingView = [[CircularImageLoader alloc] initWithFrame:CGRectZero];
        [self addSubview:loadingView];
        
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                               ]
         ];
        loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSURL *url = [NSURL URLWithString:@"https://koenig-media.raywenderlich.com/uploads/2015/02/mac-glasses.jpeg"];
        
        [self sd_setImageWithURL:url placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            [loadingView setProgress:(CGFloat)receivedSize / (CGFloat)expectedSize];
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [loadingView reveal];
        }];

        
    }
    return self;
}

@end
