//
//  QCSureOrderCell.h
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCCardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCSureOrderCell : UITableViewCell
@property (nonatomic, strong) UILabel * payLabel;
@property (nonatomic, strong) UIButton * chooseButton;
- (void)fillCellWithModel:(QCCardModel *)model;
@end


NS_ASSUME_NONNULL_END
