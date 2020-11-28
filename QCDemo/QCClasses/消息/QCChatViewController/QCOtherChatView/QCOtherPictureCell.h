//
//  QCOtherPictureCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCOtherPictureCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * imageViewButton;
@property (nonatomic, strong) UIImageView * pictureImageView;
@property (nonatomic, strong) UIButton * pictureButton;

- (void)fillCellWithModel:(QCChatModel *)model;

@end

NS_ASSUME_NONNULL_END
