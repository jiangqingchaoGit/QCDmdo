//
//  QCRefundGroupViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCRefundGroupViewController.h"
#import "QCRefundCell.h"
//  退群成员
@interface QCRefundGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * selfButton;
@property (nonatomic, strong) UIButton * passiveButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSString * type;

@end

@implementation QCRefundGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self GETDATA];
}

#pragma mark - tapAction
- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:

            self.selfButton.selected = YES;
            self.passiveButton.selected = NO;
            self.selfButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.passiveButton.backgroundColor = KCLEAR_COLOR;
            self.type = @"0";

            break;
        case 2:
            self.passiveButton.selected = YES;
            self.selfButton.selected = NO;
            self.passiveButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.selfButton.backgroundColor = KCLEAR_COLOR;
            self.type = @"1";

            break;

            
        default:
            break;
    }
    
    [self GETDATA];
}
#pragma mark - initUI

- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"退群成员";
    self.type = @"0";
    

    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&token=%@&type=%@&uid=%@",self.group_id,K_TOKEN,self.type,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"token":K_TOKEN,@"type":self.type,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",@"out_list"] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            for (NSDictionary * dic in responseObject[@"data"]) {

                QCRefundModel * model = [[QCRefundModel alloc] initWithDictionary:dic error:nil];
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


- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCRefundCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(45))];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:view];
    
    NSArray * titleArr = @[@"自己退群",@"被移出群"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(164.5), KSCALE_WIDTH(3), KSCALE_WIDTH(158.5), KSCALE_WIDTH(29))];
        button.backgroundColor = KCLEAR_COLOR;
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        
        [view addSubview:button];
        
        switch (i) {
            case 0:
                self.selfButton = button;
                self.selfButton.selected = YES;
                self.selfButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
                break;
            case 1:
                
                self.passiveButton = button;

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
    return KSCALE_WIDTH(67);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCRefundCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCRefundModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
