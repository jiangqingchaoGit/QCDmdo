//
//  QCCertificationPasswordViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//


#import "QCCertificationPasswordViewController.h"

//  设置交易密码
#import "QCSetPasswordViewController.h"
@interface QCCertificationPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) UILabel * codeLabels;
@property (nonatomic, strong) UILabel * codeLabelOne;
@property (nonatomic, strong) UILabel * codeLabelTwo;
@property (nonatomic, strong) UILabel * codeLabelThree;
@property (nonatomic, strong) UILabel * codeLabelFour;
@property (nonatomic, strong) UILabel * codeLabelFive;
@property (nonatomic, strong) UILabel * codeLabelSix;
@property (nonatomic, strong) UILabel * markLabel;

@property (nonatomic, strong) NSString * passWordStr;
@property (nonatomic, strong) UITextField * codeTextField;

@end

@implementation QCCertificationPasswordViewController

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

    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initUI];
}

#pragma mark - tapAction
- (void)resignAction {
    [self.codeTextField resignFirstResponder];
}

- (void)rightAction:(UIButton *)sender {
    QCSetPasswordViewController * setPasswordViewController = [[QCSetPasswordViewController alloc] init];
    setPasswordViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setPasswordViewController animated:YES];
    
}
- (void)initUI {
    
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.rightButton.titleLabel.font = K_16_FONT;
    [self.rightButton setTitle:@"设置交易密码" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(155), KSCALE_WIDTH(35), KSCALE_WIDTH(65), KSCALE_WIDTH(65))];
    imageView.image = KHeaderImage;
    [QCClassFunction filletImageView:imageView withRadius:KSCALE_WIDTH(32.5)];
    [self.view addSubview:imageView];

    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(110), KSCALE_WIDTH(175), KSCALE_WIDTH(44))];
    titleLabel.font = KSCALE_FONT(16);
    titleLabel.textColor = KTEXT_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"绑卡身份认证";
    titleLabel.backgroundColor = KCLEAR_COLOR;
    [self.view addSubview:titleLabel];
    
    for (NSInteger i = 0; i <= 5; i++) {

        self.codeLabels = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(45.5) + i * KSCALE_WIDTH(48), KSCALE_WIDTH(230), KSCALE_WIDTH(44), KSCALE_WIDTH(50))];
        self.codeLabels.font = K_20_BFONT;
        self.codeLabels.textColor = KTEXT_COLOR;
        self.codeLabels.textAlignment = NSTextAlignmentCenter;
        self.codeLabels.backgroundColor = KCLEAR_COLOR;
        self.codeLabels.layer.borderWidth = KSCALE_WIDTH(1);
        self.codeLabels.layer.borderColor = [QCClassFunction stringTOColor:@"#BCBCBC"].CGColor;
        self.codeLabels.tag = i + 1;
        [QCClassFunction filletImageView:self.codeLabels withRadius:KSCALE_WIDTH(12)];
        [self.view addSubview:self.codeLabels];
        
        switch (i) {
            case 0:
                self.codeLabelOne = self.codeLabels;
                break;
            case 1:
                self.codeLabelTwo = self.codeLabels;

                break;
            case 2:
                self.codeLabelThree = self.codeLabels;

                break;
            case 3:
                self.codeLabelFour = self.codeLabels;

                break;
            case 4:
                self.codeLabelFive = self.codeLabels;

                break;
            case 5:
                self.codeLabelSix = self.codeLabels;

                break;
                
            default:
                break;
        }
        
    }
    
    self.codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(45.5), KSCALE_WIDTH(230), KSCALE_WIDTH(284), KSCALE_WIDTH(50))];
    self.codeTextField.backgroundColor = KCLEAR_COLOR;
    self.codeTextField.textColor = KCLEAR_COLOR;
    self.codeTextField.tintColor= KCLEAR_COLOR;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.delegate = self;
    [self.codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTextField];
    
    self.markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(280), KSCALE_WIDTH(375), KSCALE_WIDTH(44))];
    self.markLabel.font = KSCALE_FONT(12);
    self.markLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    self.markLabel.textAlignment = NSTextAlignmentCenter;
    self.markLabel.text = @"请输入交易密码";
    self.markLabel.backgroundColor = KCLEAR_COLOR;
    [self.view addSubview:self.markLabel];
    
    
    
}


- (void)textFieldDidChange:(UITextField *)sender {


    if (sender.text.length == 6) {


        if (1) {
            [self.codeTextField resignFirstResponder];
            self.passWordStr = self.codeTextField.text;
            [QCClassFunction showMessage:@"输入密码正确" toView:self.view];
            //  完成绑定
            
        }else{
            [QCClassFunction showMessage:@"输入密码错误，请重新输入" toView:self.view];
            self.codeTextField.text = @"";
            self.codeLabelOne.text = @"";
            self.codeLabelTwo.text = @"";
            self.codeLabelThree.text = @"";
            self.codeLabelFour.text = @"";
            self.codeLabelFive.text = @"";
            self.codeLabelSix.text = @"";
        }

    }

}

#pragma mark - UITextFieldDelegate
- ( BOOL )textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string {
    
    switch (range.location) {
        case 0:
            if ([string isEqual:@""]) {
                self.codeLabelOne.text = string;

            }else{
                self.codeLabelOne.text = @"*";

            }

            break;
        case 1:
            if ([string isEqual:@""]) {
                self.codeLabelTwo.text = string;

            }else{
                self.codeLabelTwo.text = @"*";

            }
            break;
        case 2:
            if ([string isEqual:@""]) {
                self.codeLabelThree.text = string;

            }else{
                self.codeLabelThree.text = @"*";

            }
            break;
        case 3:
            if ([string isEqual:@""]) {
                self.codeLabelFour.text = string;

            }else{
                self.codeLabelFour.text = @"*";

            }
            break;
            
        case 4:
            if ([string isEqual:@""]) {
                self.codeLabelFive.text = string;

            }else{
                self.codeLabelFive.text = @"*";

            }
            break;
        case 5:
            if ([string isEqual:@""]) {
                self.codeLabelSix.text = string;

            }else{
                self.codeLabelSix.text = @"*";

            }
            break;
            
        default:
            break;
    }
    

    
    if (range.location > 5) {
        return NO;
    }

    return YES;
}


@end
