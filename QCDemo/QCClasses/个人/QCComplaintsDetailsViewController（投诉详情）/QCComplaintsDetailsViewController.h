//
//  QCComplaintsDetailsViewController.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCComplaintsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCComplaintsDetailsViewController : UIViewController
@property (nonatomic, strong) QCComplaintsListModel * model;
@end

NS_ASSUME_NONNULL_END
