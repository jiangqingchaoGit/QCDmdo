//
//  QCPersonSellCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCPersonSellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCPersonSellCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIImageView * contentImageView;

@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;

@property (nonatomic, strong) UIButton * reminderButton;
@property (nonatomic, strong) UIButton * goodsButton;
@property (nonatomic, strong) UIButton * refundButton;
@property (nonatomic, strong) UIButton * delectButton;

- (void)fillCellWithModel:(QCPersonSellModel *)model;
@end

NS_ASSUME_NONNULL_END
