//
//  QCPersonCardViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/13.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCPersonCardViewController : UIViewController
@property (nonatomic, strong) QCBookModel * model;
@end

NS_ASSUME_NONNULL_END
