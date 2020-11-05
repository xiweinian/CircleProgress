//
//  GradientCircleProgressView.m
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/4/13.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "GradientCircleProgressView.h"
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height
@interface GradientCircleProgressView()
@property (nonatomic, strong) UILabel *inforLabel;
/// 渐变色 layer
@property (nonatomic, strong) CAGradientLayer *progressGradientLayer;
/// 底色 layer
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
/// 进度遮罩layer   加在渐变 层上的mask
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end

@implementation GradientCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _startAngle = 0;
        _isClockwise = YES;
        _lineWidth = 4;
        _shouldWithDashPattern = NO;
        _dashPattern = @[@(2),@(2)];
        _lineCap = kCALineCapRound;
        _maxTintColor = [UIColor grayColor];
        _startAngle = 0;
        _showBottomProgress = YES;
        _progressColors = @[(id)UIColor.orangeColor.CGColor,(id)UIColor.redColor.CGColor];
        [self.layer addSublayer:self.bottomLayer];
        [self.layer addSublayer:self.progressGradientLayer];
        [self addSubview:self.inforLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomLayer.frame = self.bounds;
    self.progressLayer.frame = self.bounds;
    self.progressGradientLayer.frame = self.bounds;
    [self p_drawBottom];
    _inforLabel.frame = self.bounds;
}

/// 重绘
- (void)redrawProgress {
    [self p_drawBottom];
    [self p_drawProgress];
}

/// 绘制进度mask
- (void)p_drawProgress {
    CGPoint center = CGPointMake(kSelfWidth/2.0, kSelfHeight/2.0);
    CGFloat radius = kSelfWidth/2.0-_lineWidth/2.0;
    CGFloat endAngle = M_PI * 2 *_progress + _startAngle;
    if (!_isClockwise) {
        endAngle = _startAngle - M_PI * 2 *_progress;
    }
    self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:endAngle clockwise:_isClockwise].CGPath;
}

/// 绘制底色layer
- (void)p_drawBottom {
    CGPoint center = CGPointMake(kSelfWidth/2.0, kSelfHeight/2.0);
    CGFloat radius = kSelfWidth/2.0-_lineWidth/2.0;
    CGFloat endAngle = M_PI * 2 + _startAngle;
    if (!_isClockwise) {
        endAngle = _startAngle - M_PI * 2;
    }
    self.bottomLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:_startAngle endAngle:endAngle clockwise:_isClockwise].CGPath;
}


#pragma mark - Public Methods
- (void)setProgressGradientLayerHandle:(void (^)(CAGradientLayer * _Nonnull))handle {
    if (handle) {
        handle(self.progressGradientLayer);
    }
}
- (void)setProgressLayerHandle:(void (^)(CAShapeLayer * _Nonnull))handle {
    if (handle) {
        handle(self.progressLayer);
        [self p_drawProgress];
    }
}
- (void)setBottomLayerHandle:(void (^)(CAShapeLayer * _Nonnull))handle {
    if (handle) {
        handle(self.bottomLayer);
        [self p_drawBottom];
    }
}
#pragma mark - setterMethods
- (void)setProgressColors:(NSArray *)progressColors {
    _progressColors = progressColors.copy;
    self.progressGradientLayer.colors = progressColors;
}
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.bottomLayer.lineWidth = _lineWidth;
    self.progressLayer.lineWidth = _lineWidth;
    [self redrawProgress];
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.inforLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(_progress*100)%101];
    [self p_drawProgress];
}
- (void)setShouldWithDashPattern:(BOOL)shouldWithDashPattern {
    _shouldWithDashPattern = shouldWithDashPattern;
    if (_shouldWithDashPattern && _dashPattern.count) {
        self.progressLayer.lineDashPattern = _dashPattern;
        self.bottomLayer.lineDashPattern = _dashPattern;
    } else {
        self.progressLayer.lineDashPattern = nil;
        self.bottomLayer.lineDashPattern = nil;
    }
    [self redrawProgress];
}
- (void)setDashPattern:(NSArray *)dashPattern {
    _dashPattern = [dashPattern copy];
    if (_shouldWithDashPattern && _dashPattern.count) {
        self.progressLayer.lineDashPattern = _dashPattern;
        self.bottomLayer.lineDashPattern = _dashPattern;
    } else {
        self.progressLayer.lineDashPattern = nil;
        self.bottomLayer.lineDashPattern = nil;
    }
    [self redrawProgress];
}
- (void)setLineCap:(CAShapeLayerLineCap)lineCap {
    _lineCap = [lineCap copy];
    self.progressLayer.lineCap = _lineCap;
    self.bottomLayer.lineCap = _lineCap;
    [self redrawProgress];
}
- (void)setMaxTintColor:(UIColor *)maxTintColor {
    _maxTintColor = maxTintColor;
    self.bottomLayer.strokeColor = _maxTintColor.CGColor;
    [self p_drawBottom];
}
- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self redrawProgress];
}
- (void)setIsClockwise:(BOOL)isClockwise {
    _isClockwise = isClockwise;
    [self redrawProgress];
}
- (void)setShowBottomProgress:(BOOL)showBottomProgress {
    _showBottomProgress = showBottomProgress;
    self.bottomLayer.hidden = !_showBottomProgress;
}
#pragma mark - getterMethods
- (CAShapeLayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        _bottomLayer.lineWidth = _lineWidth;
        _bottomLayer.lineCap = _lineCap;
        _bottomLayer.strokeStart = 0;
        _bottomLayer.strokeEnd = 1;
        _bottomLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomLayer.strokeColor = _maxTintColor.CGColor;
        _bottomLayer.hidden = !_showBottomProgress;
    }
    return _bottomLayer;
}
- (CAGradientLayer *)progressGradientLayer {
    if (!_progressGradientLayer) {
        _progressGradientLayer = [CAGradientLayer layer];
        _progressGradientLayer.startPoint = CGPointZero;
        _progressGradientLayer.endPoint = CGPointMake(1, 1);
        _progressGradientLayer.locations = @[@(0),@(1)];
        _progressGradientLayer.colors = _progressColors;
        self.progressGradientLayer.mask=  self.progressLayer;
    }
    return _progressGradientLayer;
}
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.lineWidth = _lineWidth;
        _progressLayer.lineCap = _lineCap;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 1;
        _progressLayer.strokeColor = UIColor.greenColor.CGColor;
        _progressLayer.fillColor = UIColor.clearColor.CGColor;
    }
    return _progressLayer;
}
- (UILabel *)inforLabel {
    if (!_inforLabel) {
        _inforLabel = [[UILabel alloc] init];
        _inforLabel.textColor = [UIColor redColor];
        _inforLabel.font = [UIFont systemFontOfSize:20];
        _inforLabel.numberOfLines = 0;
        _inforLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(_progress*100)%101];
        _inforLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _inforLabel;
}
@end
