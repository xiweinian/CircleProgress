//
//  QSMStyleDownloadView.h
//  SlideMaker
//
//  Created by ZHHL on 2020/3/27.
//  Copyright © 2020 LEARNING ROAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QSMStyleDownloadView : UIView
@property (nonatomic, strong) CircleProgressView *inCircle;
@property (nonatomic, strong) CircleProgressView *outCircle;
@property (nonatomic, assign) BOOL  isDownloading;
@property (nonatomic, copy) void(^completeBlock)(void);
@property (nonatomic, copy) void(^startDownloadBlock)(void);
@end

NS_ASSUME_NONNULL_END
