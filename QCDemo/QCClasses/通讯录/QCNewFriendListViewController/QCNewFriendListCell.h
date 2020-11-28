//
//  QCNewFriendListCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCNewFriendListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCNewFriendListCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * headerButton;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * statusLabel;

@property (nonatomic, strong) UIButton * agreeButton;
@property (nonatomic, strong) UIButton * refuseButton;

- (void)fillCellWithModel:(QCNewFriendListModel *)model;
@end

NS_ASSUME_NONNULL_END
