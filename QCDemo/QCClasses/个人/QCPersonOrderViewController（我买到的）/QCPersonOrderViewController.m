//
//  QCPersonOrderViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonOrderViewController.h"
#import "QCPersonOrderCell.h"
#import "QCDeliveryViewController.h"

#import "QCOrderDetailsViewController.h"


@interface QCPersonOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * numberLabel;

@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, strong) NSString * status;

@property (nonatomic, strong) UIView * headerView;

@end

@implementation QCPersonOrderViewController


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
    self.status = @"0";
    [self GETDATA];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self refreshData];

}


#pragma mark - GETDATA
- (void)GETDATA {

    NSString * str = [NSString stringWithFormat:@"limit=15&page=%@&status=%@&token=%@&uid=%@",[NSString stringWithFormat:@"%ld",self.i],self.status,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"page":[NSString stringWithFormat:@"%ld",self.i],@"status":self.status,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/buyorder" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];


        if ([responseObject[@"status"] intValue] == 1) {
            if (self.i == 1) {
                [self.dataArr removeAllObjects];

            }
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCPersonSellModel * model = [[QCPersonSellModel alloc] initWithDictionary:dic error:nil];
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
- (void)buttonAction:(UIButton *)sender {
    
    self.i = 1;
    switch (sender.tag) {
        case 1:
            self.incomeButton.selected = YES;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            self.status = @"0";
            [self GETDATA];

            break;
        case 2:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            self.status = @"1";

            [self GETDATA];

            break;
        case 3:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = YES;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.status = @"2";

            [self GETDATA];

            break;
            
        default:
            break;
    }
}

- (void)refundAction:(UIButton *)sender {
    //  申请退款
    QCPersonOrderCell * cell = (QCPersonOrderCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCPersonSellModel * model = self.dataArr[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"order_id=%@&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"order_id":model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/refundorder" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {

            [self.dataArr removeObject:model];
            [self.tableView reloadData];


        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];

}
- (void)reminderAction:(UIButton *)sender {
    //  催单
    QCPersonOrderCell * cell = (QCPersonOrderCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCPersonSellModel * model = self.dataArr[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"order_id=%@&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"order_id":model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/reminders" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            [QCClassFunction showMessage:@"催单成功" toView:self.view];



        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}
- (void)goodsAction:(UIButton *)sender {
    //  收货
    QCPersonOrderCell * cell = (QCPersonOrderCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCPersonSellModel * model = self.dataArr[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"order_id=%@&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"order_id":model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/confirmorder" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            [self.dataArr removeObject:model];
            [self.tableView reloadData];


        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];

}
- (void)delectAction:(UIButton *)sender {
    //  删除订单记录
    QCPersonOrderCell * cell = (QCPersonOrderCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCPersonSellModel * model = self.dataArr[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"order_id=%@&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"order_id":model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/delorder" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            [self.dataArr removeObject:model];
            [self.tableView reloadData];


        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}
#pragma mark - initUI

- (void)initUI {

    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"我买到的";
   
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCPersonOrderCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(45))];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:view];
    
    NSArray * titleArr = @[@"全部",@"待收货",@"退款"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(111), KSCALE_WIDTH(3), KSCALE_WIDTH(103), KSCALE_WIDTH(29))];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(14.5)];
        
        [view addSubview:button];
        
        switch (i) {
            case 0:
                self.incomeButton = button;
                self.incomeButton.selected = YES;
                self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
                break;
            case 1:
                self.spendingButton = button;
                break;
            case 2:
                self.withdrawalButton = button;
                break;
                
            default:
                break;
        }

    }
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(205);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPersonOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCPersonSellModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    
    [cell.refundButton addTarget:self action:@selector(refundAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.reminderButton addTarget:self action:@selector(reminderAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goodsButton addTarget:self action:@selector(goodsAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delectButton addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCOrderDetailsViewController * orderDetailsViewController = [[QCOrderDetailsViewController alloc] init];
    QCPersonSellModel * model = self.dataArr[indexPath.row];
    orderDetailsViewController.hidesBottomBarWhenPushed = YES;
    orderDetailsViewController.model = model;
    [self.navigationController pushViewController:orderDetailsViewController animated:YES];
}



@end
