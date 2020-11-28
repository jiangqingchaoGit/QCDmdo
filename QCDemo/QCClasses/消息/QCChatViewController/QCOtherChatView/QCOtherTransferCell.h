//
//  QCOtherTransferCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/25.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCOtherTransferCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * imageViewButton;
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * getLabel;
@property (nonatomic, strong) UIButton * envelopeButton;
@property (nonatomic, strong) UILabel * typeLabel;

@property (nonatomic, strong) UIButton * canButton;
@property (nonatomic, strong) UIImageView * loadingImageView;
@property (nonatomic, strong) UIImageView * fHeaderImageView;

- (void)fillCellWithModel:(QCChatModel *)model;
@end

NS_ASSUME_NONNULL_END
