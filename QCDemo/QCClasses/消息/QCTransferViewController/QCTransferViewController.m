//
//  QCTransferViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/25.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCTransferViewController.h"
#import "QCPayView.h"
#import "QCPayTypeView.h"
@interface QCTransferViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * moneyTextField;
@property (nonatomic, strong) UIButton * loginButton;

@property (nonatomic, strong) QCPayView * payView;
@property (nonatomic, strong) QCPayTypeView * payTypeView;

@end

@implementation QCTransferViewController

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

    self.payType = @"1";
    [self initUI];
    

}

#pragma mark - tapAction

- (void)resignAction {
    [self.moneyTextField resignFirstResponder];
}


- (void)buttonAction:(UIButton *)sender {
    //  选择银行卡
    kWeakSelf(self);

    [self.moneyTextField resignFirstResponder];
    UIView * backView = [[QCClassFunction shared] createBackView];
    self.payTypeView = [[QCPayTypeView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(312), KSCALE_WIDTH(375), KSCALE_WIDTH(312))];
    self.payTypeView.statusStr = @"1";
    self.payTypeView.typeStr = @"转账";
    [self.payTypeView initUI];
    self.payTypeView.typeBlock = ^(NSDictionary * _Nonnull payTypeDic) {
        weakself.bankLabel.text = [NSString stringWithFormat:@"%@（%@）",payTypeDic[@"payName"],payTypeDic[@"payNo"]];
    };

    [backView addSubview:self.payTypeView];
    

}

- (void)loginAction:(UIButton *)sender {
    //  充值
    
    
    if ([[QCClassFunction Read:@"wallet"] isEqualToString:@"0"]) {

        //  开通说明
        QCOpenViewController * openViewController = [[QCOpenViewController alloc] init];
        openViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:openViewController animated:YES];
        return;
        
    }else if([[QCClassFunction Read:@"realName"] isEqualToString:@""] || [QCClassFunction Read:@"realName"] == nil) {
        
        //  开通说明
        QCRealnameViewController * realnameViewController = [[QCRealnameViewController alloc] init];
        realnameViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:realnameViewController animated:YES];
        return;

    }else{


    }
    
    
    
    
    [self.moneyTextField resignFirstResponder];
    UIView * backView = [[QCClassFunction shared] createBackView];


    self.payView = [[QCPayView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCREEN_HEIGHT / 2.0 - KSCALE_WIDTH(180), KSCALE_WIDTH(315), KSCALE_WIDTH(315))];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"red_price":self.moneyTextField.text,@"method":self.payType,@"bankId":self.bankId?self.bankId:@""}];
    self.payView.messageDic = dic;
    self.payView.type = @"1";
    [self.payView initUI];
    [backView addSubview:self.payView];
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    if ([sender.text floatValue] > 0) {
        self.loginButton.selected = YES;
        self.loginButton.userInteractionEnabled = YES;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];

    }else{
        self.loginButton.selected = NO;
        self.loginButton.userInteractionEnabled = NO;
        self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];

    }

}
#pragma mark  - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title  = @"转账";
    
    UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(20), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
    typeLabel.text = @"支付方式";
    typeLabel.font = K_14_FONT;
    typeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:typeLabel];
    
    self.bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(20), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.bankLabel.text = @"农业银行（**8673）";
    self.bankLabel.font = K_16_FONT;
    self.bankLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:self.bankLabel];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(50), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    contentLabel.text = @"单日交易限额￥50000.0";
    contentLabel.font = K_14_FONT;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:contentLabel];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(42), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    imageView.image = [UIImage imageNamed:@"leftarrow"];
    [self.view addSubview:imageView];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(70))];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UILabel * topupLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(120), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
    topupLabel.text = @"转账金额";
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
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(275) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    self.loginButton.selected = NO;
    self.loginButton.userInteractionEnabled = NO;
    [self.loginButton setTitle:@"转账" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.loginButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
}




@end
