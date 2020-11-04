//
//  QCMessageCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCMessageCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * headerButton;

@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * tipLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * timeLabel;

- (void)fillCellWithModel:(QCListModel *)model;

@end

NS_ASSUME_NONNULL_END
