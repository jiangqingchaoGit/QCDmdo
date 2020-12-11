//
//  QCChangePasswordViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChangePasswordViewController.h"

@interface QCChangePasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * clearButton;
@property (nonatomic, strong) UITextField * oldpasswordTextField;

@property (nonatomic, strong) UITextField * passwordTextField;
@property (nonatomic, strong) UITextField * surePasswordTextField;



@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UIButton * loginButton;

@end

@implementation QCChangePasswordViewController

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
    loginLabel.text = @"修改登录密码";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"验证码将发送至+86 18672910380";
    tipLabel.font = K_14_FONT;
    tipLabel.hidden = YES;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(211) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
    passwordLabel.text = @"原密码";
    passwordLabel.font = K_18_FONT;
    passwordLabel.textColor = KTEXT_COLOR;
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordLabel];
    
    self.oldpasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(207) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.oldpasswordTextField.placeholder = @"请输入原始密码";
    self.oldpasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.oldpasswordTextField.font = K_18_FONT;
    self.oldpasswordTextField.textColor = KTEXT_COLOR;
    self.oldpasswordTextField.textAlignment = NSTextAlignmentLeft;
    self.oldpasswordTextField.secureTextEntry = YES;
    self.oldpasswordTextField.delegate = self;
    [self.oldpasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.oldpasswordTextField];
    
    self.codeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(262), KSCALE_WIDTH(208) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
    self.codeButton.backgroundColor = KCLEAR_COLOR;
    self.codeButton.titleLabel.font = K_14_FONT;
    self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.codeButton.hidden = YES;
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[QCClassFunction stringTOColor:@"#ffba00"] forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(246) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    UILabel * passLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(280) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
    passLabel.text = @"新密码";
    passLabel.font = K_18_FONT;
    passLabel.textColor = KTEXT_COLOR;
    passLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passLabel];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(276) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.passwordTextField.placeholder = @"请输入新密码";
    self.passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTextField.font = K_18_FONT;
    self.passwordTextField.textColor = KTEXT_COLOR;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    self.passwordTextField.delegate = self;
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    UIView * passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(315) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    passwordLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:passwordLineView];
    
    UILabel * surepassLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(349) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
    surepassLabel.text = @"确认密码";
    surepassLabel.font = K_18_FONT;
    surepassLabel.textColor = KTEXT_COLOR;
    surepassLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:surepassLabel];
    
    self.surePasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(345) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.surePasswordTextField.placeholder = @"请再次输入新密码";
    self.surePasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.surePasswordTextField.font = K_18_FONT;
    self.surePasswordTextField.textColor = KTEXT_COLOR;
    self.surePasswordTextField.secureTextEntry = YES;
    self.surePasswordTextField.textAlignment = NSTextAlignmentLeft;
    self.surePasswordTextField.delegate = self;
    [self.surePasswordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.surePasswordTextField];
    
    UIView * surepasswordLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(384) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    surepasswordLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

    [self.view addSubview:surepasswordLineView];

    UILabel * markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(384) + KStatusHight, KSCALE_WIDTH(375), KSCALE_WIDTH(40))];
    markLabel.text = @"提示:密码必须为8-16位数字+字母组合(不能为纯数字)";
    markLabel.font = K_12_FONT;
    markLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    markLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:markLabel];

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(460) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.loginButton.titleLabel.font = K_18_FONT;
//    self.loginButton.selected = NO;
//    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"重置密码" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
//    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    

    
}


#pragma mark - tapAction

- (void)resignAction {
    [self.oldpasswordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surePasswordTextField resignFirstResponder];

    
}

- (void)backAction:(UIButton *)sender {
    //  关闭
    [self.oldpasswordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surePasswordTextField resignFirstResponder];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearAction:(UIButton *)sender {
    self.clearButton.hidden = YES;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.oldpasswordTextField.text = @"";
    [self.oldpasswordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surePasswordTextField resignFirstResponder];

    
}


- (void)codeAction:(UIButton *)sender {
    
    // 获取验证码
    [self.oldpasswordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surePasswordTextField resignFirstResponder];

    [self GETCODE];
    __block NSInteger time = 59; //倒计时时间
    //  执行异步任务
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //  iOS计时器
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = YES;
                
            });
            
        }else{ int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果

                [self.codeButton setTitle:[NSString stringWithFormat:@" %.2ds",seconds] forState:UIControlStateNormal];

                self.codeButton.userInteractionEnabled = NO;
                
            });
            time--;
            
        } });
    dispatch_resume(_timer);
    
    
}
- (void)loginAction:(UIButton *)sender {
    [self.oldpasswordTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surePasswordTextField resignFirstResponder];

    //  获取验证码
//    if ([QCClassFunction isMobile:self.oldpasswordTextField.text]) {
//        [QCClassFunction showMessage:@"请输入正确的手机号码" toView:self.view];
//        return;
//    }
    
    NSString * str = [NSString stringWithFormat:@"password=%@&rpassword=%@&token=%@&uid=%@",self.oldpasswordTextField.text,self.passwordTextField.text,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"password":self.oldpasswordTextField.text,@"rpassword":self.passwordTextField.text,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    [QCAFNetWorking QCPOST:@"/api/user/update_pwd" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        
        NSLog(@"%@",responseObject[@"msg"]);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



#pragma mark - GETDATA
- (void)GETCODE {
    NSString * str = [NSString stringWithFormat:@"mobile=%@&type=%@",self.oldpasswordTextField.text,@"1"];

    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"mobile":self.oldpasswordTextField.text,@"type":@"1"};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    
    [QCAFNetWorking QCPOST:@"/api/send" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        NSDictionary * data = responseObject[@"data"];
        
        if ([responseObject[@"status"] intValue] == 1) {
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
    
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
//
//    if (self.oldpasswordTextField.text.length == 11) {
//        self.loginButton.selected = YES;
//        self.loginButton.userInteractionEnabled = YES;
//        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
//
//    }else{
//        self.loginButton.selected = NO;
//        self.loginButton.userInteractionEnabled = NO;
//        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
//
//    }
    
}


- ( BOOL )textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string {
    
    self.clearButton.hidden = NO;
    
    if (textField == self.oldpasswordTextField) {
        if (range.location > 10) {
            return NO;
        }
    }
    
    
    return YES;
}


@end
