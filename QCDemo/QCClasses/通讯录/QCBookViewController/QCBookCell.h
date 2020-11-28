//
//  QCBookCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/5.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCBookCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * headerButton;
@property (nonatomic, strong) UILabel * nameLabel;

- (void)fillCellWithModel:(QCBookModel *)model;

@end

NS_ASSUME_NONNULL_END
