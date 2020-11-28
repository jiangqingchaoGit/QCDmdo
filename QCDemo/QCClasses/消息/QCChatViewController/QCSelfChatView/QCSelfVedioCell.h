//
//  QCSelfVedioCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCSelfVedioCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * imageViewButton;
@property (nonatomic, strong) UIButton * vedioButton;
@property (nonatomic, strong) UIImageView * pictureImageView;


@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) AVPlayerItem * playerItem;

@property (nonatomic, strong) UIButton * canButton;
@property (nonatomic, strong) UIImageView * loadingImageView;

- (void)fillCellWithModel:(QCChatModel *)model;
@end

NS_ASSUME_NONNULL_END
