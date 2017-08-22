//
//  CircularImageLoader.h
//  ImageLoaderIndicator
//
//  Created by tom.zhu on 2017/8/22.
//  Copyright © 2017年 VPhotos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularImageLoader : UIView <CAAnimationDelegate>
@property (nonatomic, strong) CAShapeLayer *circlePathLayer;
@property (nonatomic, assign) CGFloat circleRadius;

@property (nonatomic, assign) CGFloat progress;

- (void)reveal;

@end
