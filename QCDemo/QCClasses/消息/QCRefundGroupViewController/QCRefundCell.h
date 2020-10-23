//
//  QCRefundCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCRefundCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * headerButton;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@end

NS_ASSUME_NONNULL_END
