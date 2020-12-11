//
//  QCAssistantCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCAssistantModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCAssistantCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * addButton;
- (void)fillCellWithModel:(QCAssistantModel *)model;

@end

NS_ASSUME_NONNULL_END
