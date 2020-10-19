//
//  QCCodeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/15.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCCodeViewController.h"

@interface QCCodeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UILabel * codeLabel;
@property (nonatomic, strong) UILabel * codeLabels;
@property (nonatomic, strong) UILabel * codeLabelOne;
@property (nonatomic, strong) UILabel * codeLabelTwo;
@property (nonatomic, strong) UILabel * codeLabelThree;
@property (nonatomic, strong) UILabel * codeLabelFour;

@property (nonatomic, strong) UITextField * codeTextField;
@property (nonatomic, strong) UIButton * codeButton;


@end

@implementation QCCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initUI];
    
}

- (void)initUI {
    
    
    self.view.backgroundColor = KBACK_COLOR;
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), 0, KSCALE_WIDTH(265), KSCALE_WIDTH(150))];
    self.backImageView.image = [UIImage imageNamed:@"底图"];
    [self.view addSubview:self.backImageView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), KSCALE_WIDTH(10),KSCALE_WIDTH(10), KSCALE_WIDTH(10))];
    [self.backButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(125), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    loginLabel.text = @"验证码已发送";
    loginLabel.font = K_24_BFONT;
    loginLabel.textColor = KTEXT_COLOR;
    loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(160), KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    self.phoneLabel.text = [NSString stringWithFormat:@"+86 %@",self.phoneStr];
    self.phoneLabel.font = K_14_FONT;
    self.phoneLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.phoneLabel];
    
    self.codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(50), KSCALE_WIDTH(223), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    self.codeLabel.font = K_14_FONT;
    self.codeLabel.textColor = [QCClassFunction stringTOColor:@"#FF9852"];
    self.codeLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.codeLabel];
    
    [self codeAction:nil];
    
    for (NSInteger i = 0; i <= 3; i++) {

        self.codeLabels = [[UILabel alloc] initWithFrame:CGRectMake(i * KSCALE_WIDTH(73) + KSCALE_WIDTH(50), KSCALE_WIDTH(256), KSCALE_WIDTH(55), KSCALE_WIDTH(62))];
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
                
            default:
                break;
        }
        
    }
    
    self.codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(73), KSCALE_WIDTH(256), KSCALE_WIDTH(232), KSCALE_WIDTH(62))];
    self.codeTextField.backgroundColor = KCLEAR_COLOR;
    self.codeTextField.textColor = KCLEAR_COLOR;
    self.codeTextField.tintColor= KCLEAR_COLOR;
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.delegate = self;
    [self.codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTextField];
    
    
    self.codeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(340), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.codeButton.backgroundColor = KCLEAR_COLOR;
    self.codeButton.titleLabel.font = K_14_FONT;
    self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeButton];
    
    
}

#pragma mark - GETDATA
- (void)GETCODE {
    
}

- (void)GETLogin {
    //  codeTextField.text
    //  self.phoneStr

}
#pragma mark - tapAction

- (void)resignAction {
    [self.codeTextField resignFirstResponder];
}
- (void)backAction:(UIButton *)sender {
    //  返回按钮
    [self.codeTextField resignFirstResponder];

    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)codeAction:(UIButton *)sender {
    
    // 获取验证码
    [self.codeTextField resignFirstResponder];
    [self GETCODE];
    __block NSInteger time = 59; //倒计时时间
    //  执行异步任务
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //  iOS计时器
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行

    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.codeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = YES;
                self.codeLabel.text = [NSString stringWithFormat:@"请填写四位数验证码 %.2ds",0];
                self.codeLabel.attributedText = [QCClassFunction getColorWithString:self.codeLabel.text andTargetString:@"请填写四位数验证码" withColor:[QCClassFunction stringTOColor:@"#BCBCBC"]];
            });
            
        }else{ int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                self.codeLabel.text = [NSString stringWithFormat:@"请填写四位数验证码 %.2ds",seconds];

                self.codeLabel.attributedText = [QCClassFunction getColorWithString:self.codeLabel.text andTargetString:@"请填写四位数验证码" withColor:[QCClassFunction stringTOColor:@"#BCBCBC"]];
                self.codeButton.userInteractionEnabled = NO;
                
            });
            time--;
            
        } });
    dispatch_resume(_timer);
    
    
}


- (void)textFieldDidChange:(UITextField *)sender {

    if (sender.text.length == 4) {
        //  登录接口
        [self.codeTextField resignFirstResponder];
        [self GETLogin];
    }

}



#pragma mark - UITextFieldDelegate
- ( BOOL )textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string {
    
    switch (range.location) {
        case 0:
                self.codeLabelOne.text = string;

            break;
        case 1:
                self.codeLabelTwo.text = string;

            break;
        case 2:
                self.codeLabelThree.text = string;

            break;
        case 3:
                self.codeLabelFour.text = string;
            
            if (self.codeLabelFour.text != nil) {

            }
            
            break;
            
        default:
            break;
    }
    

    
    if (range.location > 3) {
        return NO;
    }

    return YES;
}
@end
