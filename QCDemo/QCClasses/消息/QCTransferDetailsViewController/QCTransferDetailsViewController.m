//
//  QCTransferDetailsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCTransferDetailsViewController.h"



@interface QCTransferDetailsViewController ()
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * personLabel;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UIButton * sureButton;

@end

@implementation QCTransferDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;

    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(151.5), KSCALE_WIDTH(60), KSCALE_WIDTH(72), KSCALE_WIDTH(72))];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[QCClassFunction URLDecodedString:@""]] placeholderImage:[UIImage imageNamed:@"header"]];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(35)];
    [self.view addSubview:self.headerImageView];
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(150), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.personLabel.font = K_16_BFONT;
    self.personLabel.textAlignment = NSTextAlignmentCenter;
    self.personLabel.textColor = [QCClassFunction stringTOColor:@"#ffb333"];
    [self.view addSubview:self.personLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(200), KSCREEN_WIDTH,KSCALE_WIDTH(30))];
    self.moneyLabel.text = [NSString stringWithFormat: @"¥%@",self.typeDic[@"amount"]];
    self.moneyLabel.font = K_30_BFONT;
    self.moneyLabel.textColor = KTEXT_COLOR;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.moneyLabel];
    
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(450), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.sureButton setTitle:@"确认收款" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(5)];
    [self.view addSubview:self.sureButton];
    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:self.typeDic[@"head"] AppendingString:nil placeholderImage:@"header"];

    if ([self.type isEqualToString:@"0"]) {
        if ([[self.typeDic[@"act"] stringValue]  isEqualToString:@"1"]) {
//            self.personLabel.text =[NSString stringWithFormat:@"发给%@的红包",[QCClassFunction URLDecodedString:@"思绪云骞"]];
            self.personLabel.text = @"等待收款";
            self.sureButton.hidden = YES;

        }
        if ([[self.typeDic[@"act"] stringValue]  isEqualToString:@"2"]) {
//            self.personLabel.text =[NSString stringWithFormat:@"发给%@的红包",[QCClassFunction URLDecodedString:@"思绪云骞"]];
            self.personLabel.text = @"已收款";
            self.sureButton.hidden = YES;

        }
        
        if ([[self.typeDic[@"act"] stringValue]  isEqualToString:@"3"]) {
//            self.personLabel.text =[NSString stringWithFormat:@"发给%@的红包",[QCClassFunction URLDecodedString:@"思绪云骞"]];
            self.personLabel.text = @"已退还";
            self.sureButton.hidden = YES;

        }
    }else{
        if ([[self.typeDic[@"act"] stringValue]  isEqualToString:@"1"]) {
//            self.personLabel.text =[NSString stringWithFormat:@"%@的红包",[QCClassFunction URLDecodedString:self.typeDic[@"nick"]]];
            self.personLabel.text = @"未收款";
            self.sureButton.hidden = NO;

        }
        if ([[self.typeDic[@"act"] stringValue]  isEqualToString:@"2"]) {
            
//            self.personLabel.text =[NSString stringWithFormat:@"%@的红包",[QCClassFunction URLDecodedString:self.typeDic[@"nick"]]];
            self.personLabel.text = @"已收款";
            self.sureButton.hidden = YES;

        }
        
        if ([[self.typeDic[@"act"] stringValue]  isEqualToString:@"3"]) {
//            self.personLabel.text =[NSString stringWithFormat:@"%@的红包",[QCClassFunction URLDecodedString:self.typeDic[@"nick"]]];
            self.personLabel.text = @"已退还";
            self.sureButton.hidden = YES;

        }
    }
    

    
}

- (void)sureAction:(UIButton *)sender {
    
    NSString * str = [NSString stringWithFormat:@"token=%@&tran_id=%@&uid=%@",K_TOKEN,self.typeDic[@"tran_id"],K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"tran_id":self.self.typeDic[@"tran_id"],@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    
    [QCAFNetWorking QCPOST:@"/api/finance/receivetransfer" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        if ([responseObject[@"status"]  intValue] == 1) {
            self.sureBlock(@"1");
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];

    }];
}



@end
