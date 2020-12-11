//
//  QCChooseBankCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/1.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBankModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCChooseBankCell : UITableViewCell
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * chooseButton;
@property (nonatomic, strong) UIView * lineView;
@end

NS_ASSUME_NONNULL_END
