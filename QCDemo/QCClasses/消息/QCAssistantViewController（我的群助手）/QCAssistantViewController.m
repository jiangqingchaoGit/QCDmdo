//
//  QCAssistantViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAssistantViewController.h"
#import "QCAssistantCell.h"
//  群助手列表
#import "QCChangeGroupViewController.h"
#import "QCTokenViewController.h"

@interface QCAssistantViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * getArr;

@end

@implementation QCAssistantViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    self.getArr = [[NSMutableArray alloc] init];

    [self initUI];
    [self GETDATA];
    [self createTableView];
    
}
#pragma mark - GETDATA

- (void)GETDATA {

    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&token=%@&uid=%@",self.group_id,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_aide" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            [self.getArr removeAllObjects];
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCAssistantModel * model = [[QCAssistantModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
                
                if ([model.group isEqualToString:@"0"]) {
                    
                }else{
                    [self.getArr addObject:model];
                }
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
- (void)rightAction:(UIButton *)sender {
    
}

- (void)searchAction:(UIButton *)sender {
    
}

- (void)buttonAction:(UIButton *)sender {
    QCAssistantCell * cell = (QCAssistantCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCAssistantModel * model = self.dataArr[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"aide_id=%@&group_id=%@&token=%@&uid=%@",model.id,self.group_id,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"aide_id":model.id,@"group_id":self.group_id,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/aide_use" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self GETDATA];
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
}

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationItem.title = @"我的群助手";

}



- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCAssistantCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.getArr.count;

    }else{
        return self.dataArr.count;

    }

}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (self.getArr.count == 0) {
            return KSCALE_WIDTH(0.01);
        }else{
            return KSCALE_WIDTH(50);

        }


    }else{
            return KSCALE_WIDTH(33);

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = KCLEAR_COLOR;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(40))];
    if (section == 0) {
        if (self.getArr.count == 0) {
            label.text = @"";
        }else{
            label.text = [NSString stringWithFormat:@"已添加：%ld/%ld",self.getArr.count,self.dataArr.count];

        }
        label.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(40));
    }else{
        label.text = @"营销助手列表";
        label.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(23));


    }
    label.font = K_16_FONT;
    label.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(120);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCAssistantCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        QCAssistantModel * model = self.getArr[indexPath.row];
        [cell fillCellWithModel:model];
        cell.addButton.hidden = YES;

        
    }else{
        [cell.addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        QCAssistantModel * model = self.dataArr[indexPath.row];
        [cell fillCellWithModel:model];
        cell.addButton.hidden = NO;
        
        if ([model.group isEqualToString:@"0"]) {
            [cell.addButton setTitle:@"添加" forState:UIControlStateNormal];
            cell.addButton.userInteractionEnabled = YES;

        }else{
            [cell.addButton setTitle:@"已添加" forState:UIControlStateNormal];
            cell.addButton.userInteractionEnabled = NO;

        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    QCChangeGroupViewController * changeGroupViewController = [[QCChangeGroupViewController alloc] init];
//    changeGroupViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:changeGroupViewController animated:YES];
    if (indexPath.section == 0) {
        QCAssistantModel * model = self.getArr[indexPath.row];
        QCTokenViewController * tokenViewController = [[QCTokenViewController alloc] init];
        tokenViewController.hidesBottomBarWhenPushed = YES;
        tokenViewController.group_id = self.group_id;
        tokenViewController.assistantId = model.group;
        [self.navigationController pushViewController:tokenViewController animated:YES];
    }


    
}







@end
