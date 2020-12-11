//
//  QCSendEnvelopeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSendEnvelopeViewController.h"
#import "QCPayView.h"
#import "QCPayTypeView.h"

#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"
#import "QCOpenViewController.h"
#import "QCRealnameViewController.h"

@interface QCSendEnvelopeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) QCPayView * payView;

@property (nonatomic, strong) UITextField * totalMoneyTextField;



@property (nonatomic, strong) UILabel * totalMoneyLabel;
@property (nonatomic, strong) UILabel * moneyLabel;

@property (nonatomic, strong) UILabel * restMoneyLabel;
@property (nonatomic, strong) UIButton * typeButton;
@property (nonatomic, strong) UILabel * typeLabel;

@property (nonatomic, strong) UIView * numView;
@property (nonatomic, strong) UITextField * moneyNumTextField;
@property (nonatomic, strong) UILabel * numUnitLabel;
@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) UILabel * peopleNumLabel;


@property (nonatomic, strong) UIView * messageView;
@property (nonatomic, strong) UITextField * messageTextField;


@property (nonatomic, strong) NSString * moneyStr;

@property (nonatomic, strong) NSString * red_type;

@property (nonatomic, strong) QCPayTypeView * payTypeView;


@end

@implementation QCSendEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.payType = @"1";
    

    self.red_type = @"2";
    [self createSenderView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

#pragma mark - tapAction
- (void)typeAction:(UIButton *)sender {
    
    if (sender.selected == YES) {
        sender.selected = NO;
        self.typeLabel.text = @"当前为普通红包，改为拼手气红包";
        self.moneyLabel.text = @"单个金额";
        self.typeLabel.attributedText = [QCClassFunction getColorWithString:self.typeLabel.text andTargetString:@"改为拼手气红包" withColor:[UIColor purpleColor]];
        self.red_type = @"2";

    }else{
        sender.selected = YES;
        self.typeLabel.text = @"当前为拼手气红包，改为普通红包";
        self.moneyLabel.text = @"总金额";
        self.typeLabel.attributedText = [QCClassFunction getColorWithString:self.typeLabel.text andTargetString:@"改为普通红包" withColor:[UIColor purpleColor]];
        self.red_type = @"1";

        
    }
    
    if ([self.red_type isEqualToString:@"2"]) {
        //  普通红包
        self.totalMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",            [self.moneyNumTextField.text intValue] * [self.totalMoneyTextField.text floatValue]
];

    }else{
        self.totalMoneyLabel.text =  [NSString stringWithFormat:@"¥%.2f",[self.totalMoneyTextField.text floatValue]];


    }
    
    
}
- (void)buttonAction:(UIButton *)sender {
    //  选择银行卡

    [self.totalMoneyTextField resignFirstResponder];
    [self.moneyNumTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];

    kWeakSelf(self);
    UIView * backView = [[QCClassFunction shared] createBackView];
    self.payTypeView = [[QCPayTypeView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(312), KSCALE_WIDTH(375), KSCALE_WIDTH(312))];
    self.payTypeView.statusStr = @"1";
    self.payTypeView.typeStr = @"发红包";
    [self.payTypeView initUI];
    self.payTypeView.typeBlock = ^(NSDictionary * _Nonnull payTypeDic) {
        weakself.bankLabel.text = [NSString stringWithFormat:@"%@（%@）",payTypeDic[@"payName"],payTypeDic[@"payNo"]];
    };

    [backView addSubview:self.payTypeView];
    

}

- (void)createSenderView {
    
    self.title = @"发红包";
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [self.view addGestureRecognizer:click];
    
    UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(20), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
    typeLabel.text = @"支付方式";
    typeLabel.font = K_14_FONT;
    typeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:typeLabel];
    
    self.bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(20), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.bankLabel.text = @"农业银行（**8673）";
    self.bankLabel.font = K_16_FONT;
    self.bankLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.view addSubview:self.bankLabel];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(50), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
    contentLabel.text = @"单日交易限额￥50000.0";
    contentLabel.font = K_14_FONT;
    contentLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.view addSubview:contentLabel];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(42), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    imageView.image = [UIImage imageNamed:@"leftarrow"];
    [self.view addSubview:imageView];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(70))];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIView * moneyView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    moneyView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:moneyView withRadius:KSCALE_WIDTH(5)];
    [self.view addSubview:moneyView];

    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(20), KSCALE_WIDTH(142), KSCALE_WIDTH(335), KSCALE_WIDTH(30))];
    self.typeLabel.font = K_12_FONT;
    self.typeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    self.typeLabel.text = @"当前为普通红包，改为拼手气红包";
    self.typeLabel.attributedText = [QCClassFunction getColorWithString:self.typeLabel.text andTargetString:@"改为拼手气红包" withColor:[UIColor purpleColor]];
    self.typeLabel.hidden = YES;

    [self.view addSubview:self.typeLabel];
    
    self.typeButton = [[UIButton alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(20), KSCALE_WIDTH(142), KSCALE_WIDTH(335), KSCALE_WIDTH(30))];
    self.typeButton.backgroundColor = KCLEAR_COLOR;
    [self.typeButton addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    self.typeButton.hidden = YES;
    [self.view addSubview:self.typeButton];
    
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(10), KSCALE_WIDTH(0), KSCALE_WIDTH(80), KSCALE_WIDTH(52))];
    self.moneyLabel.text = @"金额";
    self.moneyLabel.font = K_16_FONT;
    self.moneyLabel.textColor = KTEXT_COLOR;
    [moneyView addSubview:self.moneyLabel];
    
    self.totalMoneyTextField = [[UITextField alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(90), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    self.totalMoneyTextField.font = K_16_FONT;
    self.totalMoneyTextField.textColor = KTEXT_COLOR;
    self.totalMoneyTextField.placeholder = @"0.00";
    self.totalMoneyTextField.delegate = self;
    self.totalMoneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.totalMoneyTextField.textAlignment = NSTextAlignmentRight;
    [moneyView addSubview:self.totalMoneyTextField];
    
    UILabel * unitLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(300), KSCALE_WIDTH(0), KSCALE_WIDTH(20), KSCALE_WIDTH(52))];
    unitLabel.text = @"元";
    unitLabel.font = K_16_FONT;
    unitLabel.textColor = KTEXT_COLOR;
    unitLabel.textAlignment = NSTextAlignmentRight;
    [moneyView addSubview:unitLabel];
    

    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(160), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.messageView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.messageView withRadius:KSCALE_WIDTH(5)];
    [self.view addSubview:self.messageView];


    self.messageTextField = [[UITextField alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(10), KSCALE_WIDTH(0), KSCALE_WIDTH(315), KSCALE_WIDTH(52))];
    self.messageTextField.font = K_16_FONT;
    self.messageTextField.textColor = KTEXT_COLOR;
    self.messageTextField.placeholder = @"恭喜发财，大吉大利";
    self.messageTextField.delegate = self;
    [self.messageView addSubview:self.messageTextField];
    
    if ([self.target_type isEqualToString:@"1"]) {
        self.numView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(190), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
        self.numView.backgroundColor = KBACK_COLOR;
        [QCClassFunction filletImageView:self.numView withRadius:KSCALE_WIDTH(5)];
        [self.view addSubview:self.numView];

        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(10), KSCALE_WIDTH(0), KSCALE_WIDTH(80), KSCALE_WIDTH(52))];
        self.numberLabel.text = @"红包个数";
        self.numberLabel.font = K_16_FONT;
        self.numberLabel.textColor = KTEXT_COLOR;
        [self.numView addSubview:self.numberLabel];

        self.moneyNumTextField = [[UITextField alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(90), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.moneyNumTextField.font = K_16_FONT;
        self.moneyNumTextField.textColor = KTEXT_COLOR;
        self.moneyNumTextField.placeholder = @"填写个数";
        self.moneyNumTextField.delegate = self;
        self.moneyNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.moneyNumTextField.textAlignment = NSTextAlignmentRight;

        [self.numView addSubview:self.moneyNumTextField];

        self.numUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(300), KSCALE_WIDTH(0), KSCALE_WIDTH(20), KSCALE_WIDTH(52))];
        self.numUnitLabel.text = @"个";
        self.numUnitLabel.font = K_16_FONT;
        self.numUnitLabel.textColor = KTEXT_COLOR;
        self.numUnitLabel.textAlignment = NSTextAlignmentRight;
        [self.numView addSubview:self.numUnitLabel];
        
        self.numView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(190), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
        self.numView.backgroundColor = KBACK_COLOR;
        [QCClassFunction filletImageView:self.numView withRadius:KSCALE_WIDTH(5)];
        [self.view addSubview:self.numView];

        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(10), KSCALE_WIDTH(0), KSCALE_WIDTH(80), KSCALE_WIDTH(52))];
        self.numberLabel.text = @"红包个数";
        self.numberLabel.font = K_16_FONT;
        self.numberLabel.textColor = KTEXT_COLOR;
        [self.numView addSubview:self.numberLabel];

        self.moneyNumTextField = [[UITextField alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(90), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.moneyNumTextField.font = K_16_FONT;
        self.moneyNumTextField.textColor = KTEXT_COLOR;
        self.moneyNumTextField.placeholder = @"填写个数";
        self.moneyNumTextField.delegate = self;
        self.moneyNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.moneyNumTextField.textAlignment = NSTextAlignmentRight;
        [self.numView addSubview:self.moneyNumTextField];

        self.numUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(300), KSCALE_WIDTH(0), KSCALE_WIDTH(20), KSCALE_WIDTH(52))];
        self.numUnitLabel.text = @"个";
        self.numUnitLabel.font = K_16_FONT;
        self.numUnitLabel.textColor = KTEXT_COLOR;
        self.numUnitLabel.textAlignment = NSTextAlignmentRight;
        [self.numView addSubview:self.numUnitLabel];
        
        self.peopleNumLabel = [[UILabel alloc] initWithFrame:CGRectMake( KSCALE_WIDTH(20), KSCALE_WIDTH(242), KSCALE_WIDTH(335), KSCALE_WIDTH(30))];
        self.peopleNumLabel.font = K_12_FONT;
        self.peopleNumLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        self.peopleNumLabel.text = @"本群共6人";
        [self.view addSubview:self.peopleNumLabel];
        
        self.moneyLabel.text = @"单个金额";
        self.typeLabel.hidden = NO;
        self.typeButton.hidden = NO;
        self.messageView.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(290), KSCALE_WIDTH(335), KSCALE_WIDTH(52));
        
        
    }
    

    
    
    
    
    self.totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, KSCALE_WIDTH(380), KSCREEN_WIDTH, KSCALE_WIDTH(30))];
    self.totalMoneyLabel.text = @"¥00.00";
    self.totalMoneyLabel.font = K_30_BFONT;
    self.totalMoneyLabel.textColor = KTEXT_COLOR;
    self.totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.totalMoneyLabel];
    
    
    
    
    UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(450), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    sureButton.titleLabel.font = K_16_FONT;
    sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [sureButton setTitle:@"塞钱进红包" forState:UIControlStateNormal];
    [sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:sureButton withRadius:KSCALE_WIDTH(5)];
    [self.view addSubview:sureButton];
    
}

- (void)sureAction:(UIButton *)sender {
    //  进行传值
    [self.totalMoneyTextField resignFirstResponder];
    [self.moneyNumTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];

    
    if ([[QCClassFunction Read:@"wallet"] isEqualToString:@"0"]) {

        //  开通说明
        QCOpenViewController * openViewController = [[QCOpenViewController alloc] init];
        openViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:openViewController animated:YES];
        return;
        
    }else if([[QCClassFunction Read:@"realName"] isEqualToString:@""] || [QCClassFunction Read:@"realName"] == nil) {
        
        //  开通说明
        QCRealnameViewController * realnameViewController = [[QCRealnameViewController alloc] init];
        realnameViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:realnameViewController animated:YES];
        return;

    }else{


    }
    
    
//    if ([self.totalMoneyTextField.text floatValue]> [self.moneyStr floatValue]) {
//        [QCClassFunction showMessage:@"余额不足请充值" toView:self.view];
//        return;
//    }
    if ([self.totalMoneyTextField.text isEqualToString:@""] || self.totalMoneyTextField.text == nil) {

        [QCClassFunction showMessage:@"请输入红包金额" toView:self.view];
        return;
    }

    if ([self.totalMoneyTextField.text floatValue] <= 0) {
        [QCClassFunction showMessage:@"红包金额应该大于0" toView:self.view];

        return;
    }
    if ([self.target_type isEqualToString:@"1"]) {
        if ([self.moneyNumTextField.text isEqualToString:@""] || self.moneyNumTextField.text == nil) {

            [QCClassFunction showMessage:@"请输入红包数量" toView:self.view];
            return;
        }
    }


    
    NSString * messageStr;
    if (self.messageTextField.text == nil || [self.messageTextField.text isEqualToString:@""]) {
        messageStr = @"恭喜发财，大吉大利";
    }else{
        messageStr = self.messageTextField.text;

    }
    
    
    UIView * backView = [[QCClassFunction shared] createBackView];


    self.payView = [[QCPayView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCREEN_HEIGHT / 2.0 - KSCALE_WIDTH(180), KSCALE_WIDTH(315), KSCALE_WIDTH(315))];
    self.payView.type = @"2";
    //  method  1为余额支付，2为支付平台支付
    //  target_type 1为群红包，2为个人红包
    //  red_num  红包个数，个人为数量为1，群为红包个数
    //  red_type  红包类型，1为随机红包，2为普通红包
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"method":self.payType,@"bankId":self.bankId?self.bankId:@"",@"red_price":self.totalMoneyTextField.text,@"target_type":self.target_type,@"red_num":self.moneyNumTextField.text?self.moneyNumTextField.text:@"1",@"red_type":self.red_type,@"message":messageStr}];
    self.payView.messageDic = dic;
    
    [self.payView initUI];
    [backView addSubview:self.payView];



}

- (void)cancelAction:(UIButton *)sender {
    [self.totalMoneyTextField resignFirstResponder];
    [self.moneyNumTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickAction {
    
    [self.totalMoneyTextField resignFirstResponder];
    [self.moneyNumTextField resignFirstResponder];
    [self.messageTextField resignFirstResponder];

}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _totalMoneyTextField) {
        

        
        if ([self.red_type isEqualToString:@"2"]) {
            //  普通红包
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",            [self.moneyNumTextField.text intValue] * [self.totalMoneyTextField.text floatValue]
];

        }else{
            self.totalMoneyLabel.text =  [NSString stringWithFormat:@"¥%.2f",[self.totalMoneyTextField.text floatValue]];


        }


        
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.moneyNumTextField) {
        if ([self.red_type isEqualToString:@"2"]) {
            //  普通红包
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",            [string intValue] * [self.totalMoneyTextField.text floatValue]
];

        }else{
            self.totalMoneyLabel.text =  [NSString stringWithFormat:@"¥%.2f",[self.totalMoneyTextField.text floatValue]];


        }
    }
    
    
    if (textField == _totalMoneyTextField) {

        // 判断是否输入内容，或者用户点击的是键盘的删除按钮
        
        if (![string isEqualToString:@""]) {
            NSCharacterSet *cs;
            // 小数点在字符串中的位置 第一个数字从0位置开始
            
            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
            
            // 判断字符串中是否有小数点，并且小数点不在第一位
            
            // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
            
            // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
            
            if (dotLocation == NSNotFound && range.location != 0) {
                
                // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
                
                /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
                 */
                cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
                if (range.location >= 9) {
                    NSLog(@"单笔积分不能超过亿位");
                    if ([string isEqualToString:@"."] && range.location == 9) {

                        return YES;
                    }
                    return NO;
                }
            }else {
                
                cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
                
            }
            // 按cs分离出数组,数组按@""分离出字符串
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            BOOL basicTest = [string isEqualToString:filtered];
            
            if (!basicTest) {
                
                NSLog(@"只能输入数字和小数点");
                
                return NO;
                
            }
            
            if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
                
                NSLog(@"小数点后最多两位");
                
                return NO;
            }
            if (textField.text.length > 11) {
                
                return NO;
                
            }
            
            
            
        }
        
        return YES;
    }
//    else if (textField == self.moneyNumTextField){
//        if (string.length > 0) {
//
//            //当前输入的字符
//            unichar single = [string characterAtIndex:0];
////            (single >= '1')
//            // 不能输入.0-9以外的字符
//            if (!((single >= '1') || single == '.'))
//            {
//                //            [SDIndicator showInfoWithMessage:@"您的输入折扣不正确"];
//                return NO;
//            }
//
//
//
//            // 如果第一位是.则前面加上1.
//            if ((textField.text.length == 0) && (single == '.')) {
//                textField.text = @"1";
//            }
//
//
//            if (single != '.'&&textField.text.length > 0) {
//                return NO;
//            }
//
//
//        }
//
//        return YES;
//
//    }
    return YES;

}






@end
