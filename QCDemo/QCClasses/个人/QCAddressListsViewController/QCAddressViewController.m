//
//  QCAddressViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddressViewController.h"
#import "QCPickVIew.h"
@interface QCAddressViewController ()
@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UITextField * locationTextField;
@property (nonatomic, strong) UISwitch * defaultSwitch;
@property (nonatomic, strong) NSString * defaultStr;
@property (nonatomic, strong) NSString * urlStr;

@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, strong) QCPickVIew * pickView;



@end

@implementation QCAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.defaultStr = @"0";
    [self initUI];
}
#pragma mark - initUi
- (void)initUI {
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    
    UIView * messageView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(10), KSCALE_WIDTH(375), KSCALE_WIDTH(265))];
    messageView.backgroundColor = KBACK_COLOR;
    [self.view addSubview:messageView];
    
    NSArray * titleArr = @[@"收货人",@"手机号码",@"所在地区",@"详细地址",@"设为默认"];
    for (NSInteger i = 0; i < 5; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(53) * i, KSCALE_WIDTH(80), KSCALE_WIDTH(52))];
        label.font = K_14_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#666666"];
        label.text = titleArr[i];
        [messageView addSubview:label];
        
        if (i < 4) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(52) + KSCALE_WIDTH(53) * i, KSCALE_WIDTH(355), KSCALE_WIDTH(1))];
            lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
            [messageView addSubview:lineView];
        }
    }
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(0), KSCALE_WIDTH(255), KSCALE_WIDTH(52))];
    self.nameTextField.placeholder = @"请输入收货人姓名";
    self.nameTextField.textColor = KTEXT_COLOR;
    self.nameTextField.font = K_14_FONT;
    [messageView addSubview:self.nameTextField];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(53), KSCALE_WIDTH(255), KSCALE_WIDTH(52))];
    self.phoneTextField.placeholder = @"请输入手机号码";
    self.phoneTextField.textColor = KTEXT_COLOR;
    self.phoneTextField.font = K_14_FONT;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [messageView addSubview:self.phoneTextField];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(106), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    self.addressLabel.text = @"请选择所在地区";
    self.addressLabel.textColor = [QCClassFunction stringTOColor:@"#cacaca"];
    self.addressLabel.font = K_14_FONT;
    [messageView addSubview:self.addressLabel];
    
    UIButton * addressButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(106), KSCALE_WIDTH(255), KSCALE_WIDTH(52))];
    addressButton.backgroundColor = [UIColor clearColor];
    [addressButton addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    [messageView addSubview:addressButton];
    
    UIImageView * addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(349), KSCALE_WIDTH(124), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    addressImageView.image = [UIImage imageNamed:@"leftarrow"];
    addressImageView.contentMode = UIViewContentModeCenter;
    [messageView addSubview:addressImageView];
    
    self.locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(159), KSCALE_WIDTH(255), KSCALE_WIDTH(53))];
    self.locationTextField.placeholder = @"请输入详细收货地址";
    self.locationTextField.textColor = KTEXT_COLOR;
    self.locationTextField.font = K_14_FONT;
    [messageView addSubview:self.locationTextField];
    
    self.defaultSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(305), KSCALE_WIDTH(223), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
    self.defaultSwitch.onTintColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.defaultSwitch.tintColor = [UIColor greenColor];
    self.defaultSwitch.on = NO;
    self.defaultSwitch.thumbTintColor = [UIColor whiteColor];
    [self.defaultSwitch addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventValueChanged | UIControlEventTouchDragExit];

    [messageView addSubview:self.defaultSwitch];
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCREEN_HEIGHT - KTabHight - KSCALE_WIDTH(11) - KNavHight, KSCALE_WIDTH(335), KSCALE_WIDTH(42))];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    if (self.model) {
        [self.sureButton setTitle:@"修改地址" forState:UIControlStateNormal];
    }else{
        [self.sureButton setTitle:@"添加地址" forState:UIControlStateNormal];

    }
    [self.sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(5)];
    [self.view addSubview:self.sureButton];
    
    if (self.model) {
        self.nameTextField.text = self.model.name;
        self.phoneTextField.text = self.model.mobile;
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",self.model.province_name,self.model.city_name,self.model.area_name];
        self.addressLabel.textColor = KTEXT_COLOR;
        self.addressStr = self.addressLabel.text;
        self.addressDic = @{@"province":self.model.province_name,@"country":self.model.area_name,@"city":self.model.city_name};
        self.locationTextField.text =self.model.address;
        if ([self.model.is_default isEqualToString:@"1"]) {
            self.defaultSwitch.on =  YES;
        }else{
            self.defaultSwitch.on =  NO;

        }
    }
    
}

#pragma mark - tapAction
- (void)switchBtnAction:(UISwitch *)sender {
    
    
    if (sender.on) {
        self.defaultStr = @"1";
        
    }else {
        self.defaultStr = @"0";

    }
}
- (void)resignAction {
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.locationTextField resignFirstResponder];

}


- (void)addressAction:(UIButton *)sender {
    [self resignAction];
    UIView * backView = [[QCClassFunction shared] createBackView];
    self.pickView = [[QCPickVIew alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(250), KSCALE_WIDTH(375), KSCALE_WIDTH(250))];
    [backView addSubview:self.pickView];
}


- (void)sureAction:(UIButton *)sender {
    
    if (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请输入收货人姓名" toView:self.view];
        return;
    }
    
    if (self.phoneTextField.text == nil || [self.phoneTextField.text isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请输入手机号码" toView:self.view];
        return;

    }
    if (self.addressStr == nil || [self.addressStr isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请选择所在地区" toView:self.view];
        return;

    }
    
    if (self.locationTextField.text == nil || [self.locationTextField.text isEqualToString:@""]) {
        [QCClassFunction showMessage:@"请选择详细收货地址" toView:self.view];
        return;

    }
    [self GETDATA];
}

#pragma mark - GETDATA

- (void)GETDATA {
    //  address
    //  area_name
    //  area_id
    //  city_name
    //  city_id
    //  is_default
    //  mobile
    //  name
    //  province_name
    //  province_id         addressViewController.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",dic[@"province"],dic[@"city"],dic[@"country"]];
    
    if (self.model) {
        self.urlStr = @"/api/user/updateaddress";
    }else{
        self.urlStr = @"/api/user/addaddress";

    }

    NSString * str = [NSString stringWithFormat:@"address=%@&area_id=1&area_name=%@&city_id=1&city_name=%@&id=%@&is_default=%@&mobile=%@&name=%@&province_id=1&province_name=%@&token=%@&uid=%@",self.locationTextField.text,self.addressDic[@"country"],self.addressDic[@"city"],self.model.id?self.model.id:@"",self.defaultStr,self.phoneTextField.text,self.nameTextField.text,self.addressDic[@"province"],K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    
    NSDictionary * dic = @{@"address":self.locationTextField.text,@"area_name":self.addressDic[@"country"],@"area_id":@"1",@"city_name":self.addressDic[@"city"],@"city_id":@"1",@"is_default":self.defaultStr,@"mobile":self.phoneTextField.text,@"name":self.nameTextField.text,@"province_name":self.addressDic[@"province"],@"province_id":@"1",@"id":self.model.id?self.model.id:@"",@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:self.urlStr parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {


        if ([responseObject[@"status"] intValue] == 1) {
            
            [QCClassFunction showMessage:@"添加成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];

        }



    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}


@end
