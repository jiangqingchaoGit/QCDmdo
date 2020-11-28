//
//  QCGroupListCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGroupListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCGroupListCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * headerButton;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) UILabel * timeLabel;

- (void)fillCellWithModel:(QCGroupListModel *)model;
@end

NS_ASSUME_NONNULL_END
