//
//  QCSetCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCSetCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UISwitch * onSwitch;

@end

NS_ASSUME_NONNULL_END
