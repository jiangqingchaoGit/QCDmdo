//
//  QCReleaseViewController.h
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCRollingView.h"
#import "QCIntroduceView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCReleaseViewController : UIViewController
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) NSString * addressStr;
@property (nonatomic, strong) NSString * goodsId;

@property (nonatomic, strong) QCRollingView * rollingView;
@property (nonatomic, strong) QCIntroduceView * introduceView;
- (void)upSizeFrameWithHight:(CGFloat)hight;
@end

NS_ASSUME_NONNULL_END
