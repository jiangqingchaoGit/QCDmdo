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
//  底部视图
#import "QCChatFooterView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCChatViewController : UIViewController
@property (nonatomic, strong) QCListModel * model;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) CGFloat tableViewH;
@property (nonatomic, assign) CGFloat contentH;
@property (nonatomic, strong) QCChatFooterView * footerView;
@property (nonatomic, strong) UIView * backView;



- (void)GETDATA;
- (void)GETTab;


@end

NS_ASSUME_NONNULL_END
