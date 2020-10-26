//
//  QCSearchViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSearchViewController.h"

@interface QCSearchViewController ()
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * sexImageView;

@property (nonatomic, strong) UIButton * addButton;

@end

@implementation QCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}


#pragma mark - tapAction
- (void)addAction:(UIButton *)sender {
    //  添加好友
}
#pragma mark - initUI
- (void)initUI {
    
    self.title = @"详细资料";
    self.view.backgroundColor = KBACK_COLOR;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.view addSubview:self.headerImageView];


    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(27))];
    self.nameLabel.text = @"思绪云骞";
    self.nameLabel.font = K_16_FONT;
    self.nameLabel.textColor = KTEXT_COLOR;
    [self.view addSubview:self.nameLabel];
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(80), KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.addButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    self.addButton.titleLabel.font = K_18_FONT;
    [self.addButton setTitle:@"添加好友" forState:UIControlStateNormal];
    [self.addButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.addButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.addButton];

    
}


@end
