//
//  QCOrderDetailsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOrderDetailsViewController.h"

@interface QCOrderDetailsViewController ()

@property (nonatomic, strong) UILabel * statusLabel;

@property (nonatomic, strong) UIView * messageView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * freeLabel;
@property (nonatomic, strong) UILabel * unoldLabel;

@property (nonatomic, strong) UIView * statusView;
@property (nonatomic, strong) UIView * personMessageView;
@property (nonatomic, strong) UIView * deliveryView;

@end

@implementation QCOrderDetailsViewController

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
    [self createView];
    [self createStatusView];
    [self createMessageView];
    [self createDeliveryView];
    [self filView];

}

- (void)resignAction {
    [UIView animateWithDuration:0.25 animations:^{

        self.view.frame = CGRectMake(0, KNavHight, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight);



    }];

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
    
    
    switch ([self.model.order_status intValue]) {
        case 0:
                
            break;
            
        case 1:
                
            break;
        case 2:

            self.statusLabel.text = @"待发货";


            break;
        case 3:
           
            self.statusLabel.text = @"待收货";
            break;
        case 4:
          
            self.statusLabel.text = @"交易成功";

            break;
        case 5:
          
            self.statusLabel.text = @"订单已关闭";

            break;
        case 6:
        
            self.statusLabel.text = @"退款中";

            break;
        default:
            break;
    }
    
    
}

- (void)initUI {

    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"订单详情";
   
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

- (void)createStatusView {
    self.statusView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(115), KSCALE_WIDTH(375), KSCALE_WIDTH(60))];
    self.personMessageView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.view addSubview:self.statusView];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(22), KSCALE_WIDTH(6), KSCALE_WIDTH(16))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.statusView addSubview:lineView];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(22), KSCALE_WIDTH(100), KSCALE_WIDTH(16))];
    messageLabel.text = @"订单状态";
    messageLabel.font = K_16_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.statusView addSubview:messageLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(22), KSCALE_WIDTH(155), KSCALE_WIDTH(16))];
    self.statusLabel.text = @"已发货";
    self.statusLabel.font = K_14_FONT;
    self.statusLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    [self.statusView addSubview:self.statusLabel];
    
    UIView * messageLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(59), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
    messageLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.statusView addSubview:messageLineView];
}

- (void)createMessageView {
    
    self.personMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(175), KSCALE_WIDTH(375), KSCALE_WIDTH(225))];
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
    
    
    NSArray * titleArr = [[NSArray alloc] init];
    NSArray * messageArr = [[NSArray alloc] init];
    if ([self.model.order_status isEqualToString:@"3"] || [self.model.order_status isEqualToString:@"4"]) {
        
            titleArr = @[@"收货人",@"联系电话",@"中通快递",@"收货地址"];
            messageArr = @[self.model.username,self.model.usermobile,self.model.order_no,self.model.address];
    }else{
        titleArr = @[@"收货人",@"联系电话",@"收货地址"];
        messageArr = @[self.model.username,self.model.usermobile,self.model.address];
    }
    

    for (NSInteger i = 0; i < titleArr.count; i++) {
        
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
        
        if (i == 3) {
            messageLabel.frame = CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(235), KSCALE_WIDTH(35));
        }
    }
    
    UIView * messageLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(224), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
    messageLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.personMessageView addSubview:messageLineView];

}

- (void)createDeliveryView  {
    self.deliveryView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(400), KSCALE_WIDTH(375), KSCALE_WIDTH(160))];
    self.deliveryView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.view addSubview:self.deliveryView];
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(30), KSCALE_WIDTH(6), KSCALE_WIDTH(16))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.deliveryView addSubview:lineView];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(30), KSCALE_WIDTH(100), KSCALE_WIDTH(16))];
    messageLabel.text = @"订单信息";
    messageLabel.font = K_16_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.deliveryView addSubview:messageLabel];
    
    NSArray * titleArr = @[@"买家昵称",@"订单编号",@"支付时间",@"发货时间"];
    NSArray * messageArr = @[self.model.nick,self.model.order_no,self.model.create_time,self.model.delivery_time?self.model.delivery_time:@""];

    for (NSInteger i = 0; i < 4; i++) {
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(80), KSCALE_WIDTH(15))];
        label.text = titleArr[i];
        label.font = K_14_FONT;
        label.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.deliveryView addSubview:label];
        
        UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(235), KSCALE_WIDTH(15))];
        messageLabel.text = messageArr[i];
        messageLabel.font = K_14_FONT;
        messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        messageLabel.numberOfLines = 0;
        [self.deliveryView addSubview:messageLabel];
        
        if (i == 3) {
            messageLabel.frame = CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(70) + KSCALE_WIDTH(35) * i, KSCALE_WIDTH(235), KSCALE_WIDTH(35));
        }
    }
    

}





@end
