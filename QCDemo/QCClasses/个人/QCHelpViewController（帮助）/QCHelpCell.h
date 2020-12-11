//
//  QCHelpCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCHelpModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCHelpCell : UITableViewCell
@property (nonatomic, strong) UILabel * titleLabel;

- (void)fillCellWithModel:(QCHelpModel *)model;
@end

NS_ASSUME_NONNULL_END
