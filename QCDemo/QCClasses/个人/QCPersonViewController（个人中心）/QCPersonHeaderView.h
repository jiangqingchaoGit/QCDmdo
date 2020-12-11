//
//  QCPersonHeaderView.h
//  QCDemo
//
//  Created by JQC on 2020/10/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCPersonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCPersonHeaderView : UIView

- (void)initUI;
- (void)fillViewWithModel:(QCPersonModel *)model;

@end

NS_ASSUME_NONNULL_END
