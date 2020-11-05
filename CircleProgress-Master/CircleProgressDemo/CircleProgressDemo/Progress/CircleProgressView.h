//
//  CircleProgressView.h
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/3/26.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//
/**
 圆形进度条（不带渐变色）
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgressView : UIView
/** progress 0 - 100*/
@property (nonatomic, assign) CGFloat progress;
/** progressColor default is redColor*/
@property (nonatomic, strong) UIColor *progressColor;

/** progressLabelColor default is redColor*/
@property (nonatomic, strong) UIColor *progressLabelColor;

/** underRoundColor default is grayColor*/
@property (nonatomic, strong) UIColor *underRoundColor;

/** progress borderWidth default is 4*/
@property (nonatomic, assign) CGFloat borderWidth;

/** the text when progress equals to 100*/
@property (nonatomic, copy) NSString *completeText;

/** the text when progress min than 100 ,under the progress */
@property (nonatomic, copy) NSString *progressAppendText;

/** default is YES*/
@property (nonatomic, assign) BOOL  showUnderRound;

/** default is YES*/
@property (nonatomic, assign) BOOL  progressWithDashline;
/** default to YES*/
@property (nonatomic, assign) BOOL  clockwise;
/** The dash pattern (an array of NSNumbers) applied when creating the
 *  stroked version of the path. Defaults to @[@(2),@(2)].
 *  you can set nil to clear dashline
 */
@property (nonatomic, copy) NSArray * __nullable lineDashPattern;

/** completeBlock called when the progress equals to 100 */
@property (nonatomic, copy) void(^completeBlock)(void);

@property (nonatomic, strong) UIFont *progressInfoFont;
@property (nonatomic, assign) BOOL showInfoLabel;
@end

NS_ASSUME_NONNULL_END
