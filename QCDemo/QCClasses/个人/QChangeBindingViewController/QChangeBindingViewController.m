//
//  QChangeBindingViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QChangeBindingViewController.h"

@interface QChangeBindingViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UIButton * clearButton;
@property (nonatomic, strong) UITextField * passwordTextField;
@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UIButton * loginButton;

@end

@implementation QChangeBindingViewController

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
    loginLabel.text = @"更换绑定手机";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"当前手机号:18672910380";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(211) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
    phoneLabel.text = @"+86";
    phoneLabel.font = K_18_FONT;
    phoneLabel.textColor = KTEXT_COLOR;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(207) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.phoneTextField.placeholder = @"请输入新手机号";
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.font = K_18_FONT;
    self.phoneTextField.textColor = KTEXT_COLOR;
    self.phoneTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTextField];
    
    self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(310), KSCALE_WIDTH(207) + KStatusHight,KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
    self.clearButton.hidden = YES;
    [self.clearButton setImage:[UIImage imageNamed:@"叉"] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    

    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(246) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    UILabel * passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(280) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
    passwordLabel.text = @"验证码";
    passwordLabel.font = K_18_FONT;
    passwordLabel.textColor = KTEXT_COLOR;
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordLabel];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(276) + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.passwordTextField.placeholder = @"请输入验证码";
    self.passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTextField.font = K_18_FONT;
    self.passwordTextField.textColor = KTEXT_COLOR;
    self.passwordTextField.textAlignment = NSTextAlignmentLeft;
    self.passwordTextField.delegate = self;
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    self.codeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(262), KSCALE_WIDTH(277) + KStatusHight, KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
    self.codeButton.backgroundColor = KCLEAR_COLOR;
    self.codeButton.titleLabel.font = K_14_FONT;
    self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[QCClassFunction stringTOColor:@"#ffba00"] forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeButton];
    

    UIView * passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(315) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    passwordLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

    [self.view addSubview:passwordLineView];
    
    
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(345) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"确认更换" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    

    
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
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.phoneTextField.text = @"";
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
}


- (void)codeAction:(UIButton *)sender {
    
    // 获取验证码
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    //  获取验证码
    if ([QCClassFunction isMobile:self.phoneTextField.text]) {
        [QCClassFunction showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    
    NSString * str = [NSString stringWithFormat:@"code=%@&mobile=%@&token=%@&uid=%@",self.passwordTextField.text,self.phoneTextField.text,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"mobile":self.phoneTextField.text,@"code":self.passwordTextField.text,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    [QCAFNetWorking QCPOST:@"/api/user/update_mobile" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        if ([responseObject[@"status"] intValue] == 1) {
            [QCClassFunction showMessage:@"更换手机号码成功" toView:self.view];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



#pragma mark - GETDATA
- (void)GETCODE {
    NSString * str = [NSString stringWithFormat:@"mobile=%@&type=%@",self.phoneTextField.text,@"5"];

    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"mobile":self.phoneTextField.text,@"type":@"5"};
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
    
    if (self.phoneTextField.text.length == 11) {
        self.loginButton.selected = YES;
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
        
    }else{
        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
        
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
