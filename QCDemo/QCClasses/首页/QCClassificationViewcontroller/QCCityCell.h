//
//  QCCityCell.h
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/27.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCClassificationModel.h"
@interface QCCityCell : UITableViewCell

@property (nonatomic, strong) UILabel * provinceLabel;

- (void)fillCellWithModel:(QCClassificationModel *)model;
@end
