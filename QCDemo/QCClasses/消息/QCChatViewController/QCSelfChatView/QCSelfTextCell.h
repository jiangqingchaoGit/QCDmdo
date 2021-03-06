//
//  QCSelfTextCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCSelfTextCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * imageViewButton;

@property (nonatomic, strong) UIButton * canButton;
@property (nonatomic, strong) UIImageView * loadingImageView;

@property (nonatomic, strong) UIView * labelView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * unreadLabel;
@property (nonatomic, strong) UILabel * readLabel;
@property (nonatomic, strong) UIImageView * unreadImageView;
@property (nonatomic, strong) UIImageView * readImageView;


- (void)fillCellWithModel:(QCChatModel *)model;
- (CGFloat)GETLabelH;
@end

NS_ASSUME_NONNULL_END
