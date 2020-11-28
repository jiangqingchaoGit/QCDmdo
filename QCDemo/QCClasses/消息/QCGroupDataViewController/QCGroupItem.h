//
//  QCGroupItem.h
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGroupDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCGroupItem : UICollectionViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * identityLabel;
@property (nonatomic, strong) UILabel * nameLabel;

- (void)fillCellWithModel:(QCGroupDataModel *)model;
@end

NS_ASSUME_NONNULL_END
