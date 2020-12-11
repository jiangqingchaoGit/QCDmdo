//
//  QCComplaintsListCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCComplaintsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCComplaintsListCell : UITableViewCell

@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UILabel * timeLabel;

- (void)fillCellWithModel:(QCComplaintsListModel *)model;
@end

NS_ASSUME_NONNULL_END
