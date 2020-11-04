//
//  QCPersonBindingViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonBindingViewController.h"
#import "QChangeBindingViewController.h"
@interface QCPersonBindingViewController ()
//  更换手机号
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UIButton * sureButton;
@end

@implementation QCPersonBindingViewController


-(void)viewWillAppear:(BOOL)animated {
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
    
    
    [self initUI];

}

#pragma mark - tapAction
- (void)sureAction:(UIButton *)sender {
    QChangeBindingViewController * changeBindingViewController = [[QChangeBindingViewController alloc] init];
    changeBindingViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeBindingViewController animated:YES];
    
}

#pragma mark - initUI

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"更换手机号";
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(150), KSCALE_WIDTH(44), KSCALE_WIDTH(75), KSCALE_WIDTH(75))];
    imageView.image = KHeaderImage;
    [self.view addSubview:imageView];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(140), KSCALE_WIDTH(345), KSCALE_WIDTH(30))];
    contentLabel.text = @"已绑定手机";
    contentLabel.font = K_16_FONT;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.view addSubview:contentLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(170), KSCALE_WIDTH(345), KSCALE_WIDTH(32))];
    self.phoneLabel.text = @"18672910380";
    self.phoneLabel.font = K_30_BFONT;
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:self.phoneLabel];
    
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(275) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    self.sureButton.titleLabel.font = K_18_FONT;
    [self.sureButton setTitle:@"更换手机号" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.sureButton];
}

    

    


@end
