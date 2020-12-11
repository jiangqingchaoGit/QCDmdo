//
//  QCSupportCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSupportModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCSupportCell : UITableViewCell
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIButton * chooseButton;
- (void)fillCellWithModel:(QCSupportModel *)model;
@end

NS_ASSUME_NONNULL_END
