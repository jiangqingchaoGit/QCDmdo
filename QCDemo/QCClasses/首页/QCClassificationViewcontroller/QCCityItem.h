//
//  QCCityItem.h
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/27.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCClassificationModel.h"
@interface QCCityItem : UICollectionViewCell

@property (nonatomic, strong) UILabel * cityLabel;
@property (nonatomic, strong) UIImageView * cityImageView;

- (void)fillCellWithModel:(QCClassificationModel *)model;

@end
