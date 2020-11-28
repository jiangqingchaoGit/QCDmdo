//
//  QCOtherVoiceCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCOtherVoiceCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * imageViewButton;
@property (nonatomic, strong) UIButton * voiceButton;

@property (nonatomic, strong) UIImageView * voiceImageView;
@property (nonatomic, strong) UILabel * voiceLabel;
- (void)fillCellWithModel:(QCChatModel *)model;

@end

NS_ASSUME_NONNULL_END
