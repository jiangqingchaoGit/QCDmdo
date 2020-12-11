//
//  QCBankViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCBankViewController.h"
#import "QCBankCell.h"

#import "QCAddBankViewController.h"
@interface QCBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation QCBankViewController

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

    self.dataArr = [NSMutableArray new];
    [self GETDATA];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - tapAction
- (void)addAction:(UIButton *)sender {
    //  添加银行卡
    QCAddBankViewController * addBankViewController = [[QCAddBankViewController alloc] init];
    addBankViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addBankViewController animated:YES];
    
}
- (void)showAction:(UIButton *)sender {
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/card_list" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            [self.dataArr removeAllObjects];
            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCBankModel * model = [[QCBankModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
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
    self.title = @"我的银行卡";
    
    
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionFooterHeight = 0.01;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCBankCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(150))];
    self.footerView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.tableView.tableFooterView = self.footerView;
    
    UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    addButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    addButton.titleLabel.font = K_18_FONT;
    [addButton setTitle:@"+添加银行卡" forState:UIControlStateNormal];
    [addButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:addButton withRadius:KSCALE_WIDTH(12)];
    [self.footerView addSubview:addButton];
    
    UIButton * showButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(80), KSCALE_WIDTH(335), KSCALE_WIDTH(50))];
    showButton.backgroundColor = KCLEAR_COLOR;
    showButton.titleLabel.font = K_16_BFONT;
    [showButton setTitle:@"查看支持的银行" forState:UIControlStateNormal];
    [showButton setTitleColor:[QCClassFunction stringTOColor:@"#FF9852"] forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:showButton];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(145);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return KSCALE_WIDTH(200);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCBankCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCBankModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//2
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
//3
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//4
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    

}
//5
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        删除数据，和删除动画
        
        QCBankModel * model = self.dataArr[indexPath.row];


        
        NSString * str = [NSString stringWithFormat:@"id=%@&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"id":model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        [QCAFNetWorking QCPOST:@"/api/user/deladdress" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

            if ([responseObject[@"status"] intValue] == 1) {
                [self.dataArr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];

            }else{
                [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

            }



        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
        }];
        
        
        
    }];
    //编辑

    return @[deleteRowAction];

}

@end
