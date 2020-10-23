//
//  QCLoginViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCLoginViewController.h"
#import "QCCodeViewController.h"
#import "QCAccountViewController.h"
#import "QCPhoneLoginViewController.h"
#import "QCBindingViewController.h"
#import "QCDisableViewController.h"
#import "QCTitlesViewController.h"
#import "QCBindWechatViewController.h"

@interface QCLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UIButton * clearButton;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * phoneButton;
@property (nonatomic, strong) UIButton * accountButton;
@property (nonatomic, strong) UIButton * wechatButton;
@property (nonatomic, strong) UIButton * agreementButton;

@end

@implementation QCLoginViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
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
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(125), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    loginLabel.text = @"登录多多";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(160), KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"如未注册账号，手机验证码即自动注册";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(231), KSCALE_WIDTH(40), KSCALE_WIDTH(24))];
    phoneLabel.text = @"+86";
    phoneLabel.font = K_18_FONT;
    phoneLabel.textColor = KTEXT_COLOR;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(266), KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:lineView];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(227), KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.phoneTextField.placeholder = @"请输入您的手机号码";
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.font = K_20_BFONT;
    self.phoneTextField.textColor = KTEXT_COLOR;
    self.phoneTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTextField];

    
    self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(310), KSCALE_WIDTH(227),KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
    self.clearButton.hidden = YES;
//    [self.clearButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [self.clearButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(295), KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    self.phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(362), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
    self.phoneButton.backgroundColor = KCLEAR_COLOR;
    self.phoneButton.titleLabel.font = K_14_FONT;
    self.phoneButton.hidden = YES;
    self.phoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.phoneButton setTitle:@"本机号码登录" forState:UIControlStateNormal];
    [self.phoneButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [self.phoneButton addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.phoneButton];

    self.accountButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(258), KSCALE_WIDTH(362), KSCALE_WIDTH(84), KSCALE_WIDTH(30))];
    self.accountButton.backgroundColor = KCLEAR_COLOR;
    self.accountButton.titleLabel.font = K_14_FONT;
    self.accountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.accountButton setTitle:@"密码登录" forState:UIControlStateNormal];
    [self.accountButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [self.accountButton addTarget:self action:@selector(accountAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.accountButton];
    
    
    self.wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(157.5), KSCALE_HEIGHT(540), KSCALE_WIDTH(60), KSCALE_WIDTH(60))];
    [self.wechatButton setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [QCClassFunction filletImageView:self.wechatButton withRadius:KSCALE_WIDTH(30)];
    [self.wechatButton addTarget:self action:@selector(wechatAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wechatButton];
    
    UILabel * weChatLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_HEIGHT(600), KSCALE_WIDTH(375), KSCALE_WIDTH(28))];
    weChatLabel.text = @"微信登录";
    weChatLabel.font = K_14_FONT;
    weChatLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];;
    weChatLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weChatLabel];
    
    UILabel * agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_HEIGHT(627), KSCALE_WIDTH(375), KSCALE_WIDTH(40))];
    agreementLabel.text = @"登录即代表您同意《用户服务协议》及《隐私政策》";
    agreementLabel.font = K_13_FONT;
    agreementLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    agreementLabel.textAlignment = NSTextAlignmentCenter;
    agreementLabel.attributedText = [QCClassFunction getColorWithString:agreementLabel.text andTargetString:@"《用户服务协议》及《隐私政策》" withColor:KTEXT_COLOR];
    [self.view addSubview:agreementLabel];
    
    self.agreementButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_HEIGHT(627), KSCALE_WIDTH(375), KSCALE_WIDTH(40))];
    self.agreementButton.backgroundColor = KCLEAR_COLOR;
    [self.agreementButton addTarget:self action:@selector(agreementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreementButton];
    
}


#pragma mark - tapAction

- (void)resignAction {
    [self.phoneTextField resignFirstResponder];
}

- (void)backAction:(UIButton *)sender {
    //  关闭
    [self.phoneTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearAction:(UIButton *)sender {
    self.clearButton.hidden = YES;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.phoneTextField.text = @"";
    [self.phoneTextField resignFirstResponder];


}
- (void)loginAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];

    //  获取验证码
    if ([QCClassFunction isMobile:self.phoneTextField.text]) {
        [QCClassFunction showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    QCCodeViewController * codeViewController = [[QCCodeViewController alloc] init];
    codeViewController.hidesBottomBarWhenPushed = YES;
    codeViewController.phoneStr = self.phoneTextField.text;
    [self.navigationController pushViewController:codeViewController animated:YES];
}

- (void)phoneAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];

    //  本机号码登录
    
    QCPhoneLoginViewController * phoneLoginViewController = [[QCPhoneLoginViewController alloc] init];
    phoneLoginViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:phoneLoginViewController animated:YES];

}
- (void)accountAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];

    //  账号密码登录
    QCAccountViewController * accountViewController = [[QCAccountViewController alloc] init];
    accountViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:accountViewController animated:YES];
}
- (void)wechatAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {


        NSLog(@"%@",result);
    }];
    //  微信登录
    
//    return;;
    
    NSString * str = [NSString stringWithFormat:@"device=%@&device_type=%@&device_version=%@&imei=%@&unionid=%@",K_TYPE,@"iOS",K_systemVersion,K_UUID,@"11112222"];

    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"device":K_TYPE,@"device_type":@"iOS",@"device_version":K_systemVersion,@"imei":K_UUID,@"unionid":@"11112222"};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    
    [QCAFNetWorking QCPOST:@"/api/weixin_login" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        
        QCBindWechatViewController * bindWechatViewController = [[QCBindWechatViewController alloc] init];
        bindWechatViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bindWechatViewController animated:YES];
        
        NSLog(@"%@",responseObject[@"msg"]);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}

- (void)agreementAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];
    
//
//    QCBindingViewController * bindingViewController = [[QCBindingViewController alloc] init];
//    bindingViewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:bindingViewController animated:YES];
//    
    QCTitlesViewController * bindingViewController = [[QCTitlesViewController alloc] init];
    bindingViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bindingViewController animated:YES];
    //  登录协议
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    
    if (sender.text.length == 11) {
        self.loginButton.selected = YES;
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];

    }else{
        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];

    }

}


- ( BOOL )textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string {

    self.clearButton.hidden = NO;
    if (range.location > 10) {
        return NO;
    }

    return YES;
}




@end
