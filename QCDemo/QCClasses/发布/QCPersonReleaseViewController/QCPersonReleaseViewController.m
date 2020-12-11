//
//  QCPersonReleaseViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/31.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonReleaseViewController.h"
#import "QCPersonReleaseCell.h"
#import "QCReleaseViewController.h"

//  我的发布

@interface QCPersonReleaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, assign) NSInteger i;

@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSString * status;

@end

@implementation QCPersonReleaseViewController

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
    self.status = @"1";

    [self initUI];
    [self GETDATA];
    [self createTableView];
    [self createHeaderView];
}

- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"limit=15&page=%@&status=%@&token=%@&uid=%@",[NSString stringWithFormat:@"%ld",self.i],self.status,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"page":[NSString stringWithFormat:@"%ld",self.i],@"status":self.status,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/myrelease" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            if (self.i == 1) {
                [self.dataArr removeAllObjects];
            }
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCGoodsDetailsModel * model = [[QCGoodsDetailsModel alloc] initWithDictionary:dic error:nil];
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
#pragma mark - tapAction

- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.incomeButton.selected = YES;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;

            self.status = @"1";

            break;
        case 2:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            self.status = @"0";

            break;

            
        default:
            break;
    }
    self.i = 1;
    [self GETDATA];
}

- (void)upAction:(UIButton *)sender {
    
    QCPersonReleaseCell * cell = (QCPersonReleaseCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCGoodsDetailsModel * model = self.dataArr[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"gid=%@&status=1&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"gid":model.id,@"status":@"1",@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/goodstatus" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
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
- (void)downAction:(UIButton *)sender {
    
    QCPersonReleaseCell * cell = (QCPersonReleaseCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCGoodsDetailsModel * model = self.dataArr[indexPath.row];
    NSString * str = [NSString stringWithFormat:@"gid=%@&status=0&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"gid":model.id,@"status":@"0",@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/goodstatus" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
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
- (void)editorAction:(UIButton *)sender {
    QCPersonReleaseCell * cell = (QCPersonReleaseCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCGoodsDetailsModel * model = self.dataArr[indexPath.row];
    
    QCReleaseViewController * releaseViewController = [[QCReleaseViewController alloc] init];
    releaseViewController.hidesBottomBarWhenPushed = YES;
    releaseViewController.goodsId = model.id;
    [self.navigationController pushViewController:releaseViewController animated:YES];
    
}
- (void)deleteAction:(UIButton *)sender {
    
    QCPersonReleaseCell * cell = (QCPersonReleaseCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCGoodsDetailsModel * model = self.dataArr[indexPath.row];
    NSString * str = [NSString stringWithFormat:@"gid=%@&token=%@&uid=%@",model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"gid":model.id,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/goodsdel" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
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
    self.title = @"我的发布";
    

    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCREEN_HEIGHT -KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCPersonReleaseCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(40))];
    self.headerView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
   
    UIView * chooseView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(5) , KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    chooseView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:chooseView withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:chooseView];
    
    NSArray * titleArr = @[@"出售中",@"已下架"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(175), KSCALE_WIDTH(3), KSCALE_WIDTH(150), KSCALE_WIDTH(29))];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(2)];
        
        [chooseView addSubview:button];
        
        switch (i) {
            case 0:
                self.incomeButton = button;
                self.incomeButton.selected = YES;
                self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
                break;
            case 1:
                self.spendingButton = button;
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
    return KSCALE_WIDTH(160);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPersonReleaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCGoodsDetailsModel * model  = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    [cell fillSizeWithStatus:self.status];
    
    [cell.upButton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.downButton addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editorButton addTarget:self action:@selector(editorAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}



@end
