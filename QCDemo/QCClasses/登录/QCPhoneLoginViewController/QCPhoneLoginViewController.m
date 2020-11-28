//
//  QCPhoneLoginViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/15.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPhoneLoginViewController.h"

@interface QCPhoneLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * accountButton;
@property (nonatomic, strong) UIButton * wechatButton;
@property (nonatomic, strong) UIButton * agreementButton;

@end

@implementation QCPhoneLoginViewController

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
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(105) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(30))];
    loginLabel.text = @"本机号码一键登录";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"本机号码，一键登录";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(215) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(30))];
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",@"186****0380"];
    self.phoneLabel.font = K_28_BFONT;
    self.phoneLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.phoneLabel];
    

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(275) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.loginButton.titleLabel.font = K_18_FONT;
    [self.loginButton setTitle:@"确认登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    

    self.accountButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(208), KSCALE_WIDTH(342) + KStatusHight, KSCALE_WIDTH(134), KSCALE_WIDTH(30))];
    self.accountButton.backgroundColor = KCLEAR_COLOR;
    self.accountButton.titleLabel.font = K_14_FONT;
    self.accountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.accountButton setTitle:@"使用其他号码" forState:UIControlStateNormal];
    [self.accountButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [self.accountButton addTarget:self action:@selector(accountAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.accountButton];
    
    
    self.wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(157.5), KSCALE_HEIGHT(540), KSCALE_WIDTH(60), KSCALE_WIDTH(60))];
    [self.wechatButton setImage:KHeaderImage forState:UIControlStateNormal];
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
    agreementLabel.text = @"登录即同意《中国联通认证服务协议》并授权获得本机号码";
    agreementLabel.font = K_13_FONT;
    agreementLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    agreementLabel.textAlignment = NSTextAlignmentCenter;
    agreementLabel.attributedText = [QCClassFunction getColorWithString:agreementLabel.text andTargetString:@"《中国联通认证服务协议》" withColor:KTEXT_COLOR];
    [self.view addSubview:agreementLabel];
    
    self.agreementButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_HEIGHT(627), KSCALE_WIDTH(375), KSCALE_WIDTH(40))];
    self.agreementButton.backgroundColor = KCLEAR_COLOR;
    [self.agreementButton addTarget:self action:@selector(agreementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.agreementButton];
    
}


#pragma mark - tapAction


- (void)backAction:(UIButton *)sender {
    //  关闭
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loginAction:(UIButton *)sender {
    
}


- (void)accountAction:(UIButton *)sender {

   
}
- (void)wechatAction:(UIButton *)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
            
        
        NSLog(@"%@",result);
    }];
    //  微信登录
}

- (void)agreementAction:(UIButton *)sender {


    //  登录协议
}







@end
