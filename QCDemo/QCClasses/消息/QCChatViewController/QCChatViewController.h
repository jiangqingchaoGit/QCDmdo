//
//  QCChatViewController.h
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCListModel.h"
#import "QCChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCChatViewController : UIViewController
@property (nonatomic, strong) QCListModel * model;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) CGFloat tableViewH;

- (void)GETDATA;
@end

NS_ASSUME_NONNULL_END
