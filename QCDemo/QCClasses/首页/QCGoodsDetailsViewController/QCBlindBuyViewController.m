//
//  QCBlindBuyViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCBlindBuyViewController.h"

@interface QCBlindBuyViewController ()
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * getPriceLabel;
@property (nonatomic, strong) UILabel * contentLabel;


@property (nonatomic, strong) UIButton * reButton;
@property (nonatomic, strong) UIButton * buyButton;
@end

@implementation QCBlindBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"盲价";

    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
    self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
    self.contentLabel.font = K_14_FONT;
    self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.contentLabel.numberOfLines = 0;
    [self.view addSubview:self.contentLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(85), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.priceLabel.text = @"¥3300-¥3600";
    self.priceLabel.font = K_20_BFONT;
    self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
    [self.view addSubview:self.priceLabel];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(120), KSCALE_WIDTH(335), KSCALE_WIDTH(20))];
    label.text = @"盲购原区间价";
    label.font = K_12_FONT;
    label.textColor = [QCClassFunction stringTOColor:@"#666666"];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(180), KSCALE_WIDTH(335), KSCALE_WIDTH(280))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#f2f2f2"];
    [self.view addSubview:view];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(20), KSCALE_WIDTH(155), KSCALE_WIDTH(155))];
    imageView.image = [UIImage imageNamed:@"header"];
    [view addSubview:imageView];
    
    self.getPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(185), KSCALE_WIDTH(335), KSCALE_WIDTH(40))];
    self.getPriceLabel.text = @"¥3300";
    self.getPriceLabel.font = K_36_BFONT;
    self.getPriceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
    self.getPriceLabel.textAlignment = NSTextAlignmentCenter;

    [view addSubview:self.getPriceLabel];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(230), KSCALE_WIDTH(335), KSCALE_WIDTH(20))];
    messageLabel.text = @"运气爆棚，您翻到了超低盲价！";
    messageLabel.font = K_14_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:messageLabel];
    
    self.reButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(40), KSCREEN_HEIGHT - KTabHight - KSCALE_WIDTH(42) - KNavHight, KSCALE_WIDTH(135), KSCALE_WIDTH(42))];
    self.reButton.backgroundColor = [QCClassFunction stringTOColor:@"#66CC66"];
    self.reButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView:self.reButton withRadius:KSCALE_WIDTH(5)];
    [self.reButton addTarget:self action:@selector(reAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.reButton setTitle:@"￥1重翻" forState:UIControlStateNormal];
    [self.reButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.view addSubview:self.reButton];
    
    self.buyButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCREEN_HEIGHT - KTabHight - KSCALE_WIDTH(42) - KNavHight, KSCALE_WIDTH(135), KSCALE_WIDTH(42))];
    self.buyButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.buyButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView: self.buyButton withRadius:KSCALE_WIDTH(5)];
    [self.buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyButton setTitle:@"付款" forState:UIControlStateNormal];
    [self.buyButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.view addSubview:self.buyButton];
    
}

- (void)reAction:(UIButton *)sender {
    
}

- (void)buyAction:(UIButton *)sender {
    
}
@end
