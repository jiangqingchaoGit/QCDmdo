//
//  QCListReusableView.h
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCListReusableView : UICollectionReusableView
@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;

@property (nonatomic, strong) UIImageView * saleImageView;
@property (nonatomic, strong) UIImageView * saleImageView_s;
@property (nonatomic, strong) UIImageView * priceImageView;
@property (nonatomic, strong) UIImageView * priceImageView_s;

@property (nonatomic, assign) BOOL isSale;
@property (nonatomic, assign) BOOL isPrice;


@end

NS_ASSUME_NONNULL_END
