//
//  LoadingView.h
//  CircleProgressDemo
//
//  Created by ZHHL on 2020/3/29.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoadingView : UIView
@property (nonatomic, strong) CircleProgressView *centerCircle;
@property (nonatomic, strong) CircleProgressView *outCircle;
@property (nonatomic, strong) CircleProgressView *inCircle;
+ (void)QSM_Show;
+ (void)QSM_Dismiss;
@end

NS_ASSUME_NONNULL_END
