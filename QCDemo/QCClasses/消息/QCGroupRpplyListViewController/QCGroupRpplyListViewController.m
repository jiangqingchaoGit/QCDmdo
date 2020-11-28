//
//  QCGroupRpplyListViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupRpplyListViewController.h"
#import "QCNewFriendListCell.h"
#import "QCNewFriendListModel.h"

@interface QCGroupRpplyListViewController ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * rightButton;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * keysArr;

@end

@implementation QCGroupRpplyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArr = [[NSMutableArray alloc] init];
    self.keysArr = [[NSMutableArray alloc] init];
    
    [self initUI];
    [self createTableView];
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
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_apply_list" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCNewFriendListModel * model = [[QCNewFriendListModel alloc] initWithDictionary:dic error:nil];
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
- (void)rightAction:(UITapGestureRecognizer *)sender {
    
    
}

- (void)searchAction:(UIButton *)sender {
    //  搜索
    
}

- (void)agreeAction:(UIButton *)sender {
    QCNewFriendListCell * cell = (QCNewFriendListCell *)[[sender superview]superview];
    NSIndexPath * indexpath = [self.tableView indexPathForCell:cell];
    QCNewFriendListModel * model = self.dataArr[indexpath.row];
    
    /*
     *  同意申请
     */
    
    //  发送请求
    NSString * str = [NSString stringWithFormat:@"fuid=%@&group_id=%@&status=%@&token=%@&uid=%@",model.uid,self.group_id,@"2",K_TOKEN,K_UID];
    
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":model.uid,@"group_id":self.group_id,@"status":@"2",@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_apply_verify" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([[responseObject[@"status"] stringValue] isEqualToString:@"1"]) {
            
            //  添加好友
            [self GETDATA];
            
//            NSString * msgid = [NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp],model.uid];
//            NSString * str = [NSString stringWithFormat:@"atype=agree&message=添加好友&msgid=%@&touid=%@&type=friend&uid=%@",msgid,model.uid,K_UID];
//            NSString * signStr = [QCClassFunction MD5:str];
//
//            NSDictionary * dic = @{@"atype":@"agree",@"message":@"添加好友",@"msgid":msgid ,@"touid":model.uid,@"type":@"friend",@"uid":K_UID};
//
//
//            NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
//            NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//            NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
//            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            [[QCWebSocket shared] sendDataToServer:jsonString];
            
            
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
}
- (void)refuseAction:(UIButton *)sender {
    
    QCNewFriendListCell * cell = (QCNewFriendListCell *)[[sender superview]superview];
    NSIndexPath * indexpath = [self.tableView indexPathForCell:cell];
    QCNewFriendListModel * model = self.dataArr[indexpath.row];
    
    
    //  发送请求
    
    NSString * str = [NSString stringWithFormat:@"fuid=%@&group_id=%@&status=%@&token=%@&uid=%@",model.fuid,self.group_id,@"3",K_TOKEN,K_UID];
    
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":model.fuid,@"group_id":self.group_id,@"status":@"3",@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/chat/group_apply_verify" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([[responseObject[@"status"] stringValue] isEqualToString:@"1"]) {
            
            //  拒绝好友
            
//            NSLog(@"%@",model);
//            NSString * msgid = [NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp],model.uid];
//            NSString * str = [NSString stringWithFormat:@"atype=agree&message=添加好友&msgid=%@&touid=%@&type=friend&uid=%@",msgid,model.uid,K_UID];
//            NSString * signStr = [QCClassFunction MD5:str];
//
//            NSDictionary * dic = @{@"atype":@"agree",@"message":@"添加好友",@"msgid":msgid ,@"touid":model.uid,@"type":@"friend",@"uid":K_UID};
//
//
//            NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
//            NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//            NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
//            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
//            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            [[QCWebSocket shared] sendDataToServer:jsonString];
            
            
            
            
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
    self.navigationItem.title = @"申请列表";
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:KHeaderImage];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
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
    [self.tableView registerClass:[QCNewFriendListCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(72);
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCNewFriendListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCNewFriendListModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    [cell.agreeButton addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.refuseButton addTarget:self action:@selector(refuseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
