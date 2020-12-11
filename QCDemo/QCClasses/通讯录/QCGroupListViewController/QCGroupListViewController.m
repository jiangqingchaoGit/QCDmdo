//
//  QCGroupListViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupListViewController.h"

#import "QCGroupListCell.h"
#import "QCGroupViewController.h"
//  聊天界面
#import "QCGroupChatViewController.h"
#import "QCChatViewController.h"
#import "AppDelegate.h"
@interface QCGroupListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;
@property (nonatomic, strong) NSString * groupType;

@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation QCGroupListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    self.groupType = @"3";
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self GETDATA];
}
#pragma mark - GETDATA
- (void)GETDATA {
    
    //  好友列表
    //    [self.dataArr removeAllObjects];
    //    QCAssociatedModel * model = [[QCAssociatedModel alloc] init];
    //    self.dataArr = [[QCDataBase shared] queryAssociatedModel:model];
    //    [self.tableView reloadData];
    
    
    
    NSString * str = [NSString stringWithFormat:@"token=%@&type=%@&uid=%@",K_TOKEN,self.groupType,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"type":self.groupType,@"uid":K_UID};
    
//    NSString * str = [NSString stringWithFormat:@"id=%@&token=%@&uid=%@",@"10",K_TOKEN,K_UID];
//    NSString * signStr = [QCClassFunction MD5:str];
//    NSDictionary * dic = @{@"id":@"10",@"token":K_TOKEN,@"uid":K_UID};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/my_group" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCGroupListModel * model = [[QCGroupListModel alloc] initWithDictionary:dic error:nil];
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
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    QCGroupViewController * groupViewController = [[QCGroupViewController alloc] init];
    groupViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:groupViewController animated:YES];
}

- (void)buttonAction:(UIButton *)sender {

    
    switch (sender.tag) {
        case 1:
            self.groupType = @"3";
            self.incomeButton.selected = YES;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;



            break;
        case 2:
            self.groupType = @"2";
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;

            break;
        case 3:
            self.groupType = @"1";
            self.incomeButton.selected = NO;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = YES;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];

            break;
            
        default:
            break;
    }
    [self GETDATA];
    
    
}

#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"我的群聊";

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375),KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCGroupListCell class] forCellReuseIdentifier:@"cell"];

    
    [self.view addSubview:self.tableView];
    
    
}


- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(45))];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:view];
    
    NSArray * titleArr = @[@"我创建的",@"我是管理",@"所有群聊"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(111), KSCALE_WIDTH(3), KSCALE_WIDTH(103), KSCALE_WIDTH(29))];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(2)];
        
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

    return KSCALE_WIDTH(72);

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCGroupListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    QCGroupListModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    
    QCGroupChatViewController * groupChatViewController = [[QCGroupChatViewController alloc] init];
    QCGroupListModel * model = self.dataArr[indexPath.row];

    
    QCListModel * listModel = [[QCListModel alloc] init];
    listModel.listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,model.id];
    listModel.type = @"chat";
    listModel.uid = model.id;
    listModel.rid = K_UID;
    listModel.msgid = [NSString stringWithFormat:@"%@|%@|%@",K_UID,[QCClassFunction getNowTimeTimestamp3],model.id];;
    listModel.message = @"";
    listModel.time = [QCClassFunction getNowTimeTimestamp3];
    listModel.count = @"0";
    listModel.headImage = @"imgUrl";
    listModel.isTop = @"0";
    listModel.isRead = @"1";
    listModel.isChat = @"2";
    listModel.cType = @"1";
    
    listModel.tohead = K_HEADIMAGE;
    listModel.tonick = K_NICK;
    
    listModel.uhead = @"";
    listModel.unick= @"";
    listModel.mtype = @"0";
    listModel.ghead = model.head_img?model.head_img:@"";
    listModel.gname = model.name;
    listModel.disturb = @"";
    listModel.isBanned = @"0";

    groupChatViewController.hidesBottomBarWhenPushed = YES;
    groupChatViewController.model = listModel;
    groupChatViewController.groupId = model.id;
    
    
    if (@available(iOS 10.0, *)) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        AppDelegate * apDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        QCTarBarController * tarBarController = (QCTarBarController *)apDelegate.window.rootViewController;
        tarBarController.selectedIndex = 1;
        [tarBarController.selectedViewController pushViewController:groupChatViewController animated:YES];

    } else {
        // Fallback on earlier versions
        [self.navigationController popToRootViewControllerAnimated:NO];
        AppDelegate * apDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        QCTarBarController * tarBarController = (QCTarBarController *)apDelegate.window.rootViewController;
        tarBarController.selectedIndex = 1;
        [tarBarController.selectedViewController pushViewController:groupChatViewController animated:YES];
    }
    
    
}



- (void)sendAction:(UIButton *)sender {

}

@end
