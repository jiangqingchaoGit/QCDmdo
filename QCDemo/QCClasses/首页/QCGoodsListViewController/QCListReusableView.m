//
//  QCListReusableView.m
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCListReusableView.h"
#import "QCGoodsListViewController.h"
@implementation QCListReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(4)];
    [self addSubview:view];
    
    self.isSale = NO;
    self.isPrice = NO;

    NSArray * titleArr = @[@"最新",@"销量",@"价格"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(111), KSCALE_WIDTH(3), KSCALE_WIDTH(103), KSCALE_WIDTH(29))];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(14.5)];

        
        if (i > 0) {
            [button setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.image.size.width, 0, button.imageView.image.size.width)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width , 0, -button.titleLabel.bounds.size.width)];
        }

        
        
        [view addSubview:button];
        
        switch (i) {
            case 0:
                self.incomeButton = button;
                self.incomeButton.selected = YES;
                self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
                break;
            case 1:
                self.spendingButton = button;
                break;
            case 2:
                self.withdrawalButton = button;
                break;
                
            default:
                break;
        }

    }
    
//    self.saleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(202), KSCALE_WIDTH(10.5), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
//    self.saleImageView.image = [UIImage imageNamed:@"arrow_up"];
//    [self addSubview:self.saleImageView];
    

}


- (void)buttonAction:(UIButton *)sender {
    QCGoodsListViewController * goodsListViewController = (QCGoodsListViewController *)[QCClassFunction parentController:self];
    goodsListViewController.i = 1;
    switch (sender.tag) {
        case 1:

            self.incomeButton.selected = YES;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            goodsListViewController.typeStr = @"1";
            [self.spendingButton setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];
            [self.withdrawalButton setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];

            [goodsListViewController GETDATA];

            break;
        case 2:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            
            if (self.isSale) {
                self.isSale = NO;
                goodsListViewController.typeStr = @"2";
                
                [self.spendingButton setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
                [self.withdrawalButton setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];

            }else{
                self.isSale = YES;
                goodsListViewController.typeStr = @"3";
                
                [self.spendingButton setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
                [self.withdrawalButton setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];


            }
            [goodsListViewController GETDATA];


            break;
        case 3:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = YES;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            if (self.isPrice) {
                self.isPrice = NO;
                goodsListViewController.typeStr = @"4";
                
                [self.spendingButton setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];
                [self.withdrawalButton setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];

            }else{
                self.isPrice = YES;
                goodsListViewController.typeStr = @"5";
                
                [self.spendingButton setImage:[UIImage imageNamed:@"arrow_normal"] forState:UIControlStateNormal];
                [self.withdrawalButton setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];

            }
            [goodsListViewController GETDATA];


            break;
            
        default:
            break;
    }
}

@end

