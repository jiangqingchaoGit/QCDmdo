//
//  QCDisableViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/15.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCDisableViewController.h"

@interface QCDisableViewController ()
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * loginButton;

@end

@implementation QCDisableViewController

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
    loginLabel.text = @"风险控制";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(160), KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"您的账户存在较高安全风险，dodo已采取冻结措施！";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(420), KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.loginButton.titleLabel.font = K_18_FONT;
    [self.loginButton setTitle:@"电话申述" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    
    
    UIImageView * disableImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(150), KSCALE_WIDTH(250), KSCALE_WIDTH(75), KSCALE_WIDTH(75))];
    disableImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:disableImageView withRadius:KSCALE_WIDTH(37.5)];
    [self.view addSubview:disableImageView];
    
    UILabel * disableLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(330), KSCALE_WIDTH(375), KSCALE_WIDTH(28))];
    disableLabel.text = @"冻结中";
    disableLabel.font = K_16_FONT;
    disableLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];;
    disableLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:disableLabel];
    

    
}


#pragma mark - tapAction

- (void)backAction:(UIButton *)sender {
    
}
- (void)loginAction:(UIButton *)sender {
    
}






@end
