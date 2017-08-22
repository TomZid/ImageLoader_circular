//
//  CircularImageLoader.m
//  ImageLoaderIndicator
//
//  Created by tom.zhu on 2017/8/22.
//  Copyright © 2017年 VPhotos. All rights reserved.
//

#import "CircularImageLoader.h"

@implementation CircularImageLoader
- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        self.circlePathLayer.strokeEnd = 0;
    }else if (progress > 0) {
        self.circlePathLayer.strokeEnd = 1;
    }else {
        self.circlePathLayer.strokeEnd = progress;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configure];
    }
    return self;
}

- (void)configure {
    self.circlePathLayer = [CAShapeLayer layer];
    self.circleRadius = 20;
    
    self.progress = 0;
    
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.lineWidth = 2;
    self.circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    self.circlePathLayer.strokeColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.circlePathLayer];
    self.backgroundColor = [UIColor whiteColor];
}

- (CGRect)circleFrame {
    CGRect circleFrame = CGRectMake(0, 0, 2 * _circleRadius, 2 * _circleRadius);
    CGRect circlePathBounds = _circlePathLayer.bounds;
    circleFrame.origin.x =  CGRectGetMidX(circlePathBounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(circlePathBounds) - CGRectGetMidY(circleFrame);
    return circleFrame;
}

- (UIBezierPath*)circlePath {
    return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}

- (void)reveal {
    self.backgroundColor = [UIColor clearColor];
    self.progress = 1;
    
//    [self.circlePathLayer removeAnimationForKey:@"strokeEnd"];
    
    [self.circlePathLayer removeFromSuperlayer];
    self.superview.layer.mask = self.circlePathLayer;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat finalRadius = sqrtf(center.x * center.x + center.y * center.y);
    CGFloat radiusInset = finalRadius - self.circleRadius;
    CGRect outerRect = CGRectInset([self circleFrame], -radiusInset, -radiusInset);
    CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;
    
    CGPathRef fromPath = self.circlePathLayer.path;
    CGFloat fromLineWidth = self.circlePathLayer.lineWidth;
    
    [CATransaction begin];
    [CATransaction setValue:@(true) forKey:kCATransactionDisableActions];
    self.circlePathLayer.lineWidth = finalRadius;
    self.circlePathLayer.path = toPath;
    
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = @(fromLineWidth);
    lineWidthAnimation.toValue = @(2 * finalRadius);
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(fromPath);
    pathAnimation.toValue = (__bridge id _Nullable)(toPath);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup new];
    groupAnimation.duration = 1;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
    groupAnimation.delegate = self;
    [self.circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.path = [self circlePath].CGPath;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.superview.layer.mask = nil;
}
@end
