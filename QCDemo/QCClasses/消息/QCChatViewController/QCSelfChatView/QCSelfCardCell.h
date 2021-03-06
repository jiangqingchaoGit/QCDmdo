//
//  QCSelfCardCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCSelfCardCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIImageView * fHeaderImageView;

@property (nonatomic, strong) UIButton * imageViewButton;
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * getLabel;
@property (nonatomic, strong) UIButton * envelopeButton;
@property (nonatomic, strong) UILabel * typeLabel;

@property (nonatomic, strong) UIButton * canButton;
@property (nonatomic, strong) UIImageView * loadingImageView;
- (void)fillCellWithModel:(QCChatModel *)model;

@end

NS_ASSUME_NONNULL_END
