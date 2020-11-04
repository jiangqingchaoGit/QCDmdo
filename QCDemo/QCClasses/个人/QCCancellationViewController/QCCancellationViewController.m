//
//  QCCancellationViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCCancellationViewController.h"
//  注销账号
@interface QCCancellationViewController ()
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * sureButton;


@end

@implementation QCCancellationViewController


-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = KBACK_COLOR;
    [self initUI];
}


#pragma mark - tapAction
- (void)backAction:(UIButton *)sender {
    //  关闭
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureAction:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [QCClassFunction getSelectTabViewControllerWithSelected:0];

    
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
    loginLabel.text = @"注销账号";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"警告！！！请仔细阅读";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    
    UILabel * markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(190) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    markLabel.text = @"注销后，您的账户将：";
    markLabel.font = K_18_BFONT;
    markLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    markLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:markLabel];
    
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(220) + KStatusHight, KSCALE_WIDTH(325), KSCALE_WIDTH(150))];
    contentLabel.text = @"1. 无法登陆，包括授权登陆其它第三方应用；\n2. 所有信息将被永久删除；\n3. 实名信息会解绑；\n4. dodo钱包余额将无法提现；\n5. 提交注销申请的账户，24h不得再次注册；\n6. 提交申请24小时后，才能得到注销结果；";
    contentLabel.font = K_16_FONT;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_HEIGHT(667) - KNavHight - KSCALE_WIDTH(65), KSCALE_WIDTH(335), KSCALE_WIDTH(50))];
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    self.sureButton.titleLabel.font = K_18_FONT;
    [self.sureButton setTitle:@"申请注销" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.sureButton];

}


@end
