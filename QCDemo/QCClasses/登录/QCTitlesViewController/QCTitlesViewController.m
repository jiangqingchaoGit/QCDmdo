//
//  QCTitlesViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/15.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCTitlesViewController.h"

@interface QCTitlesViewController ()

@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nickNameLabel;
@property (nonatomic, strong) UILabel * cardLabel;
@property (nonatomic, strong) UILabel * limitLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIButton * withdrawalButton;




@end

@implementation QCTitlesViewController

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
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(125), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    loginLabel.text = @"账号禁用警告";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(160), KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"您的账户存在较高安全风险，dodo已采取封号措施！";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(230), KSCALE_WIDTH(60), KSCALE_WIDTH(60))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(30)];
    [self.view addSubview:self.headerImageView];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(235), KSCALE_WIDTH(200), KSCALE_WIDTH(25))];
    self.nickNameLabel.text = @"PAJERO";
    self.nickNameLabel.font = K_22_BFONT;
    self.nickNameLabel.textColor = [QCClassFunction stringTOColor:@"#FFCC00"];;
    [self.view addSubview:self.nickNameLabel];
    
    self.cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(260), KSCALE_WIDTH(200), KSCALE_WIDTH(25))];
    self.cardLabel.text = @"DODO号： uid_234lj23";
    self.cardLabel.font = K_14_FONT;
    self.cardLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:self.cardLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(315), KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:lineView];
    
    UILabel * limitLabels = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(330), KSCALE_WIDTH(80), KSCALE_WIDTH(22))];
    limitLabels.text = @"封禁期限：";
    limitLabels.font = K_14_FONT;
    limitLabels.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];;
    [self.view addSubview:limitLabels];
    
    self.limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(330), KSCALE_WIDTH(230), KSCALE_WIDTH(22))];
    self.limitLabel.text = @"永久";
    self.limitLabel.font = K_14_FONT;
    self.limitLabel.textColor = KTEXT_COLOR;
    [self.view addSubview:self.limitLabel];
    
    UILabel * contentLabels = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(367), KSCALE_WIDTH(80), KSCALE_WIDTH(22))];
    contentLabels.text = @"封禁原因：";
    contentLabels.font = K_14_FONT;
    contentLabels.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];;
    [self.view addSubview:contentLabels];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(367), KSCALE_WIDTH(230), KSCALE_WIDTH(22))];
    self.contentLabel.text = @"涉嫌上传敏感图片！";
    self.contentLabel.font = K_14_FONT;
    self.contentLabel.textColor = KTEXT_COLOR;
    [self.view addSubview:self.contentLabel];
    
    UIView * lineViews = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(405), KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineViews.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:lineViews];
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(440), KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    self.loginButton.titleLabel.font = K_18_FONT;
    [self.loginButton setTitle:@"电话申述" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    self.withdrawalButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_HEIGHT(600), KSCALE_WIDTH(309), KSCALE_WIDTH(30))];
    self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
    self.withdrawalButton.titleLabel.font = K_16_FONT;
    [self.withdrawalButton setTitle:@"¥提取账号内财产" forState:UIControlStateNormal];
    [self.withdrawalButton setTitleColor:[QCClassFunction stringTOColor:@"#FF9852"] forState:UIControlStateNormal];
    [self.withdrawalButton addTarget:self action:@selector(withdrawalAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.withdrawalButton];
    
    

    

    
}


#pragma mark - tapAction

- (void)backAction:(UIButton *)sender {
    
}
- (void)loginAction:(UIButton *)sender {
    
}
- (void)withdrawalAction:(UIButton *)sender {
    
}


@end
