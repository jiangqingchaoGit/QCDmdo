//
//  QCAddressCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCAddressCell : UITableViewCell

@property (nonatomic, strong) UILabel * areaLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UILabel * defaultLabel;


@property (nonatomic, strong) UIButton * changeButton;

- (void)fillCellWithModel:(QCAddressModel *)model;

@end

NS_ASSUME_NONNULL_END
