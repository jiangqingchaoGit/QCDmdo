//
//  QCGoodsDetailsCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCImageDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGoodsDetailsCell : UITableViewCell
@property (nonatomic, strong) UIImageView * goodsImageView;

- (void)fillCellWithModel:(QCImageDetailsModel *)model;
@end

NS_ASSUME_NONNULL_END
