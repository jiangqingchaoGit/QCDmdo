//
//  QCBindWechatViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCBindWechatViewController.h"
#import "QCCodeViewController.h"
@interface QCBindWechatViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UIButton * clearButton;
@property (nonatomic, strong) UIButton * loginButton;


@end

@implementation QCBindWechatViewController

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
    loginLabel.text = @"绑定手机号";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"微信第一次登录，需要绑定用户手机号";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(211) + + KStatusHight, KSCALE_WIDTH(40), KSCALE_WIDTH(24))];
    phoneLabel.text = @"+86";
    phoneLabel.font = K_18_FONT;
    phoneLabel.textColor = KTEXT_COLOR;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(246) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(207) + + KStatusHight, KSCALE_WIDTH(250), KSCALE_WIDTH(32))];
    self.phoneTextField.placeholder = @"请输入您的手机号码";
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.font = K_20_BFONT;
    self.phoneTextField.textColor = KTEXT_COLOR;
    self.phoneTextField.textAlignment = NSTextAlignmentLeft;
    self.phoneTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneTextField];

    
    self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(310), KSCALE_WIDTH(207) + + KStatusHight,KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
    self.clearButton.hidden = YES;
//    [self.clearButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [self.clearButton setImage:[UIImage imageNamed:@"叉"] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(275) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
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
    codeViewController.unionid = self.unionid;
    codeViewController.typeStr = @"5";

    [self.navigationController pushViewController:codeViewController animated:YES];
}



#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)sender {
    
    if (sender.text.length == 11) {
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
    if (range.location > 10) {
        return NO;
    }

    return YES;
}




@end
