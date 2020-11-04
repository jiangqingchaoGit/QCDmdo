//
//  QCChangeGroupCell.h
//  QCDemo
//
//  Created by JQC on 2020/10/27.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCChangeGroupCell : UITableViewCell
@property (nonatomic, strong) UIButton * changeButton;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;

@end

NS_ASSUME_NONNULL_END
