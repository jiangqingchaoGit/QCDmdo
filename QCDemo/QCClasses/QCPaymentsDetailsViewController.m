//
//  QCPaymentsDetailsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPaymentsDetailsViewController.h"

@interface QCPaymentsDetailsViewController ()

@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * paymentsLabel;
@property (nonatomic, strong) UILabel * typeLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * orderLabel;
@property (nonatomic, strong) UILabel * restLabel;
@property (nonatomic, strong) UILabel * markLabel;


@end

@implementation QCPaymentsDetailsViewController

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
    [self initUI];
}

#pragma mark - tapAction
- (void)copyAction:(UIButton *)sender {
    
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"收支明细";
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20), KSCALE_WIDTH(200), KSCALE_WIDTH(24))];
    self.contentLabel.text = @"【提现】到  ***3621";
    self.contentLabel.font = K_16_BFONT;
    self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:self.contentLabel];
    
    self.paymentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(50), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
    self.paymentsLabel.text = @"+560";
    self.paymentsLabel.font = K_22_BFONT;
    self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:self.paymentsLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(89), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    [self.view addSubview:lineView];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(105), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
    self.typeLabel.text = @"类型：提现";
    self.typeLabel.font = K_12_FONT;
    self.typeLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.view addSubview:self.typeLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(145), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    self.timeLabel.text = @"时间：2020-10-10 15:04";
    self.timeLabel.font = K_12_FONT;
    self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.view addSubview:self.timeLabel];
    
    self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(185), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    self.orderLabel.text = @"交易单号：SP2009202222322100";
    self.orderLabel.font = K_12_FONT;
    self.orderLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.view addSubview:self.orderLabel];
    
    UIButton * copyButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(240), KSCALE_WIDTH(183), KSCALE_WIDTH(55), KSCALE_WIDTH(24))];
    copyButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    copyButton.layer.borderWidth = KSCALE_WIDTH(1);
    copyButton.layer.borderColor = [QCClassFunction stringTOColor:@"#D7D7D7"].CGColor;
    copyButton.titleLabel.font = K_12_FONT;
    [copyButton setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:copyButton withRadius:KSCALE_WIDTH(12)];
    [self.view addSubview:copyButton];
    
    self.restLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(225), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
    self.restLabel.text = @"余额： ￥994.00";
    self.restLabel.font = K_12_FONT;
    self.restLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.view addSubview:self.restLabel];
    
    self.markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(265), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
    self.markLabel.text = @"备注：无";
    self.markLabel.font = K_12_FONT;
    self.markLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.view addSubview:self.markLabel];
    

    
}



@end
