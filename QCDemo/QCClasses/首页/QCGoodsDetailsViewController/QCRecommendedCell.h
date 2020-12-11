//
//  QCRecommendedCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGoodsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCRecommendedCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * freeLabel;
@property (nonatomic, strong) UILabel * unoldLabel;


- (void)fillCellWithModel:(QCGoodsModel *)model;
@end

NS_ASSUME_NONNULL_END
