//
//  QCWithdrawalViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCWithdrawalViewController.h"
#import "QCPayView.h"

//  提现  
@interface QCWithdrawalViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * bankLabel;
@property (nonatomic, strong) UITextField * moneyTextField;
@property (nonatomic, strong) UIButton * immediatelyButton;
@property (nonatomic, strong) UILabel * restLabel;
@property (nonatomic, strong) UIButton * allButton;

@property (nonatomic, strong) UIButton * loginButton;



@property (nonatomic, strong) QCPayView * payView;

@end

@implementation QCWithdrawalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}


//在页面消失的时候就让navigationbar还原样式

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];

    [self initUI];
    

}

#pragma mark - tapAction

- (void)resignAction {
    [self.moneyTextField resignFirstResponder];
}


- (void)buttonAction:(UIButton *)sender {
    //  选择银行卡
    [self.moneyTextField resignFirstResponder];

}


- (void)immediatelyAction:(UIButton *)sender {
    //  开通会员界面
}

- (void)allAction:(UIButton *)sender {
    //  全部提现
}
- (void)loginAction:(UIButton *)sender {
    //  充值
    [self.moneyTextField resignFirstResponder];
    UIView * backView = [[QCClassFunction shared] createBackView];


    self.payView = [[QCPayView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(120), KSCALE_WIDTH(315), KSCALE_WIDTH(315))];
    [backView addSubview:self.payView];
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    if ([sender.text floatValue] > 0) {
        self.loginButton.selected = YES;
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];

    }else{
        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];

    }

}
#pragma mark  - initUI
- (void)initUI {
    
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.title  = @"提现";
    
    UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(20), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
    typeLabel.text = @"到账银行卡";
    typeLabel.font = K_14_FONT;
    typeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:typeLabel];
    
    self.bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(20), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.bankLabel.text = @"农业银行（**8673）";
    self.bankLabel.font = K_16_FONT;
    self.bankLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:self.bankLabel];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(50), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    contentLabel.text = @"2小时内到账";
    contentLabel.font = K_14_FONT;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:contentLabel];
    
    self.immediatelyButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(220), KSCALE_WIDTH(40), KSCALE_WIDTH(100), KSCALE_WIDTH(40))];
    self.immediatelyButton.titleLabel.font = K_14_FONT;
    [self.immediatelyButton setTitle:@"开启秒到" forState:UIControlStateNormal];
    [self.immediatelyButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [self.immediatelyButton addTarget:self action:@selector(immediatelyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.immediatelyButton];
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(42), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    imageView.image = KHeaderImage;
    [self.view addSubview:imageView];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(70))];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UILabel * topupLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(120), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
    topupLabel.text = @"提现金额";
    topupLabel.font = K_14_FONT;
    topupLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:topupLabel];
    
    UILabel * coinLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(150), KSCALE_WIDTH(40), KSCALE_WIDTH(50))];
    coinLabel.text = @"¥";
    coinLabel.font = K_36_BFONT;
    coinLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:coinLabel];
    
    
    self.moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(155), KSCALE_WIDTH(265), KSCALE_WIDTH(40))];
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField.font = K_36_BFONT;
    self.moneyTextField.textColor = KTEXT_COLOR;
    self.moneyTextField.textAlignment = NSTextAlignmentLeft;
    [self.moneyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.moneyTextField];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(200), KSCALE_WIDTH(315), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#999999"];
    [self.view addSubview:lineView];
    
    
    self.restLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(211), KSCALE_WIDTH(180), KSCALE_WIDTH(20))];
    self.restLabel.text = @"当前零钱余额：2956.00元";
    self.restLabel.font = K_14_FONT;
    self.restLabel.textColor = [QCClassFunction stringTOColor:@"#999999"];
    [self.view addSubview:self.restLabel];
    
    
    
    self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(210), KSCALE_WIDTH(201), KSCALE_WIDTH(60), KSCALE_WIDTH(40))];
    self.allButton.titleLabel.font = K_14_FONT;
    [self.allButton setTitle:@"全部提现" forState:UIControlStateNormal];
    [self.allButton setTitleColor:[QCClassFunction stringTOColor:@"#3399FF"] forState:UIControlStateNormal];
    [self.allButton addTarget:self action:@selector(allAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.allButton];
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(275) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"提现" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
}

@end
