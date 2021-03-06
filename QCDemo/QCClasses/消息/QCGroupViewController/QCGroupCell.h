//
//  QCGroupCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBookModel.h"
#import "QCGroupDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * headerButton;
@property (nonatomic, strong) UIButton * chooseButton;
@property (nonatomic, strong) UILabel * nameLabel;
- (void)fillCellWithModel:(QCBookModel *)model;
- (void)fillCellWithgroupModel:(QCGroupDataModel *)model;

@end

NS_ASSUME_NONNULL_END
