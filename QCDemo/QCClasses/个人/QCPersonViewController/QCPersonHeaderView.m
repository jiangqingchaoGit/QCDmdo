//
//  QCPersonHeaderView.m
//  QCDemo
//
//  Created by JQC on 2020/10/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonHeaderView.h"

@interface QCPersonHeaderView()
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nickNameLabel;
@property (nonatomic, strong) UILabel * cardLabel;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * releaseLabel;
@property (nonatomic, strong) UILabel * orderLabel;
@property (nonatomic, strong) UIView * orderView;
@property (nonatomic, strong) UILabel * getLabel;


 @end

@implementation QCPersonHeaderView

#pragma mark - tapAction
- (void)setAction:(UIButton *)sender {
    //  设置
}

- (void)scanAction:(UIButton *)sender {
    

}



- (void)topAction:(UIButton *)sender {
    //  充值
}

- (void)withdrawalAction:(UIButton *)sender {
    //  提现
}
- (void)functionAction:(UIButton *)sender {
    
    NSLog(@"%ld",sender.tag);
    switch (sender.tag) {
        case 1:
            //  我的发布
            break;
        case 2:
            //  我的订单
            break;
        case 3:
            //  我买到的
            break;
        case 4:
            //  收藏
            break;
            
        default:
            break;
    }
}
#pragma mark - initUI
- (void)initUI {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(105) + KStatusHight)];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    [self addSubview:view];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20) + KStatusHight, KSCALE_WIDTH(70), KSCALE_WIDTH(70))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(35)];
    [self addSubview:self.headerImageView];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KStatusHight + KSCALE_WIDTH(50), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    self.nickNameLabel.text = @"黑与白";
    self.nickNameLabel.font = K_18_BFONT;
    self.nickNameLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];;
    [self addSubview:self.nickNameLabel];
    
    self.cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KStatusHight + KSCALE_WIDTH(70), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    self.cardLabel.text = @"DODO号：uid_234lj23";
    self.cardLabel.font = K_12_FONT;
    self.cardLabel.textColor = [QCClassFunction stringTOColor:@"#434343"];
    [self addSubview:self.cardLabel];
    
    UIButton * scanButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(315), KSCALE_WIDTH(15) + KStatusHight, KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    [scanButton setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    [scanButton addTarget: self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scanButton];
    
    UIButton * setButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(250), KStatusHight + KSCALE_WIDTH(65), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    [setButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    [setButton addTarget: self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setButton];
    
    UILabel * balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KStatusHight + KSCALE_WIDTH(140), KSCALE_WIDTH(200), KSCALE_WIDTH(16))];
    balanceLabel.text = @"账户余额（元）";
    balanceLabel.font = K_12_FONT;
    balanceLabel.textColor = [QCClassFunction stringTOColor:@"#868686"];;
    [self addSubview:balanceLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KStatusHight + KSCALE_WIDTH(160), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.moneyLabel.text = @"955.05";
    self.moneyLabel.font = K_30_BFONT;
    self.moneyLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self addSubview:self.moneyLabel];
    
    UIButton * topButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(150) + KStatusHight, KSCALE_WIDTH(72), KSCALE_WIDTH(35))];
    topButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    topButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView:topButton withRadius:KSCALE_WIDTH(17.5)];
    [topButton addTarget:self action:@selector(topAction:) forControlEvents:UIControlEventTouchUpInside];
    [topButton setTitle:@"充值" forState:UIControlStateNormal];
    [topButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self addSubview:topButton];
    
    UIButton * withdrawalButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(283), KSCALE_WIDTH(150) + KStatusHight, KSCALE_WIDTH(72), KSCALE_WIDTH(35))];
    withdrawalButton.backgroundColor = [QCClassFunction stringTOColor:@"#66CC66"];
    withdrawalButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView: withdrawalButton withRadius:KSCALE_WIDTH(17.5)];
    [withdrawalButton addTarget:self action:@selector(withdrawalAction:) forControlEvents:UIControlEventTouchUpInside];
    [withdrawalButton setTitle:@"提现" forState:UIControlStateNormal];
    [withdrawalButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self addSubview:withdrawalButton];
    
    UIView * functionView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(200) + KStatusHight, KSCALE_WIDTH(335), KSCALE_WIDTH(85))];
    functionView.backgroundColor = KBACK_COLOR;
    functionView.layer.borderWidth = KSCALE_WIDTH(1);
    functionView.layer.borderColor = [QCClassFunction stringTOColor:@"#E4E4E4"].CGColor;
    [QCClassFunction filletImageView:functionView withRadius:KSCALE_WIDTH(9)];
    [self addSubview:functionView];
    
    self.releaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), KSCALE_WIDTH(5), KSCALE_WIDTH(80), KSCALE_WIDTH(45))];
    self.releaseLabel.text = @"0";
    self.releaseLabel.font = K_20_BFONT;
    self.releaseLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.releaseLabel.textAlignment = NSTextAlignmentCenter;

    [functionView addSubview:self.releaseLabel];
    
    self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(5), KSCALE_WIDTH(80), KSCALE_WIDTH(45))];
    self.orderLabel.text = @"0";
    self.orderLabel.font = K_20_BFONT;
    self.orderLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.orderLabel.textAlignment = NSTextAlignmentCenter;
    [functionView addSubview:self.orderLabel];
    
    self.orderView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(140), KSCALE_WIDTH(15), KSCALE_WIDTH(8), KSCALE_WIDTH(8))];
    self.orderView.backgroundColor = [QCClassFunction stringTOColor:@"#FF3300"];
    [QCClassFunction filletImageView:self.orderView withRadius:KSCALE_WIDTH(4)];
    [functionView addSubview:self.orderView];
    
    self.getLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(170), KSCALE_WIDTH(5), KSCALE_WIDTH(80), KSCALE_WIDTH(45))];
    self.getLabel.text = @"0";
    self.getLabel.font = K_20_BFONT;
    self.getLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.getLabel.textAlignment = NSTextAlignmentCenter;
    [functionView addSubview:self.getLabel];
    
    NSArray * titleArr = @[@"我的发布",@"我的订单",@"我买到的"];
    for (NSInteger i = 0 ; i < 3; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10) + KSCALE_WIDTH(80) * i, KSCALE_WIDTH(50), KSCALE_WIDTH(80), KSCALE_WIDTH(20))];
        label.text = titleArr[i];
        label.font = K_12_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#434343"];
        label.textAlignment = NSTextAlignmentCenter;
        [functionView addSubview:label];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10) + KSCALE_WIDTH(80) * i, KSCALE_WIDTH(0), KSCALE_WIDTH(80), KSCALE_WIDTH(85))];
        button.backgroundColor = KCLEAR_COLOR;
        button.tag = i + 1;
        [button addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
        [functionView addSubview:button];
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(250), KSCALE_WIDTH(20), KSCALE_WIDTH(1), KSCALE_WIDTH(45))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    [functionView addSubview:lineView];
    
    
    UIImageView * collectionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(274.5), KSCALE_WIDTH(8), KSCALE_WIDTH(36), KSCALE_WIDTH(36))];
    collectionImageView.image = [UIImage imageNamed:@"收藏"];
    [functionView addSubview:collectionImageView];
    
    UILabel * collectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(250), KSCALE_WIDTH(50), KSCALE_WIDTH(85), KSCALE_WIDTH(20))];
    collectionLabel.text = @"收藏";
    collectionLabel.font = K_12_FONT;
    collectionLabel.textColor = [QCClassFunction stringTOColor:@"#434343"];
    collectionLabel.textAlignment = NSTextAlignmentCenter;
    [functionView addSubview:collectionLabel];
    
    UIButton * collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(250),0, KSCALE_WIDTH(85), KSCALE_WIDTH(85))];
    collectionButton.backgroundColor = KCLEAR_COLOR;
    collectionButton.tag = 4;
    [collectionButton addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    [functionView addSubview:collectionButton];
    
    
}




@end
