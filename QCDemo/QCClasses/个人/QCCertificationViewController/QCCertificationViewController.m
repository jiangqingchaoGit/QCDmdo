//
//  QCCertificationViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCCertificationViewController.h"

@interface QCCertificationViewController ()
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UITextField * cardTextField;
@property (nonatomic, strong) UIButton * loginButton;

@property (nonatomic, strong) UILabel * loginLabel;
@property (nonatomic, strong) UILabel * messageLabel;


@end

@implementation QCCertificationViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBACK_COLOR;
    [self initUI];
}


#pragma mark - initUI
- (void)initUI {
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), 0, KSCALE_WIDTH(265), KSCALE_WIDTH(150))];
    self.backImageView.image = [UIImage imageNamed:@"底图"];
    [self.view addSubview:self.backImageView];
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(105) + KStatusHight, KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.loginLabel.text = @"已认证";
    self.loginLabel.font = K_24_BFONT;
    self.loginLabel.textColor = KTEXT_COLOR;
    self.loginLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.loginLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(140) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"您的账户已升级至安全保护状态";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipLabel];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(190) + KStatusHight, KSCALE_WIDTH(300), KSCALE_WIDTH(12))];
    self.messageLabel.text = @"实名用户信息：";
    self.messageLabel.font = K_12_FONT;
    self.messageLabel.textColor = [QCClassFunction stringTOColor:@"#FF9852"];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.messageLabel];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(209) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    NSArray * titleArr = @[@"姓名",@"身份证"];

    for (NSInteger i = 0; i < 2; i++) {
        
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(210) + KStatusHight + i * KSCALE_WIDTH(59), KSCALE_WIDTH(80), KSCALE_WIDTH(58))];
        nameLabel.text = titleArr[i];
        nameLabel.font = K_16_FONT;
        nameLabel.textColor = KTEXT_COLOR;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:nameLabel];
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(210) + KStatusHight + i * KSCALE_WIDTH(59), KSCALE_WIDTH(220), KSCALE_WIDTH(58))];
        textField.userInteractionEnabled = NO;
        textField.font = K_16_FONT;
        textField.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        textField.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:textField];
        
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(268) + KStatusHight + i * KSCALE_WIDTH(59), KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.view addSubview:lineView];
        
        switch (i) {
            case 0:
                self.nameTextField = textField;



                break;
            case 1:
                self.cardTextField = textField;
                self.cardTextField.keyboardType = UIKeyboardTypeNumberPad;


                break;
                
            default:
                break;
        }
    }

    
    NSString * cardStr = [QCClassFunction Read:@"cardNum"];
    self.nameTextField.text = [QCClassFunction Read:@"realName"];
    self.cardTextField.text = [cardStr stringByReplacingCharactersInRange:NSMakeRange(4, 10) withString:@" **** **** **"];

    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(380) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.loginButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.loginButton.titleLabel.font = K_18_FONT;
    [self.loginButton setTitle:@"开始验证" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.loginButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.loginButton];
    
    
    
    
    
}


#pragma mark - tapAction


- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)loginAction:(UIButton *)sender {
    //  人脸识别
    NSString *appcode = @"你自己的AppCode";
    NSString *host = @"https://rlsfzdb.market.alicloudapi.com";
    NSString *path = @"/face_id/check";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = @"idcard=230103196104153314&image=%2F9ai45bd****&name=%E5%BC%A0%E4%B8%89";

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    [request addValue: @"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
        completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Response object: %@" , response);
        NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];

        //打印应答中的body
        NSLog(@"Response body: %@" , bodyString);
        }];

    [task resume];
    
}








@end
