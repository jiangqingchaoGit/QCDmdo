//
//  QCOtherPokeCell.h
//  QCDemo
//
//  Created by JQC on 2020/11/24.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCOtherPokeCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIButton * imageViewButton;
@property (nonatomic, strong) UIImageView * pictureImageView;
@property (nonatomic, strong) UIButton * cuoButton;

@property (nonatomic, strong) UIButton * canButton;
@property (nonatomic, strong) UIImageView * loadingImageView;

- (void)fillCellWithModel:(QCChatModel *)model;
@end

NS_ASSUME_NONNULL_END
