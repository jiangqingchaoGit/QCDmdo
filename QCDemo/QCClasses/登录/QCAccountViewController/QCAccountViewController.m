//
//  QCAccountViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/15.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAccountViewController.h"

@interface QCAccountViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UIButton * clearButton;
@property (nonatomic, strong) UITextField * passwordTextField;
@property (nonatomic, strong) UIButton * eyeButton;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * forgetButton;
@property (nonatomic, strong) UIButton * agreementButton;

@end

@implementation QCAccountViewController

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
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(105) + KStatusHight, KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    loginLabel.text = @"密码登录";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"牢记密码，欢乐多多";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(211) + KStatusHight, KSCALE_WIDTH(40), KSCALE_WIDTH(24))];
    phoneLabel.text = @"+86";
    phoneLabel.font = K_18_FONT;
    phoneLabel.textColor = KTEXT_COLOR;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(207) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.phoneTextField.placeholder = @"请输入您的手机号码";
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.font = K_20_BFONT;
    self.phoneTextField.textColor = KTEXT_COLOR;
    self.phoneTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTextField];
    
    self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(310), KSCALE_WIDTH(207) + KStatusHight,KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
    self.clearButton.hidden = YES;
    //    [self.clearButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.clearButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(246) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:lineView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(280) + KStatusHight, KSCALE_WIDTH(50), KSCALE_WIDTH(24))];
    passwordLabel.text = @"密码";
    passwordLabel.font = K_18_FONT;
    passwordLabel.textColor = KTEXT_COLOR;
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordLabel];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(276) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.font = K_20_BFONT;
    self.passwordTextField.textColor = KTEXT_COLOR;
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    self.passwordTextField.delegate = self;
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    self.eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(310), KSCALE_WIDTH(276) + KStatusHight,KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
    //    [self.eyeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.eyeButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.eyeButton setImage:KHeaderImage forState:UIControlStateSelected];
    
    [self.eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.eyeButton];
    
    UIView * passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(315) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    passwordLineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:passwordLineView];
    
    
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(345) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    self.forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(258), KSCALE_WIDTH(412) + KStatusHight, KSCALE_WIDTH(84), KSCALE_WIDTH(30))];
    self.forgetButton.backgroundColor = KCLEAR_COLOR;
    self.forgetButton.titleLabel.font = K_14_FONT;
    self.forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetButton];
    
    
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
    [self.passwordTextField resignFirstResponder];
    
}

- (void)backAction:(UIButton *)sender {
    //  关闭
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearAction:(UIButton *)sender {
    self.clearButton.hidden = YES;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    self.phoneTextField.text = @"";
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}

- (void)eyeAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        self.passwordTextField.secureTextEntry = YES;
        
    }else{
        sender.selected = YES;
        self.passwordTextField.secureTextEntry = NO;
        
    }
}
- (void)loginAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    //  获取验证码
    if ([QCClassFunction isMobile:self.phoneTextField.text]) {
        [QCClassFunction showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    
    NSString * str = [NSString stringWithFormat:@"mobile=%@&password=%@",self.phoneTextField.text,self.passwordTextField.text];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"password":self.passwordTextField.text,@"mobile":self.phoneTextField.text};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    [QCAFNetWorking QCPOST:@"/api/login" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        
        NSLog(@"%@",responseObject[@"msg"]);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}




- (void)forgetAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    //  账号密码登录
}

- (void)agreementAction:(UIButton *)sender {
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    //  登录协议
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    
    if (self.phoneTextField.text.length == 11) {
        self.loginButton.selected = YES;
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        
    }else{
        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        
    }
    
}


- ( BOOL )textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string {
    
    self.clearButton.hidden = NO;
    
    if (textField == self.phoneTextField) {
        if (range.location > 10) {
            return NO;
        }
    }
    
    
    return YES;
}




@end
