//
//  QCAddBankViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddBankViewController.h"

@interface QCAddBankViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UITextField * cardTextField;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UITextField * codeTextField;
@property (nonatomic, strong) UIButton * codeButton;
@property (nonatomic, strong) UIButton * sureButton;

@end

@implementation QCAddBankViewController

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
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    [self initUI];

}

#pragma mark - GETDATA
- (void)GETCODE {
    
    if ([QCClassFunction isMobile:self.phoneTextField.text]) {
        [QCClassFunction showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    NSString * str = [NSString stringWithFormat:@"mobile=%@&type=%@",self.phoneTextField.text,@"3"];

    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"mobile":self.phoneTextField.text,@"type":@"3"};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    
    [QCAFNetWorking QCPOST:@"/api/send" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        
        if ([responseObject[@"status"] intValue] == 1) {
            
            
        
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
    
}

#pragma mark - tapAction
- (void)resignAction {
    [self.nameTextField resignFirstResponder];
    [self.cardTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];

}

- (void)sureAction:(UIButton *)sender {
    
    if ([self.nameTextField.text isEqual:@""] || self.nameTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入持卡人姓名" toView:self.view];
        return;
    }
    
    
    if ([self.cardTextField.text isEqual:@""] || self.nameTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入持卡人卡号" toView:self.view];
        return;
    }
    
    if ([QCClassFunction isMobile:self.phoneTextField.text]) {
        [QCClassFunction showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    
    
    if ([self.codeTextField.text isEqual:@""] || self.nameTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入验证码" toView:self.view];
        return;
        
    }
    
    //  进行绑定操作
    
    
}

- (void)codeAction:(UIButton *)sender {
    [self.nameTextField resignFirstResponder];
    [self.cardTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
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
                self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;


            });
            
        }else{ int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果

                
                [self.codeButton setTitle:[NSString stringWithFormat:@" %.2ds",seconds] forState:UIControlStateNormal];
                self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;


                
            });
            time--;
            
        } });
    dispatch_resume(_timer);
    
    
}
#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(155), KSCALE_WIDTH(35), KSCALE_WIDTH(65), KSCALE_WIDTH(65))];
    imageView.image = KHeaderImage;
    [QCClassFunction filletImageView:imageView withRadius:KSCALE_WIDTH(32.5)];
    [self.view addSubview:imageView];

    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(110), KSCALE_WIDTH(175), KSCALE_WIDTH(44))];
    titleLabel.font = KSCALE_FONT(16);
    titleLabel.textColor = KTEXT_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"添加银行卡";
    titleLabel.backgroundColor = KCLEAR_COLOR;
    [self.view addSubview:titleLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(174), KSCALE_WIDTH(315), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    
    NSArray * labelArr = @[@"持卡人",@"卡号",@"手机号",@"验证码"];
    NSArray * markArr = @[@"请输入持卡人姓名",@"请输入持卡人卡号",@"请输入手机号码",@"请输入验证码"];

    for (NSInteger i = 0; i < 4; i++) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(175) + KSCALE_WIDTH(59) * i, KSCALE_WIDTH(80), KSCALE_WIDTH(58))];
        label.font = KSCALE_FONT(16);
        label.textColor = KTEXT_COLOR;
        label.text = labelArr[i];
        [self.view addSubview:label];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(59) * i + KSCALE_WIDTH(233), KSCALE_WIDTH(315), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.view addSubview:lineView];
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(175) + KSCALE_WIDTH(59) * i , KSCALE_WIDTH(200), KSCALE_WIDTH(58))];
        textField.backgroundColor  = KCLEAR_COLOR;
        textField.placeholder = markArr[i];
        textField.font = K_16_FONT;
        textField.delegate = self;
        [self.view addSubview:textField];
        
        switch (i) {
            case 0:
                self.nameTextField = textField;
                break;
            case 1:
                self.cardTextField = textField;
                self.cardTextField.keyboardType = UIKeyboardTypeNumberPad;

                break;
            case 2:
                self.phoneTextField = textField;
                self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;

                break;
            case 3:
                self.codeTextField = textField;
                self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;

                break;
                
            default:
                break;
        }

    }
    
    self.codeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(245), KSCALE_WIDTH(352) , KSCALE_WIDTH(100), KSCALE_WIDTH(58))];
    self.codeButton.backgroundColor = KCLEAR_COLOR;
    self.codeButton.titleLabel.font = K_16_FONT;
    self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[QCClassFunction stringTOColor:@"#FF9852"] forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeButton];
    
    UILabel * markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(430), KSCALE_WIDTH(315), KSCALE_WIDTH(44))];
    markLabel.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    markLabel.font = KSCALE_FONT(14);
    markLabel.textColor = [QCClassFunction stringTOColor:@"#999999"];
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.text = @"提示：请确保银行卡为实名人名下卡号";
    [QCClassFunction filletImageView:markLabel withRadius:KSCALE_WIDTH(8)];
    [self.view addSubview:markLabel];
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_HEIGHT(602) - KNavHight, KSCALE_WIDTH(315), KSCALE_HEIGHT(50))];
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.sureButton.titleLabel.font = K_18_FONT;
    [self.sureButton setTitle:@"绑定" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.sureButton];
    
}


@end
