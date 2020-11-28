//
//  QCOpenViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOpenViewController.h"
#import "QCRealnameViewController.h"
@interface QCOpenViewController ()

@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIImageView * agreeImageView;


@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * loginLabel;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) UIButton * agreeButton;
@property (nonatomic, strong) UIButton * loginButton;

@end

@implementation QCOpenViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBACK_COLOR;
    [self initUI];
}


#pragma mark - initUI
- (void)initUI {
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), 0, KSCALE_WIDTH(265), KSCALE_WIDTH(150))];
    self.backImageView.image = [UIImage imageNamed:@"底图"];
    [self.view addSubview:self.backImageView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
   
    self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(105) + KStatusHight, KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.loginLabel.text = @"多多钱包开通说明";
    self.loginLabel.font = K_24_BFONT;
    self.loginLabel.textColor = KTEXT_COLOR;
    self.loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"您即将开通多多钱包";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(190) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(65))];
    self.messageLabel.text = @"多多钱包由新生支付提供，多多将向新生支付提供您的个人身份信息，用于开通新生支付账号，如您同意开通，请点击【同意授权】按钮。";
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = K_14_FONT;
    self.messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.messageLabel];
    
    
    self.agreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(312) + KStatusHight, KSCALE_WIDTH(20), KSCALE_WIDTH(20))];
    self.agreeImageView.image = [UIImage imageNamed:@"unselected_p"];
    [self.view addSubview: self.agreeImageView];
    
    UILabel * markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(60), KSCALE_WIDTH(315) + KStatusHight, KSCALE_WIDTH(240), KSCALE_WIDTH(14))];
    markLabel.font = KSCALE_FONT(14);
    markLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.text = @"已阅读同意《支付用户服务协议》";
    [self.view addSubview:markLabel];
    
    self.agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(305) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(34))];
    self.agreeButton.backgroundColor = KCLEAR_COLOR;
    [self.agreeButton addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreeButton];
    

    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(360) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"同意授权" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    
    
    
    
}


#pragma mark - tapAction



- (void)backAction:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}



- (void)loginAction:(UIButton *)sender {
    [self GETDATA];
}



- (void)agreeAction:(UIButton *)sender {
    if (sender.selected) {
        self.agreeImageView.image = [UIImage imageNamed:@"unselected_p"];
        sender.selected = NO;

        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
        

    }else{
        self.agreeImageView.image = [UIImage imageNamed:@"selected_p"];
        sender.selected = YES;

        self.loginButton.selected = YES;
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];

    }
    




}


#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/pay_wallet" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            //  跳个人认证界面
            QCRealnameViewController * realnameViewController = [[QCRealnameViewController alloc] init];
            realnameViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:realnameViewController animated:YES];
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



@end
