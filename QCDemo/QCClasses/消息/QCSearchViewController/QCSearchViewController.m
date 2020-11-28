//
//  QCSearchViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSearchViewController.h"
#import "QCFriendModel.h"
@interface QCSearchViewController ()
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * sexImageView;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) NSString * status;


@end

@implementation QCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    if (self.codeStr) {
        [self GETDATAWithCode];

    }else{
        [self GETDATA];

    }
}

//  89047
//

#pragma mark - tapAction


- (void)addAction:(UIButton *)sender {
    
    QCFriendModel * model = [self.dataArr firstObject];
    
    
    if ([model.status isEqualToString:@"0"]) {
        //  添加好友
        [self applyDATA];
    }else{
        //  发送消息
    }
    
    return;
    
    
}

- (void)agreeAction:(UIButton *)sender {
    //  添加好友
    NSString * msgid = [NSString stringWithFormat:@"%@%@",K_UID,[QCClassFunction getNowTimeTimestamp]];
    NSString * str = [NSString stringWithFormat:@"message=添加好友&msgid=%@&touid=%@&type=agree&uid=%@",msgid,K_TUID,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"message":@"添加好友",@"msgid":msgid ,@"touid":K_TUID,@"type":@"apply",@"uid":K_UID};
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[QCWebSocket shared] sendDataToServer:jsonString];
    
}
#pragma mark - initUI
- (void)initUI {
    
    self.title = @"详细资料";
    self.view.backgroundColor = KBACK_COLOR;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.view addSubview:self.headerImageView];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(27))];
    self.nameLabel.font = K_16_FONT;
    self.nameLabel.textColor = KTEXT_COLOR;
    [self.view addSubview:self.nameLabel];
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(80), KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.addButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.addButton.titleLabel.font = K_18_FONT;
    [self.addButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    self.addButton.hidden = YES;
    [self.addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.addButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.addButton];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(50))];
    self.statusLabel.text = @"没有查询到该用户，请重新查询";
    self.statusLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    self.statusLabel.font = K_16_FONT;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.hidden = YES;
    [self.view addSubview:self.statusLabel];
    
    
}

- (void)fillView {
    
    if ([self.status isEqualToString:@"1"]) {
        self.nameLabel.hidden = NO;
        self.headerImageView.hidden = NO;
        self.addButton.hidden = NO;
        self.statusLabel.hidden = YES;
        
        QCFriendModel * model = [self.dataArr firstObject];
        self.nameLabel.text = model.nick;
        [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head AppendingString:@"" placeholderImage:@"header"];
        self.headerImageView.image = KHeaderImage;
        if ([model.status isEqualToString:@"0"]) {
            [self.addButton setTitle:@"添加好友" forState:UIControlStateNormal];
        }else{
            [self.addButton setTitle:@"发送消息" forState:UIControlStateNormal];
            
        }
        
        
    }else{
        self.nameLabel.hidden = YES;
        self.headerImageView.hidden = YES;
        self.addButton.hidden = YES;
        self.statusLabel.hidden = NO;
        
        
        
    }
    
}


#pragma mark - GETDATA（获取对方信息）

- (void)GETDATAWithCode {
    
    NSString * str = [NSString stringWithFormat:@"code=%@&token=%@&uid=%@",self.codeStr,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"code":self.codeStr,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    6c0eYIhPxK6TkrXhdPWFVj5Ugwu5VbOiuN7XL6E18XVB00qBGclnxfF/JqpPVbI
    

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/getcode" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            [self.dataArr removeAllObjects];
            QCFriendModel * model = [[QCFriendModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.dataArr addObject:model];
            self.status = @"1";
            
        }else{
            self.status = @"0";
            
        }
        [self fillView];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];

    }];
    
}
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"keyword=%@&token=%@&uid=%@",self.searchStr,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"keyword":self.searchStr,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/search" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            [self.dataArr removeAllObjects];
            QCFriendModel * model = [[QCFriendModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.dataArr addObject:model];
            self.status = @"1";
            
        }else{
            self.status = @"0";
            
        }
        [self fillView];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];

    }];
    
}

- (void)applyDATA {
    
    QCFriendModel * model = [self.dataArr firstObject];
    //  发送请求
    NSString * str = [NSString stringWithFormat:@"add_type=%@&content=%@&token=%@&touid=%@&uid=%@",@"手机号搜索",[NSString stringWithFormat:@"我是%@",K_NICK],K_TOKEN,model.uid,K_UID];
    
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"add_type":@"手机号搜索",@"content":[NSString stringWithFormat:@"我是%@",K_NICK],@"token":K_TOKEN,@"touid":model.uid,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [QCAFNetWorking QCPOST:@"/api/chat/apply" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
        if ([[responseObject[@"status"] stringValue] isEqualToString:@"1"]) {
            
            //  添加好友
            if ([[responseObject[@"act"] stringValue] isEqualToString:@"0"]) {
                
                
                NSString * msgid = [NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp],model.uid];
                NSString * str = [NSString stringWithFormat:@"applyid=%@&atype=apply&message=添加好友&msgid=%@&touid=%@&type=friend&uid=%@",responseObject[@"data"][@"applyid"],msgid,model.uid,K_UID];
                NSString * signStr = [QCClassFunction MD5:str];
                
                NSDictionary * dic = @{@"applyid":responseObject[@"data"][@"applyid"],@"atype":@"apply",@"message":@"添加好友",@"msgid":msgid ,@"touid":model.uid,@"type":@"friend",@"uid":K_UID};
                NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
                NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [[QCWebSocket shared] sendDataToServer:jsonString];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];

            }

            
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}


@end
