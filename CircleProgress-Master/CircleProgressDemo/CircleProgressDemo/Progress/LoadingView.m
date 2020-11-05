//
//  LoadingView.m
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/3/29.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "LoadingView.h"

#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height
#define kContentWidth self.contentView.frame.size.width
#define kContentHeight self.contentView.frame.size.height
#import "AppDelegate.h"
static const NSInteger kBaseTag = 1259;
@interface LoadingView ()
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) CGFloat  inProgress;//1-100;
@property (nonatomic, assign) CGFloat  centerProgress;
@property (nonatomic, assign) CGFloat  outProgress;
@property (nonatomic, assign) BOOL  isAnimating;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation LoadingView
+ (void)QSM_Show {
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate) .window;
    UIView *view = [window viewWithTag:kBaseTag];
    if (view && [view isKindOfClass:[LoadingView class]]) {
        LoadingView *loading = (LoadingView *)view;
        window.tag = kBaseTag;
        [window addSubview:loading];
        [loading p_show];
    } else {
        LoadingView *loading = [[LoadingView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        loading.tag = kBaseTag;
        [window addSubview:loading];
        [loading p_show];
    }
}
+ (void)QSM_Dismiss {
    UIWindow *window = ((AppDelegate*)[UIApplication sharedApplication].delegate).window;
    UIView *view = [window viewWithTag:kBaseTag];
    if (view && [view isKindOfClass:[LoadingView class]]) {
        LoadingView *loading = (LoadingView *)view;
        [loading p_dismiss];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        _inProgress = 0;
        _centerProgress = 0;
        _outProgress = 0;
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.inCircle];
        [self.contentView addSubview:self.centerCircle];
        [self.contentView addSubview:self.outCircle];
        [self addSubview:self.closeBtn];
    }
    return self;
}
- (void)p_startAnimation {
    if (self.isAnimating == NO) {
        __weak LoadingView *weakSelf = self;
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC, 1000 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            weakSelf.inProgress +=2.5;
            if (weakSelf.inProgress > 100) {
                weakSelf.inProgress = 0;
            }
            weakSelf.centerProgress +=2;
            if (weakSelf.centerProgress > 100) {
                weakSelf.centerProgress = 0;
            }
            weakSelf.outProgress +=1;
            if (weakSelf.outProgress > 100) {
                weakSelf.outProgress = 0;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.inCircle.progress = weakSelf.inProgress;
                self.centerCircle.progress = weakSelf.centerProgress;
                self.outCircle.progress = weakSelf.outProgress;
            });
        });
        dispatch_resume(self.timer);
        self.isAnimating = YES;
    }
}
- (void)p_stopAnimation {
    if (self.isAnimating) {
        dispatch_source_cancel(self.timer);
        self.isAnimating = NO;
    }
}
- (void)p_show {
    [self p_startAnimation];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
    
}
- (void)p_dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self p_stopAnimation];
        [self removeFromSuperview];
    }];
}
- (void)closeBtnClicked {
    [self p_dismiss];
}
#pragma mark - getterMethods
- (CircleProgressView *)inCircle {
    if (!_inCircle) {
        _inCircle = [[CircleProgressView alloc] initWithFrame:CGRectMake(kContentWidth/2.0-40, kContentHeight/2.0-40, 80, 80)];
        _inCircle.progressColor = [UIColor yellowColor];
        [_inCircle setShowInfoLabel:NO];
        _inCircle.showUnderRound = NO;
//        _inCircle.progressWithDashline = NO;
//        _inCircle.clockwise = NO;
    }
    return _inCircle;
}
- (CircleProgressView *)centerCircle {
    if (!_centerCircle) {
        _centerCircle = [[CircleProgressView alloc] initWithFrame:CGRectMake(kContentWidth/2.0-50, kContentHeight/2.0-50, 100, 100)];
        _centerCircle.progressColor = [UIColor greenColor];
        _centerCircle.showUnderRound = NO;
        [_centerCircle setShowInfoLabel:NO];
//        _centerCircle.progressWithDashline = NO;
        _centerCircle.clockwise = NO;
    }
    return _centerCircle;
}
- (CircleProgressView *)outCircle {
    if (!_outCircle) {
        _outCircle = [[CircleProgressView alloc] initWithFrame:CGRectMake(kContentWidth/2.0-60, kContentHeight/2.0-60, 120, 120)];
        _outCircle.progressColor = [UIColor redColor];
        [_outCircle setShowInfoLabel:NO];
        _outCircle.showUnderRound = NO;
//        _outCircle.progressWithDashline = NO;
//        _outCircle.clockwise = NO;
    }
    return _outCircle;
}
- (dispatch_source_t)timer {
    if (!_timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
    return _timer;
}
-(UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kSelfWidth/2.0-70, kSelfHeight/2.0-70, 140, 140)];
        _contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
        _contentView.layer.cornerRadius = 20;
    }
    return _contentView;
}
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(kSelfWidth/2.0-20, kSelfHeight/2.0-20, 40, 40);
        [_closeBtn setTitle:@"X" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:30];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
@end
