//
//  QCPersonViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonViewController.h"
#import "QCPersonHeaderView.h"
#import "QCPersonCell.h"
#import "QCPersonModel.h"

//
#import "QCOpenViewController.h"
//  我的钱包
#import "QCWalletViewController.h"
//  帮助
#import "QCHelpViewController.h"
//  设置
#import "QCSetViewController.h"

@interface QCPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) QCPersonHeaderView * headerView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation QCPersonViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.dataArr = [[NSMutableArray alloc] init];
    [self GETDATA];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

- (void)fillView {
    
    QCPersonModel * personModel = [self.dataArr firstObject];
    [self.headerView fillViewWithModel:personModel];
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/getinfo" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        NSDictionary * data = responseObject[@"data"];
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            QCPersonModel * personModel = [[QCPersonModel alloc] initWithDictionary:data error:nil];
            
            [QCClassFunction Save:personModel.nick Key:@"nick"];
            [QCClassFunction Save:personModel.head_img Key:@"headImage"];
            [QCClassFunction Save:personModel.sex Key:@"sex"];
            [QCClassFunction Save:personModel.identifyNum Key:@"cardNum"];
            [QCClassFunction Save:personModel.real_name Key:@"realName"];
            [QCClassFunction Save:personModel.is_pay_wallet Key:@"wallet"];
            [QCClassFunction Save:personModel.account Key:@"account"];

            
            
            [self.dataArr removeAllObjects];
            [self.dataArr addObject:personModel];
            [self fillView];
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
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCPersonCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[QCPersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(300) + KStatusHight)];
    self.headerView.backgroundColor = KBACK_COLOR;
    [self.headerView initUI];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(55);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPersonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray * titleArr = @[@"钱包",@"帮助",@"客服",@"设置"];
    cell.headerImageView.image = [UIImage imageNamed:titleArr[indexPath.row]];
    cell.titleLabel.text = titleArr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            
            if ([[QCClassFunction Read:@"wallet"] isEqualToString:@"0"]) {
                QCOpenViewController * openViewController = [[QCOpenViewController alloc] init];
                openViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:openViewController animated:YES completion:nil];
            }else{
                QCWalletViewController * walletViewController = [[QCWalletViewController alloc] init];
                walletViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:walletViewController animated:YES];
            }
            
            
            
        }
            break;
        case 1:
        {
            QCHelpViewController * helpViewController = [[QCHelpViewController alloc] init];
            helpViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:helpViewController animated:YES];
        }
            break;
        case 2:
            
            break;
        case 3:
        {
            
            QCSetViewController * setViewController = [[QCSetViewController alloc] init];
            setViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setViewController animated:YES];
        }
            break;
        default:
            break;
    }
}




@end
