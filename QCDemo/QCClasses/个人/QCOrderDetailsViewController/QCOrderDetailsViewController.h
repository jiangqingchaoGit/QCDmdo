//
//  QCOrderDetailsViewController.h
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCPersonOrderModel.h"
#import "QCPersonSellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCOrderDetailsViewController : UIViewController
@property (nonatomic, strong) QCPersonSellModel * model;

@end

NS_ASSUME_NONNULL_END
