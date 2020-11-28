//
//  QCRealnameViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCRealnameViewController.h"

@interface QCRealnameViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UITextField * cardTextField;
@property (nonatomic, strong) UIButton * loginButton;

@property (nonatomic, strong) UILabel * loginLabel;

@end

@implementation QCRealnameViewController

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
    
    self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(105) + KStatusHight, KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.loginLabel.text = @"实名认证";
    self.loginLabel.font = K_24_BFONT;
    self.loginLabel.textColor = KTEXT_COLOR;
    self.loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"用户姓名必须与身份证信息一致哟";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(209) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    NSArray * titleArr = @[@"姓名",@"身份证"];
    NSArray * marksArr = @[@"请输入用户姓名",@"请输入身份证号码"];

    for (NSInteger i = 0; i < 2; i++) {
        
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(210) + KStatusHight + i * KSCALE_WIDTH(59), KSCALE_WIDTH(80), KSCALE_WIDTH(58))];
        nameLabel.text = titleArr[i];
        nameLabel.font = K_16_FONT;
        nameLabel.textColor = KTEXT_COLOR;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:nameLabel];
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(210) + KStatusHight + i * KSCALE_WIDTH(59), KSCALE_WIDTH(220), KSCALE_WIDTH(58))];
        textField.placeholder = marksArr[i];
        textField.font = K_16_FONT;
        textField.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        textField.textAlignment = NSTextAlignmentLeft;
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:textField];
        
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(268) + KStatusHight + i * KSCALE_WIDTH(59), KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.view addSubview:lineView];
        
        switch (i) {
            case 0:
                self.nameTextField = textField;
                break;
            case 1:
                self.cardTextField = textField;
                self.cardTextField.keyboardType = UIKeyboardTypeNumberPad;

                break;
                
            default:
                break;
        }
    }

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(380) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.loginButton.titleLabel.font = K_18_FONT;
    [self.loginButton setTitle:@"实名认证" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    
    
    
    
}


#pragma mark - tapAction

- (void)resignAction {
    [self.nameTextField resignFirstResponder];
    [self.cardTextField resignFirstResponder];
    
}

- (void)backAction:(UIButton *)sender {
    //  关闭
    [self.nameTextField resignFirstResponder];
    [self.cardTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)loginAction:(UIButton *)sender {
    [self.nameTextField resignFirstResponder];
    [self.cardTextField resignFirstResponder];
    //  获取验证码
    if ([self.nameTextField.text isEqual:@""] || self.nameTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入用户姓名" toView:self.view];
        return;
    }
    
    

    if ( [QCClassFunction validateIdentityCard:self.cardTextField.text]) {
        
    }else{
        [QCClassFunction showMessage:@"身份证信息输入错误，请重新输入" toView:self.view];
        return;

    }
    
    //  认证成功
    [self GETDATA];
    
    
}

#pragma mark -GETDATA
- (void)GETDATA {
    
    

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * str = [NSString stringWithFormat:@"identifyNum=%@&real_name=%@&token=%@&uid=%@",self.cardTextField.text,self.nameTextField.text,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"identifyNum":self.cardTextField.text,@"real_name":self.nameTextField.text,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
  
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/verified" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            [QCClassFunction showMessage:@"实名认证成功" toView:self.view];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
        }


    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {

    
}

@end
