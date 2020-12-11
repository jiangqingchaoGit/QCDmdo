//
//  QCChangeNicknameViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChangeNicknameViewController.h"

@interface QCChangeNicknameViewController ()
@property (nonatomic, strong) UIButton * sureButton;
@property (nonatomic, strong) UITextField * nameTextField;

@end

@implementation QCChangeNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

#pragma mark - tapAction
- (void)cancleAction:(UIButton *)sender {
    [self.nameTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)sureAction:(UIButton *)sender {
    [self.nameTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

    
}
#pragma mark - initUI

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    
    UIButton * cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KStatusHight, KSCALE_WIDTH(60), 40)];
    cancleButton.titleLabel.font = K_16_FONT;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleButton];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KStatusHight, KSCALE_WIDTH(375), 40)];
    titleLabel.font = KSCALE_FONT(18);
    titleLabel.textColor = KBLACK_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"设置名称";
    [self.view addSubview:titleLabel];
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(310), KStatusHight + 4, KSCALE_WIDTH(55), 32)];
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.selected = NO;
    self.sureButton.userInteractionEnabled = NO;
    [self.sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(4)];
    [self.view addSubview:self.sureButton];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KNavHight, KSCALE_WIDTH(375), KSCALE_WIDTH(50))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:view];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), KNavHight, KSCALE_WIDTH(355), KSCALE_WIDTH(50))];
    self.nameTextField.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:self.nameTextField];
    
    [self.nameTextField becomeFirstResponder];
}
@end
