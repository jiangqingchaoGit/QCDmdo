//
//  QCDeliveryViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCDeliveryViewController.h"

@interface QCDeliveryViewController ()
@property (nonatomic, strong) UIView * messageView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * freeLabel;
@property (nonatomic, strong) UILabel * unoldLabel;
@property (nonatomic, strong) NSString * delivery_type;

@property (nonatomic, strong) UIView * personMessageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UILabel * addressLabel;


@property (nonatomic, strong) UIView * deliveryView;
@property (nonatomic, strong) UIButton * deliveryButton;
@property (nonatomic, strong) UIButton * freeButton;
@property (nonatomic, strong) UILabel * deliveryLabel;
@property (nonatomic, strong) UITextField * deliveryTextField;
@property (nonatomic, strong) UILabel * deliveryNoLabel;
@property (nonatomic, strong) UITextField * deliveryNoTextField;
@property (nonatomic, strong) UIButton * sureButton;


@end

@implementation QCDeliveryViewController

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
    
    self.delivery_type = @"1";
    [self initUI];
    [self createView];
    [self createMessageView];
    [self createDeliveryView];
    
    [self filView];

}

- (void)filView {
    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:self.model.first_img AppendingString:@"" placeholderImage:@"header"];
    self.contentLabel.text = self.model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.model.goods_price];
    self.numLabel.text = [NSString stringWithFormat:@"库存：%@",self.model.stock];

    
    
    

    if ([self.model.is_new isEqualToString:@"1"]) {
        self.unoldLabel.text = @"全新";
    }else{
        self.unoldLabel.text = @"二手";
    }
    if ([self.model.delivery_type isEqualToString:@"1"]) {
        self.freeLabel.text = @"自提";
        self.freeLabel.hidden = NO;

    }else if ([self.model.delivery_type isEqualToString:@"2"]) {
        self.freeLabel.text = @"包邮";
        self.freeLabel.hidden = NO;

    }else{
        self.freeLabel.hidden = YES;
    }
    
    
    
}

- (void)resignAction {
    [UIView animateWithDuration:0.25 animations:^{

        self.view.frame = CGRectMake(0, KNavHight, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight);



    }];
    [self.deliveryTextField resignFirstResponder];
    [self.deliveryNoTextField resignFirstResponder];
    

}



- (void)initUI {

    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"发货";
    
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(520), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.sureButton setTitle:@"确认发货" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(5)];
    [self.view addSubview:self.sureButton];
    
   
}

- (void)createView {
    
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(115))];
    self.messageView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:self.messageView];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(90))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(5)];
    [self.messageView addSubview:self.headerImageView];

    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(15), KSCALE_WIDTH(225), KSCALE_WIDTH(55))];
    self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
    self.contentLabel.font = K_14_FONT;
    self.contentLabel.textColor = KTEXT_COLOR;
    self.contentLabel.numberOfLines = 0;
    [self.messageView addSubview:self.contentLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(75), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
    self.priceLabel.text = @"¥3700";
    self.priceLabel.font = K_16_BFONT;
    self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
    [self.messageView addSubview:self.priceLabel];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(75), KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
    self.numLabel.text = @"库存：120";
    self.numLabel.font = K_12_FONT;
    self.numLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.messageView addSubview:self.numLabel];
    

    
    
    self.freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(81), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
    self.freeLabel.text = @"包邮";
    self.freeLabel.font = K_10_FONT;
    self.freeLabel.layer.borderWidth = KSCALE_WIDTH(1);
    self.freeLabel.textAlignment = NSTextAlignmentCenter;
    self.freeLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#FFFFFF"].CGColor;
    self.freeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [QCClassFunction filletImageView:self.freeLabel withRadius:KSCALE_WIDTH(4)];
    [self.messageView addSubview:self.freeLabel];

    self.unoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(320), KSCALE_WIDTH(81), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
    self.unoldLabel.text = @"全新";
    self.unoldLabel.font = K_10_FONT;
    self.unoldLabel.layer.borderWidth = KSCALE_WIDTH(1);
    self.unoldLabel.textAlignment = NSTextAlignmentCenter;
    self.unoldLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#FFFFFF"].CGColor;
    self.unoldLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [QCClassFunction filletImageView:self.unoldLabel withRadius:KSCALE_WIDTH(4)];
    [self.messageView addSubview:self.unoldLabel];
    
}

- (void)createMessageView {
    
    self.personMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(115), KSCALE_WIDTH(375), KSCALE_WIDTH(190))];
    self.personMessageView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.view addSubview:self.personMessageView];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(30), KSCALE_WIDTH(6), KSCALE_WIDTH(16))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.personMessageView addSubview:lineView];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(30), KSCALE_WIDTH(100), KSCALE_WIDTH(16))];
    messageLabel.text = @"收货信息";
    messageLabel.font = K_16_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.personMessageView addSubview:messageLabel];
    
    
    NSArray * titleArr = @[@"收货人",@"联系电话",@"收货地址"];
    NSArray * messageArr = @[self.model.nick,self.model.usermobile,self.model.address];

    for (NSInteger i = 0; i < 3; i++) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(80), KSCALE_WIDTH(15))];
        label.text = titleArr[i];
        label.font = K_14_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.personMessageView addSubview:label];
        
        UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(235), KSCALE_WIDTH(15))];
        messageLabel.text = messageArr[i];
        messageLabel.font = K_14_FONT;
        messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        messageLabel.numberOfLines = 0;
        [self.personMessageView addSubview:messageLabel];
        
        if (i == 2) {
            messageLabel.frame = CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(235), KSCALE_WIDTH(35));
        }
    }
    
    UIView * messageLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(189), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
    messageLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.personMessageView addSubview:messageLineView];

}

- (void)createDeliveryView  {
    self.deliveryView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(305), KSCALE_WIDTH(375), KSCALE_WIDTH(160))];
    self.deliveryView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.view addSubview:self.deliveryView];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(30), KSCALE_WIDTH(6), KSCALE_WIDTH(16))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.deliveryView addSubview:lineView];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(30), KSCALE_WIDTH(100), KSCALE_WIDTH(16))];
    messageLabel.text = @"选择物流";
    messageLabel.font = K_16_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.deliveryView addSubview:messageLabel];
    

    self.freeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(60), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    self.freeButton.selected = YES;
    [self.freeButton setImage:[UIImage imageNamed:@"unselected_p"] forState:UIControlStateNormal];
    [self.freeButton setImage:[UIImage imageNamed:@"selected_p"] forState:UIControlStateSelected];
    [self.freeButton addTarget:self action:@selector(freeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.deliveryView addSubview:self.freeButton];
    
    UILabel * freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(60), KSCALE_WIDTH(60), KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
    freeLabel.text = @"无需物流";
    freeLabel.font = K_14_FONT;
    freeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.deliveryView addSubview:freeLabel];
    
    self.deliveryButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(160), KSCALE_WIDTH(60), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    [self.deliveryButton setImage:[UIImage imageNamed:@"unselected_p"] forState:UIControlStateNormal];
    [self.deliveryButton setImage:[UIImage imageNamed:@"selected_p"] forState:UIControlStateSelected];
    [self.deliveryButton addTarget:self action:@selector(deliveryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.deliveryView addSubview:self.deliveryButton];
    
    UILabel * deliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(190), KSCALE_WIDTH(60), KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
    deliveryLabel.text = @"物流发货";
    deliveryLabel.font = K_14_FONT;
    deliveryLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.deliveryView addSubview:deliveryLabel];
    
//
//    UIView * messageLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(189), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
//    messageLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
//    [self.deliveryView addSubview:messageLineView];
    
    
    self.deliveryLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(100), KSCALE_WIDTH(80), KSCALE_WIDTH(35))];
    self.deliveryLabel.text = @"选择物流";
    self.deliveryLabel.font = K_14_FONT;
    self.deliveryLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.deliveryView addSubview:self.deliveryLabel];
    
    self.deliveryTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(100), KSCALE_WIDTH(235), KSCALE_WIDTH(35))];
    self.deliveryTextField.placeholder = @"请输入物流公司";
    self.deliveryTextField.font = K_14_FONT;
    [self.deliveryView addSubview:self.deliveryTextField];
    
    self.deliveryNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(135), KSCALE_WIDTH(80), KSCALE_WIDTH(35))];
    self.deliveryNoLabel.text = @"物流单号";
    self.deliveryNoLabel.font = K_14_FONT;
    self.deliveryNoLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.deliveryView addSubview:self.deliveryNoLabel];
    
    
    self.deliveryNoTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(135), KSCALE_WIDTH(235), KSCALE_WIDTH(35))];
    self.deliveryNoTextField.placeholder = @"请输入物流单号";
    self.deliveryNoTextField.font = K_14_FONT;
    [self.deliveryView addSubview:self.deliveryNoTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];

    
    self.deliveryLabel.hidden = YES;
    self.deliveryTextField.hidden = YES;
    self.deliveryNoLabel.hidden = YES;
    self.deliveryNoTextField.hidden = YES;
}

#pragma mark - tapAction
- (void)freeAction:(UIButton *)sender{
    sender.selected = YES;
    self.deliveryButton.selected = NO;
    
    self.deliveryLabel.hidden = YES;
    self.deliveryTextField.hidden = YES;
    self.deliveryNoLabel.hidden = YES;
    self.deliveryNoTextField.hidden = YES;
    
    self.delivery_type = @"1";
}

- (void)deliveryAction:(UIButton *)sender{
    sender.selected = YES;
    self.freeButton.selected = NO;
    
    self.deliveryLabel.hidden = NO;
    self.deliveryTextField.hidden = NO;
    self.deliveryNoLabel.hidden = NO;
    self.deliveryNoTextField.hidden = NO;
    self.delivery_type = @"2";

}

- (void)sureAction:(UIButton *)sender {
    //  确认发货
    [self GETDATA];
}

- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"company_name=%@&delivery_type=%@&logistics_no=%@&order_id=%@&remark=&token=%@&uid=%@",self.deliveryTextField.text,self.delivery_type,self.deliveryNoTextField.text,self.model.id,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"company_name":self.deliveryTextField.text,@"delivery_type":self.delivery_type,@"logistics_no":self.deliveryNoTextField.text,@"order_id":self.model.id,@"remark":@"",@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/orderdelivery" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];

}


- (void)keyboardAction:(NSNotification*)sender{
    
    self.view.frame = CGRectMake(0, KNavHight, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight);

    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect keyboardFrame = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect rect= [self.deliveryNoTextField convertRect: self.deliveryNoTextField.bounds toView:window];
    
    CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{

//        self.viewH = self.viewH - keyboardFrame.size.height + footerH - KSCALE_WIDTH(58);
        self.view.frame = CGRectMake(0, - (rect.origin.y -  keyboardFrame.origin.y), KSCREEN_WIDTH, KSCREEN_HEIGHT);



    }];
    

    
}

@end
