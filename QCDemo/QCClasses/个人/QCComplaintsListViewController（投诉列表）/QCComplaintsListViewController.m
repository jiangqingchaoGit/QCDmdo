//
//  QCComplaintsListViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCComplaintsListViewController.h"
#import "QCComplaintsListCell.h"

#import "QCComplaintsDetailsViewController.h"
@interface QCComplaintsListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation QCComplaintsListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self GETDATA];

}


//在页面消失的时候就让navigationbar还原样式

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createTableView];

}


#pragma mark - GETDATA
- (void)GETDATA {

    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/complaintslist" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];


        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];

            for (NSDictionary * dic in responseObject[@"data"]) {

                QCComplaintsListModel * model = [[QCComplaintsListModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }



    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}





#pragma mark - initUI

- (void)initUI {

    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"我的投诉";

   
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCComplaintsListCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(80);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCComplaintsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCComplaintsListModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    QCComplaintsListModel * model = self.dataArr[indexPath.row];
    QCComplaintsDetailsViewController * complaintsDetailsViewController = [[QCComplaintsDetailsViewController alloc] init];
    complaintsDetailsViewController.hidesBottomBarWhenPushed = YES;
    complaintsDetailsViewController.model = model;
    [self.navigationController pushViewController:complaintsDetailsViewController animated:YES];
    
}




@end
