//
//  QCHomeItem.h
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCHomeItem : UICollectionViewCell
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UIImageView * goodsImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * serviceLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * browseLabel;

@end

NS_ASSUME_NONNULL_END
