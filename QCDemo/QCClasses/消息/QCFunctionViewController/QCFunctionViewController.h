//
//  QCFunctionViewController.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCMessageViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCFunctionViewController : UIViewController
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) QCMessageViewController * messageViewController;

@end

NS_ASSUME_NONNULL_END
