//
//  QCReleaseViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCReleaseViewController.h"
#import "QCPickVIew.h"
#import "QCClassificationViewcontroller.h"

#import "QCGoodsDetailsModel.h"
#import "QCImageDetailsModel.h"
#import "QCImageDetailsModel.h"


@interface QCReleaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * imageArr;
@property (nonatomic, strong) NSMutableArray * imageDetailsArr;
@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) NSString * rollingViewUrl;
@property (nonatomic, strong) NSString * introduceViewUrl;

@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UITextField * titleTextField;

@property (nonatomic, strong) UIView * describeView;
@property (nonatomic, strong) UITextView * describeTextView;


@property (nonatomic, strong) UIView * goodsView;
@property (nonatomic, strong) UILabel * goodsLabel;
@property (nonatomic, strong) UITextField * lowPriceField;
@property (nonatomic, strong) UITextField * highPriceTextField;
@property (nonatomic, strong) UITextField * numberTextField;

@property (nonatomic, strong) UILabel * classLabel;
@property (nonatomic, strong) NSString * classId;

@property (nonatomic, strong) UILabel * recommendedLabel;
@property (nonatomic, strong) UILabel * killLabel;
@property (nonatomic, strong) UISwitch * recommendedSwitch;
@property (nonatomic, strong) UISwitch * killSwitch;

@property (nonatomic, strong) UIImageView * agreeImageView;
@property (nonatomic, strong) UILabel * markLabel;


@property (nonatomic, strong) UIButton * agreeButton;
@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, strong) UIButton * freeButton;
@property (nonatomic, strong) NSString * freeStr;

@property (nonatomic, strong) UIButton * unoldButton;
@property (nonatomic, strong) NSString * unoldStr;


@property (nonatomic, strong) NSString * is_query;
@property (nonatomic, strong) NSString * is_spike;
@property (nonatomic, strong) NSString * logistics_price;

@property (nonatomic, strong) QCPickVIew * pickView;

@end

@implementation QCReleaseViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.freeStr = @"3";
    self.unoldStr = @"0";
    self.is_query = @"0";
    self.is_spike = @"0";
    self.logistics_price = @"5";
    self.dataArr = [[NSMutableArray alloc] init];
    self.imageArr = [[NSMutableArray alloc] init];
    self.imageDetailsArr = [[NSMutableArray alloc] init];
    

    if (self.goodsId) {
        [self GETDATA];
    }
    [self initUI];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
}

- (void)resignAction {
    [self.titleTextField resignFirstResponder];
    [self.describeTextView resignFirstResponder];
    [self.lowPriceField resignFirstResponder];
    [self.highPriceTextField resignFirstResponder];
    [self.numberTextField resignFirstResponder];

}
- (void)initUI {
    self.title = @"发布";
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];


    
    UILabel * rollingLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(30))];
    rollingLabel.text = @"封面滚动图,最多四张";
    rollingLabel.textColor = KTEXT_COLOR;
    rollingLabel.font = K_12_FONT;
    [self.scrollView addSubview:rollingLabel];
    
    self.rollingView = [[QCRollingView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(30), KSCALE_WIDTH(335), KSCALE_WIDTH(90))];
    self.rollingView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.rollingView withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.rollingView];
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(120), KSCALE_WIDTH(335), KSCALE_WIDTH(40))];
    titleLabel.text = @"输入商品名称（不超过20字）:";
    titleLabel.textColor = KTEXT_COLOR;
    titleLabel.font = K_12_FONT;
    [self.scrollView addSubview:titleLabel];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(160), KSCALE_WIDTH(335), KSCALE_WIDTH(50))];
    self.titleView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.titleView withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.titleView];
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(10), 0, KSCALE_WIDTH(315), KSCALE_WIDTH(50))];
    self.titleTextField.placeholder = @"请输入商品名称";
    self.titleTextField.textColor = KTEXT_COLOR;
    self.titleTextField.font = K_14_FONT;
    [QCClassFunction filletImageView:self.titleTextField withRadius:KSCALE_WIDTH(5)];
    [self.titleView addSubview:self.titleTextField];

    
    
    UILabel * describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(210), KSCALE_WIDTH(335), KSCALE_WIDTH(40))];
    describeLabel.text = @"输入商品描述（限200字）:";
    describeLabel.textColor = KTEXT_COLOR;
    describeLabel.font = K_12_FONT;
    [self.scrollView addSubview:describeLabel];
    
    self.describeView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(250), KSCALE_WIDTH(335), KSCALE_WIDTH(90))];
    self.describeView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.describeView withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.describeView];
    
    self.describeTextView = [[UITextView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5), 0, KSCALE_WIDTH(325), KSCALE_WIDTH(50))];
    self.describeTextView.textColor = KTEXT_COLOR;
    self.describeTextView.font = K_14_FONT;
    [QCClassFunction filletImageView:self.describeTextView withRadius:KSCALE_WIDTH(5)];
    [self.describeView addSubview:self.describeTextView];
    
    UILabel * placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"输入商品描述，转手原因，新旧程度，入手渠道等";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [QCClassFunction stringTOColor:@"#cacaca"];
    [placeHolderLabel sizeToFit];
    [self.describeTextView addSubview:placeHolderLabel];
 
    // same font
    placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
    [self.describeTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    
    
    UILabel * introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(340), KSCALE_WIDTH(335), KSCALE_WIDTH(40))];
    introduceLabel.text = @"添加商品介绍图片:";
    introduceLabel.textColor = KTEXT_COLOR;
    introduceLabel.font = K_12_FONT;
    [self.scrollView addSubview:introduceLabel];
    
    self.introduceView = [[QCIntroduceView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(380), KSCALE_WIDTH(335), KSCALE_WIDTH(90))];
    self.introduceView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.introduceView withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.introduceView];
    
    
    self.goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(470), KSCALE_WIDTH(335), KSCALE_WIDTH(40))];
    self.goodsLabel.text = @"商品设置:";
    self.goodsLabel.textColor = KTEXT_COLOR;
    self.goodsLabel.font = K_12_FONT;
    [self.scrollView addSubview:self.goodsLabel];
    
    self.goodsView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(510), KSCALE_WIDTH(335), KSCALE_WIDTH(382))];
    self.goodsView.backgroundColor = KBACK_COLOR;
    [QCClassFunction filletImageView:self.goodsView withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.goodsView];
    
    
    NSArray * titleArr = @[@"发货地",@"售价",@"库存",@"分类",@"包邮全新",@"首页推荐",@"首页秒杀"];
    for (NSInteger i = 0; i <= 6; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), i * KSCALE_WIDTH(55), KSCALE_WIDTH(60), KSCALE_WIDTH(54))];
        label.text = titleArr[i];
        label.textColor = [QCClassFunction stringTOColor:@"#333333"];
        label.font = K_12_FONT;
        [self.goodsView addSubview:label];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(54) + KSCALE_WIDTH(55) * i, KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.goodsView addSubview:lineView];
    }
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(0), KSCALE_WIDTH(280), KSCALE_WIDTH(54))];
    self.addressLabel.text = @"请选择发货地址";
    self.addressLabel.textColor = [QCClassFunction stringTOColor:@"#cacaca"];
    self.addressLabel.font = K_14_FONT;
    [self.goodsView addSubview:self.addressLabel];
    
    UIButton * addressButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(0), KSCALE_WIDTH(280), KSCALE_WIDTH(54))];
    addressButton.backgroundColor = [UIColor clearColor];
    [addressButton addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsView addSubview:addressButton];
    
    UIImageView * addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(309), KSCALE_WIDTH(19), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    addressImageView.image = [UIImage imageNamed:@"leftarrow"];
    addressImageView.contentMode = UIViewContentModeCenter;
    [self.goodsView addSubview:addressImageView];
    
    
    
    self.lowPriceField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(55 ), KSCALE_WIDTH(60), KSCALE_WIDTH(54))];
    self.lowPriceField.placeholder = @"现价";
    self.lowPriceField.textColor = KTEXT_COLOR;
    self.lowPriceField.font = K_14_FONT;
    self.lowPriceField.textAlignment = NSTextAlignmentCenter;
    self.lowPriceField.keyboardType = UIKeyboardTypeNumberPad;
    [self.goodsView addSubview:self.lowPriceField];
    
    UILabel * lowToHighLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(140), KSCALE_WIDTH(55), KSCALE_WIDTH(60), KSCALE_WIDTH(54))];
    lowToHighLabel.text = @"至";
    lowToHighLabel.textColor = [QCClassFunction stringTOColor:@"#333333"];
    lowToHighLabel.font = K_14_FONT;
    lowToHighLabel.textAlignment = NSTextAlignmentCenter;
    [self.goodsView addSubview:lowToHighLabel];
    
    self.highPriceTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(55), KSCALE_WIDTH(60), KSCALE_WIDTH(54))];
    self.highPriceTextField.placeholder = @"原价";
    self.highPriceTextField.textColor = KTEXT_COLOR;
    self.highPriceTextField.font = K_14_FONT;
    self.highPriceTextField.textAlignment = NSTextAlignmentCenter;
    self.highPriceTextField.keyboardType = UIKeyboardTypeNumberPad;

    [self.goodsView addSubview:self.highPriceTextField];
    
    
    self.numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(110), KSCALE_WIDTH(60), KSCALE_WIDTH(54))];
    self.numberTextField.placeholder = @"输入库存";
    self.numberTextField.textColor = KTEXT_COLOR;
    self.numberTextField.font = K_14_FONT;
    self.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numberTextField.textAlignment = NSTextAlignmentCenter;

    [self.goodsView addSubview:self.numberTextField];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(165), KSCALE_WIDTH(280), KSCALE_WIDTH(54))];
    self.classLabel.text = @"选择分类";
    self.classLabel.textColor = [QCClassFunction stringTOColor:@"#cacaca"];
    self.classLabel.font = K_14_FONT;
    [self.goodsView addSubview:self.classLabel];
    
    UIButton * classButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(165), KSCALE_WIDTH(280), KSCALE_WIDTH(54))];
    classButton.backgroundColor = [UIColor clearColor];
    [classButton addTarget:self action:@selector(classAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsView addSubview:classButton];
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(309), KSCALE_WIDTH(184), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    imageView.image = [UIImage imageNamed:@"leftarrow"];
    imageView.contentMode = UIViewContentModeCenter;
    [self.goodsView addSubview:imageView];

    
    self.freeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(185), KSCALE_WIDTH(232), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    [self.freeButton setImage:[UIImage imageNamed:@"unselected_p"] forState:UIControlStateNormal];
    [self.freeButton setImage:[UIImage imageNamed:@"selected_p"] forState:UIControlStateSelected];
    [self.freeButton addTarget:self action:@selector(freeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsView addSubview:self.freeButton];
    
    UILabel * freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(215), KSCALE_WIDTH(220), KSCALE_WIDTH(40), KSCALE_WIDTH(54))];
    freeLabel.text = @"包邮";
    freeLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    freeLabel.font = K_12_FONT;
    [self.goodsView addSubview:freeLabel];
    
    self.unoldButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(255), KSCALE_WIDTH(232), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
    [self.unoldButton setImage:[UIImage imageNamed:@"unselected_p"] forState:UIControlStateNormal];
    [self.unoldButton setImage:[UIImage imageNamed:@"selected_p"] forState:UIControlStateSelected];
    [self.unoldButton addTarget:self action:@selector(unoldAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goodsView addSubview:self.unoldButton];
    
    UILabel * newLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(285), KSCALE_WIDTH(220), KSCALE_WIDTH(40), KSCALE_WIDTH(54))];
    newLabel.text = @"全新";
    newLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    newLabel.font = K_12_FONT;
    [self.goodsView addSubview:newLabel];
    

    
    
    
    self.recommendedLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(275), KSCALE_WIDTH(280), KSCALE_WIDTH(54))];
    self.recommendedLabel.text = @"未开通服务";
    self.recommendedLabel.textColor = [QCClassFunction stringTOColor:@"#cacaca"];
    self.recommendedLabel.font = K_14_FONT;
    [self.goodsView addSubview:self.recommendedLabel];
    
    self.recommendedSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(287.5), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
    self.recommendedSwitch.onTintColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.recommendedSwitch.tintColor = [UIColor greenColor];
    self.recommendedSwitch.on = NO;
    self.recommendedSwitch.thumbTintColor = [UIColor whiteColor];
    self.recommendedSwitch.userInteractionEnabled = NO;
    [self.goodsView addSubview:self.recommendedSwitch];

    
    
    self.killLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(330), KSCALE_WIDTH(280), KSCALE_WIDTH(54))];
    self.killLabel.text = @"VIP专享";
    self.killLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
    self.killLabel.font = K_14_FONT;
    [self.goodsView addSubview:self.killLabel];
    
    self.killSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(342.5), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
    self.killSwitch.onTintColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.killSwitch.tintColor = [UIColor greenColor];
    self.killSwitch.on = NO;
    self.killSwitch.thumbTintColor = [UIColor whiteColor];
    self.killSwitch.userInteractionEnabled = NO;
    [self.goodsView addSubview:self.killSwitch];
    
    
    
    self.markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(60), KSCALE_WIDTH(913) , KSCALE_WIDTH(240), KSCALE_WIDTH(14))];
    self.markLabel.font = KSCALE_FONT(14);
    self.markLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.markLabel.textAlignment = NSTextAlignmentCenter;
    self.markLabel.text = @"已阅读并同意《闲置物品交易协议》";
    [self.scrollView addSubview:self.markLabel];
    
    self.agreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(910), KSCALE_WIDTH(20), KSCALE_WIDTH(20))];
    self.agreeImageView.image = [UIImage imageNamed:@"unselected_p"];
    [self.scrollView addSubview: self.agreeImageView];
    
    
    self.agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(900), KSCALE_WIDTH(300), KSCALE_WIDTH(34))];
    self.agreeButton.backgroundColor = KCLEAR_COLOR;
    [self.agreeButton addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.agreeButton];
    
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(950), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
    self.sureButton.userInteractionEnabled = NO;
    [self.sureButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(5)];
    [self.scrollView addSubview:self.sureButton];
    
    
    self.scrollView.contentSize = CGSizeMake(KSCALE_WIDTH(375), KSCALE_WIDTH(1100));


}


- (void)upSizeFrameWithHight:(CGFloat)hight {
    
    self.goodsLabel.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(470) +  hight, KSCALE_WIDTH(335), KSCALE_WIDTH(40));
    self.goodsView.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(510) + hight, KSCALE_WIDTH(335), KSCALE_WIDTH(382));
    self.agreeImageView.frame = CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(910) + hight, KSCALE_WIDTH(20), KSCALE_WIDTH(20));
    self.markLabel.frame = CGRectMake(KSCALE_WIDTH(60), KSCALE_WIDTH(913) + hight, KSCALE_WIDTH(240), KSCALE_WIDTH(14));
    self.agreeButton.frame = CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(900) + hight, KSCALE_WIDTH(300), KSCALE_WIDTH(34));
    self.sureButton.frame = CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(950) + hight, KSCALE_WIDTH(335), KSCALE_WIDTH(52));
    self.scrollView.contentSize = CGSizeMake(KSCALE_WIDTH(375), KSCALE_WIDTH(1100) + hight);

}

- (void)sureAction:(UIButton *)sender {
    
    
    //  content 商品描述情况  self.describeTextView.text
    //  delivery_type 配送方式（1自提，2包邮，3不包邮）    self.freeStr
    //  detail_img   详情图片
    //  first_img   滚动图
    //  goods_price 现价  self.lowPriceField.text

    //  is_new 1-是，0-不是 self.unoldStr
    //  is_query 是否加入搜索（0-否 1-是
    //  is_spike 开启秒杀 1-开启 0-不开启
    //  logistics_price 物流金额
    //  name    物品名称    self.titleTextField.text
    //  original_price 原价   self.highPriceTextField.text
    //  ship_address  发货地址      self.addressLabel.text

    //  token
    //  type_id  分类 self.classId
    if (self.rollingView.imageArr.count == 0) {
        [QCClassFunction showMessage:@"请上传封面图" toView:self.view];
        return;
    }
    
    if ([self.titleTextField.text isEqualToString:@""] || self.titleTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入商品名称" toView:self.view];
        return;
    }
    if ([self.describeTextView.text isEqualToString:@""] || self.describeTextView.text == nil) {
        [QCClassFunction showMessage:@"请输入商品描述" toView:self.view];
        return;
    }
    if (self.introduceView.imageArr.count == 0) {
        [QCClassFunction showMessage:@"请添加商品介绍图" toView:self.view];
        return;
    }
    if ([self.addressStr isEqualToString:@""] || self.addressStr == nil) {
        [QCClassFunction showMessage:@"请选择发货地址" toView:self.view];
        return;
    }
    if ([self.lowPriceField.text isEqualToString:@""] || self.lowPriceField.text == nil) {
        [QCClassFunction showMessage:@"请输入售价" toView:self.view];
        return;
    }
    if ([self.highPriceTextField.text isEqualToString:@""] || self.highPriceTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入原价" toView:self.view];
        return;
    }
    if ([self.numberTextField.text isEqualToString:@""] || self.numberTextField.text == nil) {
        [QCClassFunction showMessage:@"请输入库存数" toView:self.view];
        return;
    }
    if ([self.classId isEqualToString:@""] || self.classId == nil) {
        [QCClassFunction showMessage:@"请选择商品分类" toView:self.view];
        return;
    }
    
    
    self.rollingViewUrl = [self.rollingView.imageArr componentsJoinedByString:@","];
    self.rollingViewUrl = [NSString stringWithFormat:@"%@,",self.rollingViewUrl];
    self.introduceViewUrl =[self.introduceView.imageArr componentsJoinedByString:@","];
    self.introduceViewUrl = [NSString stringWithFormat:@"%@,",self.introduceViewUrl];

    

    
    [self UPDATA];
    
}

- (void)agreeAction:(UIButton *)sender {
    if (sender.selected) {
        self.agreeImageView.image = [UIImage imageNamed:@"unselected_p"];
        sender.selected = NO;

        self.sureButton.selected = NO;
        self.sureButton.userInteractionEnabled = NO;
        self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#E4E4E4"];
        

    }else{
        self.agreeImageView.image = [UIImage imageNamed:@"selected_p"];
        sender.selected = YES;

        self.sureButton.selected = YES;
        self.sureButton.userInteractionEnabled = YES;
        self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];

    }
    




}

- (void)classAction:(UIButton *)sender {
    QCClassificationViewcontroller * classificationViewcontroller = [[QCClassificationViewcontroller alloc] init];
    classificationViewcontroller.hidesBottomBarWhenPushed = YES;
    classificationViewcontroller.title = @"选择分类";
    classificationViewcontroller.status = @"0";
    classificationViewcontroller.classBlock = ^(NSString *city, NSString *classId) {
        self.classLabel.text = city;
        self.classLabel.textColor = [UIColor blackColor];
        self.classId = classId;
    };
    [self.navigationController pushViewController:classificationViewcontroller animated:YES];
}


- (void)addressAction:(UIButton *)sender {
    
    UIView * backView = [[QCClassFunction shared] createBackView];
    self.pickView = [[QCPickVIew alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(250), KSCALE_WIDTH(375), KSCALE_WIDTH(250))];
    [backView addSubview:self.pickView];
}


- (void)freeAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        self.freeStr = @"3";
        self.logistics_price = @"5";

    }else{
        sender.selected = YES;
        self.freeStr = @"2";
        self.logistics_price = @"0";

    }
}

- (void)unoldAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        self.unoldStr = @"0";
    }else{
        sender.selected = YES;
        self.unoldStr = @"1";

    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {

    
    if([touch.view isDescendantOfView:self.rollingView.collectionView] ||[touch.view isDescendantOfView:self.introduceView.collectionView]){
        return NO;
    }

   return YES;

}


#pragma mark - GETDATA
- (void)UPDATA {
    //  content 商品描述情况  self.describeTextView.text
    //  delivery_type 配送方式（1自提，2包邮，3不包邮）    self.freeStr
    //  detail_img   详情图片
    //  first_img   滚动图
    //  goods_price 现价  self.lowPriceField.text

    //  is_new 1-是，0-不是 self.unoldStr
    //  is_query 是否加入搜索（0-否 1-是
    //  is_spike 开启秒杀 1-开启 0-不开启
    //  logistics_price 物流金额
    //  name    物品名称    self.titleTextField.text
    //  original_price 原价   self.highPriceTextField.text
    //  ship_address  发货地址      self.addressLabel.text

    //  token
    //  type_id  分类 self.classId



    
    NSString * str = [NSString stringWithFormat:@"content=%@&delivery_type=%@&detail_img=%@&first_img=%@&goods_price=%@&id=&is_new=%@&is_query=%@&is_spike=%@&logistics_price=%@&name=%@&original_price=%@&ship_address=%@&stock=%@&token=%@&type_id=%@&uid=%@",self.describeTextView.text,self.freeStr,self.introduceViewUrl,self.rollingViewUrl,self.lowPriceField.text,self.unoldStr,self.is_query,self.is_spike,self.logistics_price,self.titleTextField.text,self.highPriceTextField.text,self.addressLabel.text,self.numberTextField.text,K_TOKEN,self.classId,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"content":self.describeTextView.text,@"delivery_type":self.freeStr,@"detail_img":self.introduceViewUrl,@"first_img":self.rollingViewUrl,@"goods_price":self.lowPriceField.text,@"id":@"",@"is_new":self.unoldStr,@"is_query":self.is_query,@"is_spike":self.is_spike,@"logistics_price":self.logistics_price,@"name":self.titleTextField.text,@"original_price":self.highPriceTextField.text,@"ship_address":self.addressLabel.text,@"stock":self.numberTextField.text,@"token":K_TOKEN,@"type_id":self.classId,@"uid":K_UID?K_UID:@""};
    
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/addgoods" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"status"] intValue] == 1) {
            [QCClassFunction showMessage:@"发布成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}


- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"id=%@",self.goodsId];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"id":self.goodsId};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/info" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        

        
        if ([responseObject[@"status"] intValue] == 1) {
            QCGoodsDetailsModel * model = [[QCGoodsDetailsModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
            [self.dataArr addObject:model];
            
            for (NSDictionary * dic in responseObject[@"data"][@"img"]) {
                QCImageDetailsModel * model = [[QCImageDetailsModel alloc] initWithDictionary:dic error:nil];
                model.cellH = [NSString stringWithFormat:@"%f",[QCClassFunction getImageSizeWithURL:model.goods_img].height * KSCALE_WIDTH(355) / [QCClassFunction getImageSizeWithURL:model.goods_img].width];
                
                
                
                [self.imageArr addObject:model];
            }
            
            for (NSDictionary * dic in responseObject[@"data"][@"dimg"]) {
                QCImageDetailsModel * model = [[QCImageDetailsModel alloc] initWithDictionary:dic error:nil];
                model.cellH = [NSString stringWithFormat:@"%f",[QCClassFunction getImageSizeWithURL:model.goods_img].height * KSCALE_WIDTH(355) / [QCClassFunction getImageSizeWithURL:model.goods_img].width];

                
                
                [self.imageDetailsArr addObject:model];
            }
            


            [self fillView];
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)fillView {
    //  content 商品描述情况  self.describeTextView.text
    //  delivery_type 配送方式（1自提，2包邮，3不包邮）    self.freeStr
    //  detail_img   详情图片
    //  first_img   滚动图
    //  goods_price 现价  self.lowPriceField.text

    //  is_new 1-是，0-不是 self.unoldStr
    //  is_query 是否加入搜索（0-否 1-是
    //  is_spike 开启秒杀 1-开启 0-不开启
    //  logistics_price 物流金额
    //  name    物品名称    self.titleTextField.text
    //  original_price 原价   self.highPriceTextField.text
    //  ship_address  发货地址      self.addressLabel.text

    //  token
    //  type_id  分类 self.classId
    
    QCGoodsDetailsModel * model = [self.dataArr firstObject];
    self.describeTextView.text = model.content;
    self.lowPriceField.text = model.goods_price;
    self.titleTextField.text = model.name;
    self.highPriceTextField.text = model.original_price;
    self.addressLabel.text = model.ship_address;
    self.addressLabel.textColor = KTEXT_COLOR;
    self.numberTextField.text = model.num;
    self.addressLabel.text = model.ship_address;
    self.classLabel.text = model.category_name;

}



@end
