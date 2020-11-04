//
//  QCSearchViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSearchViewController.h"

@interface QCSearchViewController ()
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * sexImageView;

@property (nonatomic, strong) UIButton * addButton;

@end

@implementation QCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self GETDATA];
}

//  89047
//

#pragma mark - tapAction
- (void)addAction:(UIButton *)sender {
    //  添加好友
    NSString * msgid = [NSString stringWithFormat:@"%@%@",K_UID,[QCClassFunction getNowTimeTimestamp]];
    NSString * str = [NSString stringWithFormat:@"message=添加好友&msgid=%@&touid=%@&type=apply&uid=%@",msgid,K_TUID,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"message":@"添加好友",@"msgid":msgid ,@"touid":K_TUID,@"type":@"apply",@"uid":K_UID};
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[QCWebSocket shared] sendDataToServer:jsonString];

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
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.view addSubview:self.headerImageView];


    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(27))];
    self.nameLabel.text = @"思绪云骞";
    self.nameLabel.font = K_16_FONT;
    self.nameLabel.textColor = KTEXT_COLOR;
    [self.view addSubview:self.nameLabel];
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(80), KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.addButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    self.addButton.titleLabel.font = K_18_FONT;
    [self.addButton setTitle:@"添加好友" forState:UIControlStateNormal];
    [self.addButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.addButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.addButton];

    
}



#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"keyword=%@&token=%@&uid=%@",self.searchStr,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"keyword":self.searchStr,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/search" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        NSDictionary * data = responseObject[@"data"];
        
        NSLog(@"%@",data);
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}


@end
