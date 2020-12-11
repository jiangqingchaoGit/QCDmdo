//
//  QCTokenViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/10.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCTokenViewController.h"

@interface QCTokenViewController ()
@property (nonatomic, strong) UILabel * groupNoLabel;
@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UILabel * tokenLabel;

@property (nonatomic, strong) UIButton * changeButton;
@property (nonatomic, strong) UIButton * storeButton;


@end

@implementation QCTokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self GETDATA];
}



- (void)GETDATA {

    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&id=%@&token=%@&uid=%@",self.group_id,self.assistantId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"id":self.assistantId,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/aideinfo" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] intValue] == 1) {

            self.groupNoLabel.text = responseObject[@"data"][@"group_code"];
            self.nickLabel.text = responseObject[@"data"][@"name"];
            self.tokenLabel.text = responseObject[@"data"][@"token"];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"令牌信息";
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
    messageLabel.text = @"配置信息";
    messageLabel.font = K_16_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:messageLabel];
    
    
    NSArray * titleArr = @[@"群号：",@"昵称：",@"令牌："];
    NSArray * contentArr = @[@"903664265",@"风城",@"dhkbdjwvdjhannjxcnbc"];

    for (NSInteger i = 0 ; i < 3; i++) {
        
        UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(50) + i * KSCALE_WIDTH(53), KSCALE_WIDTH(50), KSCALE_WIDTH(52))];
        messageLabel.text = titleArr[i];
        messageLabel.font = K_14_FONT;
        messageLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.view addSubview:messageLabel];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(50) + i * KSCALE_WIDTH(53), KSCALE_WIDTH(240), KSCALE_WIDTH(52))];
        label.text = contentArr[i];
        label.font = K_14_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.view addSubview:label];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(102) + KSCALE_WIDTH(53) * i , KSCALE_WIDTH(315), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.view addSubview:lineView];
        
        switch (i) {

            case 0:
                self.groupNoLabel = label;
                break;
            case 1:
                self.nickLabel = label;

                break;
            case 2:
                self.tokenLabel = label;

                break;
                
            default:
                break;
        }
        
    }
    
    self.changeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(156), KSCALE_WIDTH(45), KSCALE_WIDTH(52))];
    self.changeButton.titleLabel.font = K_14_FONT;
    [self.changeButton setTitleColor:[QCClassFunction stringTOColor:@"#ffba00"] forState:UIControlStateNormal];
    [self.changeButton setTitle:@"重置" forState:UIControlStateNormal];
    [self.changeButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeButton];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(230), KSCALE_WIDTH(315), KSCALE_WIDTH(70))];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(5)];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), KSCALE_WIDTH(10), KSCALE_WIDTH(295), KSCALE_WIDTH(50))];
    label.text = @"请妥善保管令牌，如果令牌泄露或被盗请点击“重置”生成新令牌，旧令牌将自动失效";
    label.numberOfLines = 0;
    label.font = K_14_FONT;
    label.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [view addSubview:label];
    
    
    UIView * introduceView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(400), KSCALE_WIDTH(375), KSCREEN_HEIGHT - KSCALE_WIDTH(400))];
    introduceView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:introduceView];
    
    UILabel * introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(420), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
    introduceLabel.text = @"功能介绍";
    introduceLabel.font = K_16_FONT;
    introduceLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:introduceLabel];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(450), KSCALE_WIDTH(315), KSCALE_WIDTH(40))];
    label1.text = @"请妥善保管令牌，如果令牌泄露或被盗请点击“重置”生成新令牌，旧令牌将自动失效";
    label1.font = K_14_FONT;
    label1.numberOfLines = 0;
    label1.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(500), KSCALE_WIDTH(315), KSCALE_WIDTH(60))];
    label2.text = @"使用方法：\n1.请妥善保管令牌\n2.请妥善保管令牌";
    label2.font = K_14_FONT;
    label2.numberOfLines = 0;
    label2.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:label2];
    
    

    self.storeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(320), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.storeButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView:self.storeButton withRadius:KSCALE_WIDTH(8)];
    self.storeButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.storeButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.storeButton setTitle:@"复制群号与令牌" forState:UIControlStateNormal];
    [self.storeButton addTarget:self action:@selector(storeAtion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.storeButton];
}

- (void)changeAction:(UIButton *)sender {
    NSString * str = [NSString stringWithFormat:@"id=%@&token=%@&uid=%@",self.assistantId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"id":self.assistantId,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/aidereset" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        if ([responseObject[@"status"] intValue] == 1) {

            self.tokenLabel.text = responseObject[@"data"][@"token"];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}

- (void)storeAtion:(UIButton *)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    pab.string = [NSString stringWithFormat:@"群号：%@\n令牌：%@",self.groupNoLabel.text,self.tokenLabel.text];
    if (pab == nil) {
        [QCClassFunction showMessage:@"复制失败" toView:self.view];
    } else {
        [QCClassFunction showMessage:@"复制成功" toView:self.view];
    }

}

@end
