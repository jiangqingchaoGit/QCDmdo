//
//  QCInactiveViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCInactiveViewController.h"
#import "QCInactiveCell.h"
#import "QCAddInactiveViewController.h"
@interface QCInactiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSString * typeStr;
@end

@implementation QCInactiveViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self GETDATA];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeStr = @"active";
    self.dataArr = [NSMutableArray new];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    
}

#pragma mark - tapAction
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    QCAddInactiveViewController * addInactiveViewController = [[QCAddInactiveViewController alloc] init];
    addInactiveViewController.hidesBottomBarWhenPushed = YES;
    addInactiveViewController.group_id = self.group_id;
    addInactiveViewController.typeStr = self.typeStr;
    
    [self.navigationController pushViewController:addInactiveViewController animated:YES];
}

- (void)deleteAction:(UIButton *)sender {
    QCInactiveCell * cell = (QCInactiveCell *)[[sender superview]superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCInactiveModel * model = self.dataArr[indexPath.row];
    
    
    if ([self.typeStr isEqualToString:@"active"]) {
        
        NSString * out_uid = [NSString stringWithFormat:@"%@,",model.uid];
        
        //  移除群聊
        NSString * str = [NSString stringWithFormat:@"group_id=%@&out_uid=%@&token=%@&uid=%@",self.group_id,out_uid,K_TOKEN,K_UID];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"group_id":self.group_id,@"out_uid":out_uid,@"token":K_TOKEN,@"uid":K_UID};
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        
        
        
        [QCAFNetWorking QCPOST:@"/api/chat/abort" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                [self GETDATA];
                
                
            }else{
                [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
                
            }
            
            
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
        }];
        
        return;;
    }
    
    
    NSString * type;
    
    if ([self.typeStr isEqualToString:@"mute"]) {
        type = @"is_mute";
    }else{
        type = @"is_take";
        
    }
    //  移除群聊
    NSString * str = [NSString stringWithFormat:@"fuid=%@&group_id=%@&%@=%@&token=%@&uid=%@",[NSString stringWithFormat:@"%@,",model.uid],self.group_id,type,@"0",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":[NSString stringWithFormat:@"%@,",model.uid],@"group_id":self.group_id,type:@"0",@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",type] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self GETDATA];

            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
    
    
    
    
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
            self.rightButton.hidden = YES;
            
            self.typeStr = @"active";
            
            
            break;
        case 2:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            self.rightButton.hidden = NO;
            self.typeStr = @"mute";
            
            break;
        case 3:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = YES;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.rightButton.hidden = NO;
            self.typeStr = @"take";
            
            break;
            
        default:
            break;
    }
    [self GETDATA];
    
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&token=%@&uid=%@",self.group_id,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",self.typeStr] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            for (NSDictionary * dic in responseObject[@"data"]) {
                
                QCInactiveModel * model = [[QCInactiveModel alloc] initWithDictionary:dic error:nil];
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
    self.title = @"群成员管理";
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.rightButton.titleLabel.font = K_16_FONT;
    self.rightButton.hidden = YES;
    [self.rightButton setTitleColor:[QCClassFunction stringTOColor:@"#666666"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
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
    [self.tableView registerClass:[QCInactiveCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:self.tableView];
    
    
}


- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(45))];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:view];
    
    NSArray * titleArr = @[@"7天不活跃",@"禁止发言",@"禁止领红包"];
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
    
    QCInactiveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    QCInactiveModel * model = self.dataArr[indexPath.row];

    [cell fillCellWithModel:model];
    [cell.deletButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.typeStr isEqualToString:@"mute"]) {
        cell.deletButton.hidden = YES;
    }else{
        cell.deletButton.hidden = NO;

    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



@end
