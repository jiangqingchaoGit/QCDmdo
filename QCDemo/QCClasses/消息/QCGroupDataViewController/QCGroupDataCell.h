//
//  QCGroupDataCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGroupDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCGroupDataCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UISwitch * chooseSwitch;


@end

NS_ASSUME_NONNULL_END
