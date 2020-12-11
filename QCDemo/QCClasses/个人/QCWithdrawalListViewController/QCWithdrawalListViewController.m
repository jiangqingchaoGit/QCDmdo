//
//  QCWithdrawalListViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCWithdrawalListViewController.h"

#import "QCPaymentsCell.h"
#import "QCPaymentsDetailsViewController.h"
//  提现记录
@interface QCWithdrawalListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSString * c_type;

@end

@implementation QCWithdrawalListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
    self.i = 1;
    [self GETDATA];
    [self initUI];
    [self createTableView];
    [self refreshData];

}


#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"limit=15&page=%@&token=%@&uid=%@",[NSString stringWithFormat:@"%ld",self.i],K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"page":[NSString stringWithFormat:@"%ld",self.i],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/finance/withdrawrecord" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        
        if ([responseObject[@"status"] intValue] == 1) {
            if (self.i == 1) {
                [self.dataArr removeAllObjects];
            }
            
            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCWithdrawalModel * model = [[QCWithdrawalModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            
            if (self.dataArr.count == 0) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
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


- (void)refreshData {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.i = 1;
        [self GETDATA];
    }];
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.i++;
        [self GETDATA];
        
    }];
    self.tableView.mj_footer = footer;
    self.tableView.mj_header = header;
    
    
}



#pragma mark - tapAction

#pragma mark - initUI

- (void)initUI {

    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"提现记录";
   
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
    [self.tableView registerClass:[QCPaymentsCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(60);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPaymentsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCWithdrawalModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithDrawalModel:model];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPaymentsDetailsViewController * paymentsDetailsViewController = [[QCPaymentsDetailsViewController alloc] init];
    paymentsDetailsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:paymentsDetailsViewController animated:YES];
    
}


@end
