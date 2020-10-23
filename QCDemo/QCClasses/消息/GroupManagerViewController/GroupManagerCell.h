//
//  GroupManagerCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupManagerCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UISwitch * chooseSwitch;
@end

NS_ASSUME_NONNULL_END
