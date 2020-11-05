//
//  QSMStyleDownloadView.m
//  SlideMaker
//
//  Created by ZHHL on 2020/3/27.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "QSMStyleDownloadView.h"
#import "CircleProgressView.h"
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height
@interface QSMStyleDownloadView ()

@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIImageView *completeImgView;
@property (nonatomic, strong) UIImageView *centerImgView;
@end

@implementation QSMStyleDownloadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.outCircle];
        [self addSubview:self.inCircle];
//        [self addSubview:self.infoLabel];
        [self addSubview:self.centerImgView];
        [self QSM_ObserveComplete];
    }
    return self;
}
- (void)QSM_ObserveComplete {
    self.isDownloading = YES;
    __block BOOL inComplete = NO;
    __block BOOL outComplete = NO;
    __weak QSMStyleDownloadView *weakSelf = self;
    [self.inCircle setCompleteBlock:^{
        inComplete = YES;
        if (outComplete) {
            weakSelf.isDownloading = NO;
            if (weakSelf.completeBlock) {
                weakSelf.completeBlock();
            }
        } else {
            weakSelf.isDownloading = YES;
        }
    }];
    [self.outCircle setCompleteBlock:^{
        outComplete = YES;
        if (inComplete) {
            weakSelf.isDownloading = NO;
            if (weakSelf.completeBlock) {
                weakSelf.completeBlock();
            }
        } else {
            weakSelf.isDownloading = YES;
        }
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.inCircle.frame = CGRectMake(kSelfWidth/2.0-30, kSelfHeight/2.0 - 30, 60, 60);
    self.outCircle.frame = CGRectMake(kSelfWidth/2.0-40, kSelfHeight/2.0 - 40, 80, 80);
    self.infoLabel.frame = CGRectMake(kSelfWidth/2.0-30, kSelfHeight/2.0 - 30, 60, 60);
    self.centerImgView.frame = CGRectMake(kSelfWidth/2.0 - 11, kSelfHeight/2.0-11, 22, 22);
}

#pragma mark - getterMethods
- (CircleProgressView *)inCircle {
    if (!_inCircle) {
        _inCircle = [[CircleProgressView alloc] initWithFrame:CGRectMake(kSelfWidth/2.0-30, kSelfHeight/2.0 - 30, 60, 60)];
        _inCircle.progressColor = [UIColor whiteColor];
        _inCircle.progressWithDashline = NO;
        _inCircle.showInfoLabel = NO;
    }
    return _inCircle;
}
- (CircleProgressView *)outCircle {
    if (!_outCircle) {
        _outCircle = [[CircleProgressView alloc] initWithFrame:CGRectMake(kSelfWidth/2.0-40, kSelfHeight/2.0 - 40, 80, 80)];
        _outCircle.progressColor = [UIColor whiteColor];
        _outCircle.progressWithDashline = NO;
        _outCircle.showInfoLabel = NO;
    }
    return _outCircle;
}
- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"...\ndownload";
        _infoLabel.textColor = UIColor.redColor;
        _infoLabel.font = [UIFont systemFontOfSize:12];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}
- (UIImageView *)completeImgView {
    if (!_completeImgView) {
        _completeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_styledownloadcomplete"]];
        _completeImgView.hidden = YES;
    }
    return _completeImgView;
}
- (UIImageView *)centerImgView {
    if (!_centerImgView) {
        _centerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_style_download"]];
    }
    return _centerImgView;
}
@end
