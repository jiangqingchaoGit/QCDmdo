//
//  QCComplaintsCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCComplaintsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCComplaintsCell : UITableViewCell
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * chooseButton;

- (void)fillCellWithModel:(QCComplaintsModel *)model;
@end

NS_ASSUME_NONNULL_END
