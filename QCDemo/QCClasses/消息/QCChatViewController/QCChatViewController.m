//
//  QCChatViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChatViewController.h"
#import "QCChatCell.h"
#import "QCSelfTextCell.h"
#import "QCChatFooterView.h"
@interface QCChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) QCChatFooterView * footerView;
@end

@implementation QCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createTableView];
    [self createFooterView];
    [self GETDATA];

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //  操作数据库 count设置为0
    //  先查询 然后修改
    self.model.isRead = @"1";
    
    
    [[QCDataBase shared] queryByListId:self.model];
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    [self.dataArr removeAllObjects];

    QCChatModel * model = [[QCChatModel alloc] init];
    self.dataArr = [[QCDataBase shared] queryChatModel:model];
    // 解决刷新tableView  reloadData时闪屏的bug
    self.tableView.hidden = YES;
    [self.tableView reloadData];
    
    if ([self.dataArr count] > 1){
        // 动画之前先滚动到倒数第二个消息
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 2 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    self.tableView.hidden = NO;
    // 添加向上顶出最后一个消息的动画
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


#pragma mark - tapAction


- (void)resignAction {
    [self.footerView packUp];
}

#pragma mark - initUI
- (void)initUI {
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.backgroundColor = KBACK_COLOR;
    self.title = self.model.message;
    NSLog(@"%@",self.model);
    
}




- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,  KSCREEN_HEIGHT - KSCALE_WIDTH(58) - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCSelfTextCell class] forCellReuseIdentifier:@"selfTextCell"];
    
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)createFooterView {

    self.footerView = [[QCChatFooterView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(58) -KNavHight, KSCREEN_WIDTH, KSCALE_WIDTH(58))];
    [self.view addSubview:self.footerView];
    [self.footerView getParent];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    QCChatModel * model = self.dataArr[indexPath.row];
    return [model.cellH floatValue];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSelfTextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selfTextCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCChatModel * chatModel = self.dataArr[indexPath.row];
    [cell fillCellWithModel:chatModel];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}




@end
