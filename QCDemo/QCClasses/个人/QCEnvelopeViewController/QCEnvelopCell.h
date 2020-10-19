//
//  QCEnvelopCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCEnvelopCell : UITableViewCell
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * paymentsLabel;
@property (nonatomic, strong) UILabel * restLabel;
@end

NS_ASSUME_NONNULL_END
