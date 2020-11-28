//
//  QCPayView.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPayView.h"
// zhuanzhang
#import "QCTransferViewController.h"

#import "QCSetPasswordViewController.h"
//  fahongbao
#import "QCSendEnvelopeViewController.h"
@interface QCPayView()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton * downButton;
@property (nonatomic, strong) UIButton * forgetButton;
@property (nonatomic, strong) UITextField * payTextField;

@property (nonatomic, strong) UILabel * codeLabelOne;
@property (nonatomic, strong) UILabel * codeLabelTwo;
@property (nonatomic, strong) UILabel * codeLabelThree;
@property (nonatomic, strong) UILabel * codeLabelFour;
@property (nonatomic, strong) UILabel * codeLabelFive;
@property (nonatomic, strong) UILabel * codeLabelSix;



@end

@implementation QCPayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

#pragma mark - tapAction
- (void)buttonAction:(UIButton *)sender {
    [[[sender superview] superview] removeFromSuperview];
}

- (void)forgetAction:(UIButton *)sender {
    self.hidden = YES;
    QCSetPasswordViewController * setPasswordViewController = [[QCSetPasswordViewController alloc] init];
    setPasswordViewController.hidesBottomBarWhenPushed = YES;
    [[QCClassFunction getCurrentViewController].navigationController pushViewController:setPasswordViewController animated:YES];
}

#pragma mark - initUI
- (void)initUI {
    self.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [QCClassFunction filletImageView:self withRadius:KSCALE_WIDTH(8)];
    
    UILabel * passLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(18), KSCALE_WIDTH(24), KSCALE_WIDTH(100), KSCALE_WIDTH(18))];
    passLabel.text = @"请输入支付密码";
    passLabel.font = K_14_FONT;
    passLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self addSubview:passLabel];
    
    self.downButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(18), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    [self.downButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.downButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.downButton];
    
    UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(70), KSCALE_WIDTH(315), KSCALE_WIDTH(40))];
    moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.messageDic[@"red_price"]];
    moneyLabel.font = K_36_BFONT;
    moneyLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:moneyLabel];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(110), KSCALE_WIDTH(315), KSCALE_WIDTH(30))];
    if ([self.type isEqualToString:@"0"]) {
        contentLabel.text = @"充值到dodo钱包";
    }
    if ([self.type isEqualToString:@"1"]) {
        contentLabel.text = @"转账";
    }
    if ([self.type isEqualToString:@"2"]) {
        contentLabel.text = @"发红包";
    }
    contentLabel.font = K_14_FONT;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:contentLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(18), KSCALE_WIDTH(174), KSCALE_WIDTH(279), KSCALE_WIDTH(1))];
    lineView.backgroundColor  =[QCClassFunction stringTOColor:@"#F2F2F2"];
    [self addSubview:lineView];
    
    
    for (NSInteger i = 0; i <= 5; i++) {
        
        UILabel * codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * KSCALE_WIDTH(47) + KSCALE_WIDTH(18.5), KSCALE_WIDTH(210), KSCALE_WIDTH(43), KSCALE_WIDTH(50))];
        codeLabel.font = K_20_BFONT;
        codeLabel.textColor = KTEXT_COLOR;
        codeLabel.textAlignment = NSTextAlignmentCenter;
        codeLabel.backgroundColor = KCLEAR_COLOR;
        codeLabel.layer.borderWidth = KSCALE_WIDTH(1);
        codeLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#BCBCBC"].CGColor;
        codeLabel.tag = i + 1;
        [QCClassFunction filletImageView:codeLabel withRadius:KSCALE_WIDTH(12)];
        [self addSubview:codeLabel];
        
        switch (i) {
            case 0:
                self.codeLabelOne = codeLabel;
                break;
            case 1:
                self.codeLabelTwo = codeLabel;
                
                break;
            case 2:
                self.codeLabelThree = codeLabel;
                
                break;
            case 3:
                self.codeLabelFour = codeLabel;
                
                break;
            case 4:
                self.codeLabelFive = codeLabel;
                
                break;
            case 5:
                self.codeLabelSix = codeLabel;
                
                break;
                
            default:
                break;
        }
        
    }
    
    self.payTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(210), KSCALE_WIDTH(315), KSCALE_WIDTH(50))];
    self.payTextField.backgroundColor = KCLEAR_COLOR;
    self.payTextField.textColor = KCLEAR_COLOR;
    self.payTextField.tintColor= KCLEAR_COLOR;
    self.payTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.payTextField.delegate = self;
    [self.payTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.payTextField];
    
    
    
    self.forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(265), KSCALE_WIDTH(97), KSCALE_WIDTH(50))];
    self.forgetButton.titleLabel.font = K_14_FONT;
    self.forgetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.forgetButton setTitle:@"忘记支付密码?" forState:UIControlStateNormal];
    [self.forgetButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.forgetButton];
    
    
}

- (void)textFieldDidChange:(UITextField *)sender {
    if (sender.text.length == 6) {
        
        [sender resignFirstResponder];
        NSString * str = [NSString stringWithFormat:@"pwd=%@&token=%@&type=%@&uid=%@",sender.text,K_TOKEN,self.type,K_UID?K_UID:@""];
        
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"pwd":sender.text,@"token":K_TOKEN,@"type":self.type,@"uid":K_UID?K_UID:@""};
        
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        [QCAFNetWorking QCPOST:@"/api/user/verify_pwd" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            
            if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
                [[[sender superview] superview] removeFromSuperview];
                
                if ([self.type isEqualToString:@"1"]) {
                    QCTransferViewController * transferViewController = (QCTransferViewController *)[QCClassFunction getCurrentViewController];
                    
                    
                    [self.messageDic setValue:responseObject[@"data"][@"key"] forKey:@"key"];
                    transferViewController.myBlock(self.messageDic);
                    [transferViewController.navigationController popViewControllerAnimated:YES];
                }
                
                if ([self.type isEqualToString:@"2"]) {
                    QCSendEnvelopeViewController * sendEnvelopeViewController = (QCSendEnvelopeViewController *)[QCClassFunction getCurrentViewController];
                    
                    [self.messageDic setValue:responseObject[@"data"][@"key"] forKey:@"key"];
                                        
                    sendEnvelopeViewController.myBlock(self.messageDic);
                    [sendEnvelopeViewController.navigationController popViewControllerAnimated:YES];
                }
                

            }else{

                [QCClassFunction showMessage:@"输入密码错误，请重新输入" toView:self];
                self.payTextField.text = @"";
                self.codeLabelOne.text = @"";
                self.codeLabelTwo.text = @"";
                self.codeLabelThree.text = @"";
                self.codeLabelFour.text = @"";
                self.codeLabelFive.text = @"";
                self.codeLabelSix.text = @"";
            }
            
            
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [[[sender superview] superview] removeFromSuperview];
            [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:[QCClassFunction getCurrentViewController].view];
        }];
        
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
