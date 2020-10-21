//
//  QCAddFriendsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddFriendsViewController.h"

@interface QCAddFriendsViewController ()

@end

@implementation QCAddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {
    self.title = @"添加好友";
    self.view.backgroundColor = KBACK_COLOR;
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(6), KSCALE_WIDTH(345) , KSCALE_WIDTH(38))];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.view addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(18), KSCALE_WIDTH(14) , KSCALE_WIDTH(14))];
    searchImageView.image = KHeaderImage;
    [self.view addSubview:searchImageView];
    
    UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(6), KSCALE_WIDTH(50) , KSCALE_WIDTH(38))];
    searchLabel.text = @"多多好/手机号";
    searchLabel.font = K_14_BFONT;
    searchLabel.textColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
    searchLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:searchLabel];
    
    
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 50)];
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    NSArray * titleArr = @[@"微信邀请好友",@"扫一扫"];
    for (NSInteger i = 0; i < 2; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(62) + i * KSCALE_WIDTH(72), KSCALE_WIDTH(375), KSCALE_WIDTH(62))];
        button.tag = i + 1;
        button.backgroundColor = KCLEAR_COLOR;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(62) + i * KSCALE_WIDTH(72), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        imageView.image =KHeaderImage;
        [QCClassFunction filletImageView:imageView withRadius:KSCALE_WIDTH(26)];
        [self.view addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(62) + KSCALE_WIDTH(72) * i, KSCALE_WIDTH(200), KSCALE_WIDTH(62))];
        label.text = titleArr[i];
        label.font = K_16_FONT;
        label.textColor = KTEXT_COLOR;
        [self.view addSubview:label];
    }
}


#pragma mark - tapAction
- (void)searchAction:(UIButton *)sender {
    
}
- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            //  微信邀请好友
            break;
        case 1:
            //  s扫一扫
            break;
            
        default:
            break;
    }
}

@end
