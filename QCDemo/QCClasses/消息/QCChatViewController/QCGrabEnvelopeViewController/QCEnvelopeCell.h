//
//  QCEnvelopeCell.h
//  QCDream
//
//  Created by JQC on 2019/2/22.
//  Copyright © 2019 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCEnveolpModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCEnvelopeCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nickName;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * moneyLabel;

@property (nonatomic, strong) UIImageView * rapImageView;
@property (nonatomic, strong) UIButton * luckButton;

- (void)fillCellWithModel:(QCEnveolpListModel *)model;
@end

NS_ASSUME_NONNULL_END
