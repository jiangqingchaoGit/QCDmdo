//
//  QCBankCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCBankCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * bankLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * numberLabel;


@end

NS_ASSUME_NONNULL_END
