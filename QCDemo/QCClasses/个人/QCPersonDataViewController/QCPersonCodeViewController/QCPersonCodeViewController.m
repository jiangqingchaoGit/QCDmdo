//
//  QCPersonCodeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonCodeViewController.h"

@interface QCPersonCodeViewController ()
//  我的二维码
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UILabel * idLabel;
@property (nonatomic, strong) UIImageView * codeImageView;
@property (nonatomic, strong) NSString * codeStr;

@end

@implementation QCPersonCodeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

#pragma mark - tapAction
- (void)backAction:(UIButton *)sender {
    
}

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            //  保存
            break;
        case 2:
            //  分享
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
    
    
    UIView * codeView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(37.5), KNavHight + KSCALE_WIDTH(35), KSCALE_WIDTH(300), KSCALE_WIDTH(470))];
    codeView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:codeView withRadius:KSCALE_WIDTH(6)];
    [self.view addSubview:codeView];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(36), KSCALE_WIDTH(80), KSCALE_WIDTH(80))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(40)];
    [codeView addSubview:self.headerImageView];
    
    self.nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(130), KSCALE_WIDTH(300), KSCALE_WIDTH(30))];
    self.nickLabel.text = @"思绪云骞";
    self.nickLabel.font = K_18_BFONT;
    self.nickLabel.textAlignment = NSTextAlignmentCenter;
    self.nickLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [codeView addSubview:self.nickLabel];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(160), KSCALE_WIDTH(300), KSCALE_WIDTH(30))];
    self.idLabel.text = @"多多号:182836238";
    self.idLabel.font = K_14_FONT;
    self.idLabel.textAlignment = NSTextAlignmentCenter;
    self.idLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [codeView addSubview:self.idLabel];
    
    
    self.codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(88), KSCALE_WIDTH(210), KSCALE_WIDTH(124), KSCALE_WIDTH(124))];
    self.codeImageView.image = KHeaderImage;
    [codeView addSubview:self.codeImageView];
    
    UILabel * codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(340), KSCALE_WIDTH(300), KSCALE_WIDTH(20))];
    codeLabel.text = @"我的多多专属二维码";
    codeLabel.font = K_14_FONT;
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [codeView addSubview:codeLabel];
    
    
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i * KSCALE_WIDTH(150) + KSCALE_WIDTH(40), KSCALE_WIDTH(380), KSCALE_WIDTH(70), KSCALE_WIDTH(70))];
        button.tag = i + 1;
        [button setImage:KHeaderImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [codeView addSubview:button];
    }
    
}



@end
