//
//  QCAddressListsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddressListsViewController.h"
#import "QCAddressCell.h"
#import "QCAddressViewController.h"
@interface QCAddressListsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;


@end

@implementation QCAddressListsViewController


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
    [QCAFNetWorking QCPOST:@"/api/user/useraddress" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];


        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];

            for (NSDictionary * dic in responseObject[@"data"]) {
                QCAddressModel * model = [[QCAddressModel alloc] initWithDictionary:dic error:nil];
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



- (void)rightAction:(UITapGestureRecognizer *)sender {
    QCAddressViewController * addressViewController = [[QCAddressViewController alloc] init];
    addressViewController.hidesBottomBarWhenPushed = YES;
    addressViewController.title = @"添加地址";
    [self.navigationController pushViewController:addressViewController animated:YES];
}

#pragma mark - initUI

- (void)initUI {

    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"我的地址";
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add"]];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
   
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
    [self.tableView registerClass:[QCAddressCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(100);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCAddressModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCAddressModel * model = self.dataArr[indexPath.row];
    

    if ([self.status isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
        NSDictionary * dic = @{@"area":[NSString stringWithFormat:@"%@%@%@",model.province_name,model.city_name,model.area_name],@"address":model.address,@"name":model.name,@"mobile":model.mobile};
        self.addressBlock(dic);
    }else{
        QCAddressViewController * addressViewController = [[QCAddressViewController alloc] init];
        addressViewController.hidesBottomBarWhenPushed = YES;
        addressViewController.model = model;
        addressViewController.title = @"修改地址";
        [self.navigationController pushViewController:addressViewController animated:YES];
    }
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
        
        QCAddressModel * model = self.dataArr[indexPath.row];


        
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
