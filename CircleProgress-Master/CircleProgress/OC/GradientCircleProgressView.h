//
//  GradientCircleProgressView.h
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/4/13.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//
/**
 * 圆形进度条
 * - 可设置是否是虚线
 * - 可设置起始角度
 * - 可设置进度条方向
 * - 可设置进度条线宽
 * - 可设置虚线的长度
 * - 可设置背景圆环颜色
 * - 可设置背景进度条的闭合样式
 * - 可设置是否显示背景圆环
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientCircleProgressView : UIView

/// 起始角度
@property (nonatomic, assign) CGFloat  startAngle;
/// 是否是顺时针
@property (nonatomic, assign) BOOL  isClockwise;
/// 0-1.0
@property (nonatomic, assign) CGFloat  progress;
/// 线宽
@property (nonatomic, assign) CGFloat  lineWidth;
/// 是否以虚线形式展示注意线段间隔太短时会受到lineCap影响可能看不到效果
@property (nonatomic, assign) BOOL  shouldWithDashPattern;
///虚线长度设置
@property (nonatomic, strong) NSArray *dashPattern;
///背景圆环颜色
@property (nonatomic, strong) UIColor *maxTintColor;
///进度条的渐变色
@property (nonatomic, copy) NSArray *progressColors;
///进度条闭合方式
@property (nonatomic, copy) CAShapeLayerLineCap lineCap;
///是否显示底部圆环
@property (nonatomic, assign) BOOL  showBottomProgress;

/// 设置进度条渐变色的相关属性
/// @param handle 回调
- (void)setProgressGradientLayerHandle:(void(^)(CAGradientLayer *gradientLayer))handle;

/// 设置进度条线宽虚线进度等相关属性
/// @param handle 回调
- (void)setProgressLayerHandle:(void(^)(CAShapeLayer *progressLayer))handle;

/// 设置底部圆环相关属性
/// @param handle 回调
- (void)setBottomLayerHandle:(void(^)(CAShapeLayer *bottomLayer))handle;
@end

NS_ASSUME_NONNULL_END
