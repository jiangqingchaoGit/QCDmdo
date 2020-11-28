//
//  QCSearchCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCSearchCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * idLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@end

NS_ASSUME_NONNULL_END
