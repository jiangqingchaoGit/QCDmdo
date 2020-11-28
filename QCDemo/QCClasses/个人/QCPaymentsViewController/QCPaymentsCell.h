//
//  QCPaymentsCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCPaymentsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCPaymentsCell : UITableViewCell
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * paymentsLabel;
@property (nonatomic, strong) UILabel * restLabel;

- (void)fillCellWithModel:(QCPaymentsModel *)model;
@end

NS_ASSUME_NONNULL_END
