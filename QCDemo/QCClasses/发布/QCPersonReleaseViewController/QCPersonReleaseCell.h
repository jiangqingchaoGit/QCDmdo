//
//  QCPersonReleaseCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/31.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGoodsDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCPersonReleaseCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * freeLabel;
@property (nonatomic, strong) UILabel * unoldLabel;

@property (nonatomic, strong) UIButton * upButton;

@property (nonatomic, strong) UIButton * downButton;
@property (nonatomic, strong) UIButton * editorButton;
@property (nonatomic, strong) UIButton * deleteButton;

- (void)fillCellWithModel:(QCGoodsDetailsModel *)model;

- (void)fillSizeWithStatus:(NSString *)status;
@end

NS_ASSUME_NONNULL_END
