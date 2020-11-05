//
//  LineProgress.m
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/3/28.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "LineProgress.h"
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height
@interface LineProgress ()
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CGFloat progressLineWidth;
@property (nonatomic, assign) CGFloat  borderWidth;
@end

@implementation LineProgress

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _borderWidth = 1;
        _progressLineWidth = kSelfHeight - _borderWidth*2-4;
        self.layer.borderColor = UIColor.whiteColor.CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor systemPinkColor];
        _progress = 0;
        [self.layer addSublayer:self.progressLayer];
        [self p_drawProgress];
    }
    return self;
}
- (void)p_drawProgress{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_borderWidth + 1, kSelfHeight/2.0)];
    [path addLineToPoint:CGPointMake((kSelfWidth - _borderWidth - 1)*_progress/100.0, kSelfHeight/2.0)];
    self.progressLayer.path = path.CGPath;
}
- (void)setProgress:(CGFloat)progress {
    if (_progress != progress) {
        _progress = (progress > 100 ? 100 : progress);
        [self p_drawProgress];
    }
}
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 1;
        _progressLayer.lineWidth = _progressLineWidth;
        _progressLayer.lineDashPattern = @[@(3),@(3)];
    }
    return _progressLayer;
}

@end
