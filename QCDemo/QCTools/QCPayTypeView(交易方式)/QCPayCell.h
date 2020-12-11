//
//  QCPayCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/8.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBankModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCPayCell : UITableViewCell


@property (nonatomic, strong) UILabel * payLabel;
@property (nonatomic, strong) UIButton * chooseButton;
- (void)fillCellWithModel:(QCBankModel *)model;

@end

NS_ASSUME_NONNULL_END
