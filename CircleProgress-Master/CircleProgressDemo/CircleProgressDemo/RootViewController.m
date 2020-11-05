//
//  RootViewController.m
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/4/13.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import "RootViewController.h"
#import "GradientCircleProgressView.h"
#import "LoadingView.h"
@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UIView *roundContentView;
@property (weak, nonatomic) IBOutlet UILabel *dashLinLabel;
@property (weak, nonatomic) IBOutlet UIStepper *shiStep;
@property (weak, nonatomic) IBOutlet UIStepper *xuStep;
@property (weak, nonatomic) IBOutlet UILabel *miaobianLabel;
@property (nonatomic, strong) GradientCircleProgressView *round;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _round = [[GradientCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.roundContentView addSubview:_round];
    [_round setProgressGradientLayerHandle:^(CAGradientLayer * _Nonnull colorLayer) {
        colorLayer.colors = @[(id)UIColor.redColor.CGColor,(id)UIColor.greenColor.CGColor];
        colorLayer.startPoint = CGPointMake(1, 0.5);
        colorLayer.endPoint = CGPointMake(0, 0.5);
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - Actions

/// 设置进度值
/// @param sender <#sender description#>
- (IBAction)progressChanged:(UISlider *)sender {
    _round.progress = sender.value;
}

/// 线宽（进度条粗细）
/// @param sender <#sender description#>
- (IBAction)lineWidthChanged:(UISlider *)sender {
    _round.lineWidth = sender.value;
}

/// 线段cap样式
/// @param sender <#sender description#>
- (IBAction)linCapValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _round.lineCap = kCALineCapRound;
    } else if (sender.selectedSegmentIndex == 1) {
        _round.lineCap = kCALineCapSquare;
    } else if (sender.selectedSegmentIndex == 2) {
        _round.lineCap = kCALineCapButt;
    }
}

/// 是否是虚线进度条
/// @param sender <#sender description#>
- (IBAction)dashLineSwithch:(UISwitch *)sender {
    _round.shouldWithDashPattern =sender.isOn;
}

/// 设置实线/虚线长度
/// @param sender <#sender description#>
- (IBAction)stepValueChanged:(UIStepper *)sender {
    _round.dashPattern = @[@(_shiStep.value),@(_xuStep.value)];
    self.dashLinLabel.text = [NSString stringWithFormat:@"%.0f:%.0f",self.shiStep.value,self.xuStep.value];
}

/// 进度方向
/// @param sender <#sender description#>
- (IBAction)isClokwiseValueChanged:(UISwitch *)sender {
    _round.isClockwise = sender.isOn;
}

/// 开始角度
/// @param sender <#sender description#>
- (IBAction)startAngleValueChanged:(UISlider *)sender {
    _round.startAngle = sender.value * M_PI * 2;
}

/// 是否显示底色
/// @param sender <#sender description#>
- (IBAction)showBottomLayerValueChanged:(UISwitch *)sender {
    _round.showBottomProgress = sender.isOn;
}

/// loading动画
/// @param sender <#sender description#>
- (IBAction)showLoadingAction:(UIButton *)sender {
    [LoadingView QSM_Show];
}


@end
