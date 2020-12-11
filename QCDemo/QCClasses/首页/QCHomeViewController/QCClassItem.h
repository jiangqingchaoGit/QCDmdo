//
//  QCClassItem.h
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCClassItem : UICollectionViewCell
@property (nonatomic, strong) UIImageView * classImageView;
@property (nonatomic, strong) UILabel * contentLabel;

- (void)fillItemWithModel:(QCCategoryModel *)model;

@end

NS_ASSUME_NONNULL_END
