//
//  QCGroupChatViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QCGroupListModel.h"
#import "QCListModel.h"
#import "QCGroupChatFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupChatViewController : UIViewController
@property (nonatomic, strong) QCListModel * model;
@property (nonatomic, strong) NSString * groupId;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) CGFloat tableViewH;
@property (nonatomic, assign) CGFloat contentH;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) QCGroupChatFooterView * footerView;

- (void)GETDATA;
- (void)GETTab;


@end

NS_ASSUME_NONNULL_END
