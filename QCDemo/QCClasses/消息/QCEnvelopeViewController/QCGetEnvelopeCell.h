//
//  QCGetEnvelopeCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGetEnvelopeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCGetEnvelopeCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headerImageView;

@property (nonatomic, strong) UILabel * nickName;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * moneyLabel;

@property (nonatomic, strong) UIImageView * rapImageView;
@property (nonatomic, strong) UIButton * luckButton;

- (void)fillCellWithModel:(QCGetEnvelopeModel *)model;
@end

NS_ASSUME_NONNULL_END
