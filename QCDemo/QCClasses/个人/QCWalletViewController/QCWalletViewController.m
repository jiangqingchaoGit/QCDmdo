//
//  QCWalletViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCWalletViewController.h"
//  收支明细
#import "QCPaymentsViewController.h"
//  红包明细
#import "QCEnvelopeViewController.h"
//  我的银行卡
#import "QCBankViewController.h"
//  提现人脸认证
#import "QCCertificationViewController.h"
//  实名认证
#import "QCRealnameViewController.h"
#import "QCRealnamedViewController.h"

@interface QCWalletViewController ()
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * eyeButton;

@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) NSString * moneyStr;

@end

@implementation QCWalletViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self GETDATA];
}

#pragma mark -GETDATA
- (void)GETDATA {
    
    
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
  
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/getinfo" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        NSDictionary * data = responseObject[@"data"];
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            self.moneyStr = data[@"balance"];

        }

        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

#pragma mark - tapAction

- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)eyeAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        self.moneyLabel.text = @"******";

    }else{
        sender.selected = YES;
        self.moneyLabel.text = self.moneyStr;


    }
}

- (void)functionAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            
            break;
        case 2:
        {

            
            if ([[QCClassFunction Read:@"cardNum"] isEqual:@""] || [QCClassFunction Read:@"cardNum"] == nil) {
                QCRealnameViewController * realnameViewController = [[QCRealnameViewController alloc] init];
                realnameViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:realnameViewController animated:YES];
            }else{
                QCCertificationViewController * certificationViewController = [[QCCertificationViewController alloc] init];
                certificationViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:certificationViewController animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}
- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {

        case 1:
        {
            QCPaymentsViewController * paymentsViewController = [[QCPaymentsViewController alloc] init];
            paymentsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:paymentsViewController animated:YES];
        }
            break;
        case 2:
        {
            QCEnvelopeViewController * envelopeViewController = [[QCEnvelopeViewController alloc] init];
            envelopeViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:envelopeViewController animated:YES];
        }
            break;
        case 3:
   
        {
            if ([[QCClassFunction Read:@"cardNum"] isEqual:@""] || [QCClassFunction Read:@"cardNum"] == nil) {

                QCRealnameViewController * realnameViewController = [[QCRealnameViewController alloc] init];
                realnameViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:realnameViewController animated:YES];
            }else{
                QCRealnamedViewController * realnamedViewController = [[QCRealnamedViewController alloc] init];
                realnamedViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:realnamedViewController animated:YES];
            }

            

        }
            break;
        case 4:
        {
            QCBankViewController * bankViewController = [[QCBankViewController alloc] init];
            bankViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bankViewController animated:YES];
        }
            
            break;
        case 5:
        {

        }
            break;
            
        default:
            break;
    }
}
#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(266) + KTabHight)];
    backView.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    [self.view addSubview:backView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(375) - 56, KNavHight - 44, 56, 44)];
    [self.eyeButton setImage:[UIImage imageNamed:@"查看"] forState:UIControlStateNormal];
    [self.eyeButton setImage:[UIImage imageNamed:@"影藏"] forState:UIControlStateSelected];
    [self.eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.eyeButton];
    
    UILabel * balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KStatusHight + KSCALE_WIDTH(60), KSCALE_WIDTH(200), KSCALE_WIDTH(16))];
    balanceLabel.text = @"账户余额（元）";
    balanceLabel.font = K_14_FONT;
    balanceLabel.textColor = [QCClassFunction stringTOColor:@"#FFFFFF"];;
    [backView addSubview:balanceLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KStatusHight + KSCALE_WIDTH(80), KSCALE_WIDTH(200), KSCALE_WIDTH(40))];
    self.moneyLabel.text = @"******";
    self.moneyLabel.font = K_40_BFONT;
    self.moneyLabel.textColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [backView addSubview:self.moneyLabel];
    
    NSArray * titleArr = @[@"充值",@"提现"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30) + KSCALE_WIDTH(120) * i, KSCALE_WIDTH(128) + KTabHight, KSCALE_WIDTH(110), KSCALE_WIDTH(38))];
        button.backgroundColor = KBACK_COLOR;
        button.titleLabel.font = K_18_FONT;
        button.tag = i + 1;
        
        [button setTitleColor:[QCClassFunction stringTOColor:@"#FFCC00"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(19)];
        [backView addSubview:button];
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(200) + KTabHight, KSCALE_WIDTH(315), KSCALE_WIDTH(325))];
    view.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(18)];
    [self.view addSubview:view];
    
    
    NSArray * labelArr = @[@"收支明细",@"红包明细",@"实名认证",@"我的银行卡",@"服务须知"];
    NSArray * imageArr = @[@"收支明细",@"红包明细",@"实名认证",@"我的银行卡",@"服务须知"];

    for (NSInteger i = 0; i < 5; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, i * KSCALE_WIDTH(65), KSCALE_WIDTH(315), KSCALE_WIDTH(65))];
        button.backgroundColor = KCLEAR_COLOR;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 1;

        [view addSubview:button];
        
        UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(27), KSCALE_WIDTH(20) + i * KSCALE_WIDTH(65), KSCALE_WIDTH(24), KSCALE_WIDTH(24))];
        headerImageView.image = [UIImage imageNamed:imageArr[i]];
//        headerImageView.contentMode = UIViewContentModeCenter;
        [view addSubview:headerImageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(20) + i * KSCALE_WIDTH(65), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        label.text = labelArr[i];
        label.font = K_16_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [view addSubview:label];
        
        if (i < 4) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(64) + i * KSCALE_WIDTH(65), KSCALE_WIDTH(237.5), KSCALE_WIDTH(1))];
            lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
            [view addSubview:lineView];
        }
 
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(22) + i * KSCALE_WIDTH(65), KSCALE_WIDTH(20), KSCALE_WIDTH(20))];
        imageView.image = [UIImage imageNamed:@"leftarrow"];
        [view addSubview:imageView];
    }
    
    
}


@end
