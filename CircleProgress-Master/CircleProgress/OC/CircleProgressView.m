//
//  CircleProgressView.m
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/3/26.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "CircleProgressView.h"
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height
@interface CircleProgressView ()
/** progressLayer*/
@property (nonatomic, strong) CAShapeLayer *progressLayer;
/** underRoundLayer*/
@property (nonatomic, strong) CAShapeLayer *underRoundLayer;
/** progressLabel*/
@property (nonatomic, strong) UILabel *progressLabel;

@end


@implementation CircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _showInfoLabel = YES;
        _progress = 0.00;
        _progressColor = [UIColor redColor];
        _progressLabelColor = [UIColor redColor];
        _underRoundColor = [UIColor grayColor];
        _completeText = @"√\ncomplete";
        _progressAppendText = @"\nexporting...";
        _borderWidth = 4;
        _showUnderRound = YES;
        _progressWithDashline = YES;
        _lineDashPattern = @[@(2),@(2)];
        _progressInfoFont = [UIFont systemFontOfSize:12];
        _clockwise = YES;
        [self.layer addSublayer:self.underRoundLayer];
        [self.layer addSublayer:self.progressLayer];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.progressLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = kSelfHeight/2.0;
    self.progressLabel.frame = CGRectMake(5, 5, kSelfWidth-10, kSelfHeight-10);
    [self p_drawUnderRound];
}
- (void)p_drawProgress {
    if (_clockwise) {
        CGFloat endAngle = _progress / 100 * M_PI * 2 - M_PI / 2;
        CGPoint center = CGPointMake(kSelfWidth/2.0, kSelfHeight/2.0);
        CGFloat radius = kSelfWidth/2.0-_borderWidth/2.0;
        UIBezierPath *loopPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:M_PI*3/2
                                                              endAngle:endAngle
                                                             clockwise:_clockwise];
        self.progressLayer.path = loopPath.CGPath;
    } else {
        CGFloat endAngle =  - (_progress / 100 * M_PI * 2 - M_PI / 2);
        CGPoint center = CGPointMake(kSelfWidth/2.0, kSelfHeight/2.0);
        CGFloat radius = kSelfWidth/2.0-_borderWidth/2.0;
        UIBezierPath *loopPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:M_PI/2
                                                              endAngle:endAngle
                                                             clockwise:_clockwise];
        self.progressLayer.path = loopPath.CGPath;
    }
    
}
- (void)p_drawUnderRound {
    if (_clockwise) {
        CGPoint center = CGPointMake(kSelfWidth/2.0, kSelfHeight/2.0);
        CGFloat radius = kSelfWidth/2.0-_borderWidth/2.0;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, kSelfWidth, kSelfHeight);
        UIBezierPath *loopPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:M_PI*3/2
                                                              endAngle:M_PI*3/2-0.01
                                                             clockwise:_clockwise];
        self.underRoundLayer.path = loopPath.CGPath;
    } else {
        CGPoint center = CGPointMake(kSelfWidth/2.0, kSelfHeight/2.0);
        CGFloat radius = kSelfWidth/2.0-_borderWidth/2.0;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, kSelfWidth, kSelfHeight);
        UIBezierPath *loopPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:M_PI/2
                                                              endAngle:-(M_PI*3/2-0.01)
                                                             clockwise:_clockwise];
        self.underRoundLayer.path = loopPath.CGPath;
    }
    
}
#pragma mark - setterMethods
- (void)setProgress:(CGFloat)progress {
    if (_progress != progress) {
        _progress = progress;
        if (_progress >= 100) {
            _progress = 99.9;
            self.progressLabel.text = _completeText;
            if (self.completeBlock) {
                self.completeBlock();
            }
        } else {
            self.progressLabel.text = [NSString stringWithFormat:@"%ld%%%@",(long)_progress,_progressAppendText];
        }
        [self p_drawProgress];
    }
}
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = _progressColor.CGColor;
    [self p_drawProgress];
}
- (void)setProgressLabelColor:(UIColor *)progressLabelColor {
    _progressLabelColor = progressLabelColor;
    self.progressLabel.textColor = _progressLabelColor;
}
- (void)setUnderRoundColor:(UIColor *)underRoundColor {
    _underRoundColor = underRoundColor;
    self.underRoundLayer.strokeColor = _underRoundColor.CGColor;
    [self p_drawUnderRound];
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.progressLayer.lineWidth = _borderWidth;
    self.underRoundLayer.lineWidth = _borderWidth;
    [self p_drawUnderRound];
    [self p_drawProgress];
}
- (void)setProgressWithDashline:(BOOL)progressWithDashline {
    _progressWithDashline = progressWithDashline;
    if (_progressWithDashline) {
        self.progressLayer.lineDashPattern = _lineDashPattern;
        self.underRoundLayer.lineDashPattern = _lineDashPattern;
    } else {
        self.progressLayer.lineDashPattern = nil;
        self.underRoundLayer.lineDashPattern = nil;
    }
    [self p_drawProgress];
    [self p_drawUnderRound];
}
- (void)setLineDashPattern:(NSArray *)lineDashPattern {
    _lineDashPattern = [lineDashPattern copy];
    self.progressLayer.lineDashPattern = _lineDashPattern;
    self.underRoundLayer.lineDashPattern = _lineDashPattern;
    
    [self p_drawProgress];
    [self p_drawUnderRound];
}
- (void)setShowUnderRound:(BOOL)showUnderRound{
    _showUnderRound = showUnderRound;
    self.underRoundLayer.hidden = !_showUnderRound;
}
- (void)setProgressInfoFont:(UIFont *)progressInfoFont {
    _progressInfoFont = progressInfoFont;
    if (_progressInfoFont) {
        self.progressLabel.font = _progressInfoFont;
    }
}
- (void)setShowInfoLabel:(BOOL)showInfoLabel {
    _showInfoLabel = showInfoLabel;
    self.progressLabel.hidden = !_showInfoLabel;
}
- (void)setClockwise:(BOOL)clockwise {
    _clockwise = clockwise;
    [self p_drawUnderRound];
    [self p_drawProgress];
}
#pragma mark - getterMethods
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = _progressColor.CGColor;
        _progressLayer.lineWidth = _borderWidth;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 1;
        if (_progressWithDashline) {
            _progressLayer.lineDashPattern = _lineDashPattern;
        }
    }
    return _progressLayer;
}
- (CAShapeLayer *)underRoundLayer {
    if (!_underRoundLayer) {
        _underRoundLayer = [CAShapeLayer layer];
        _underRoundLayer.fillColor = [UIColor clearColor].CGColor;
        _underRoundLayer.strokeColor = _underRoundColor.CGColor;
        _underRoundLayer.lineWidth = _borderWidth;
        _underRoundLayer.strokeStart = 0;
        _underRoundLayer.strokeEnd = 1;
        if (_progressWithDashline) {
            _underRoundLayer.lineDashPattern = _lineDashPattern;
        }
        
    }
    return _underRoundLayer;
}
-(UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.text = [NSString stringWithFormat:@"%ld%%",(long)_progress];
        _progressLabel.textColor = _progressLabelColor;
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = _progressInfoFont;
        _progressLabel.numberOfLines = 0;
    }
    return _progressLabel;
}
@end
