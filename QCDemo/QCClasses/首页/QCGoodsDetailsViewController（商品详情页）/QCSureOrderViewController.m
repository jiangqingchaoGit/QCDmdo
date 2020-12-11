//
//  QCSureOrderViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSureOrderViewController.h"
#import "QCSureOrderCell.h"
#import "QCPayView.h"
#import "QCAddressListsViewController.h"
@interface QCSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString * areaStr;
@property (nonatomic, strong) NSString * addressStr;
@property (nonatomic, strong) NSString * nameStr;
@property (nonatomic, strong) NSString * mobileStr;
@property (nonatomic, strong) NSString * balanceStr;

@property (nonatomic, strong) UIButton * selectButton;


@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) UILabel * needLabel;

@property (nonatomic, strong) UIView * messageView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UILabel * freeLabel;
@property (nonatomic, strong) UILabel * unoldLabel;

@property (nonatomic, strong) UIView * personMessageView;
@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, strong) UILabel * locationLabel;
@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) QCPayView * payView;

@end

@implementation QCSureOrderViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSMutableArray new];
    [self GETDATA];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self createFooterView];
    [self filView];
}


#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
}


- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets=NO;
        
    }
    [self.tableView registerClass:[QCSureOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
}

- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(286))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    [self createView];
    [self createMessageView];
}


- (void)createView {
    
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(130))];
    self.messageView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.headerView addSubview:self.messageView];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(90))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(5)];
    [self.messageView addSubview:self.headerImageView];

    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(15), KSCALE_WIDTH(225), KSCALE_WIDTH(55))];
//    self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";

    self.contentLabel.font = K_14_FONT;
    self.contentLabel.textColor = KTEXT_COLOR;
    self.contentLabel.numberOfLines = 0;
    [self.messageView addSubview:self.contentLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(75), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
//    self.priceLabel.text = @"¥3700";

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

- (void)createMessageView {
    
    self.personMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(130), KSCALE_WIDTH(375), KSCALE_WIDTH(156))];
    self.personMessageView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.headerView addSubview:self.personMessageView];
    

    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(6), KSCALE_WIDTH(16))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.personMessageView addSubview:lineView];
    
    UILabel * messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(15), KSCALE_WIDTH(100), KSCALE_WIDTH(16))];
    messageLabel.text = @"收货地址";
    messageLabel.font = K_16_FONT;
    messageLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.personMessageView addSubview:messageLabel];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(349), KSCALE_WIDTH(15), KSCALE_WIDTH(16), KSCALE_WIDTH(16))];
    imageView.image = [UIImage imageNamed:@"leftarrow"];
    imageView.contentMode = UIViewContentModeCenter;
    [self.personMessageView addSubview:imageView];

    
    
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(40), KSCALE_WIDTH(325), KSCALE_WIDTH(35))];
    self.locationLabel.font = K_16_BFONT;
    self.locationLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.personMessageView addSubview:self.locationLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(75), KSCALE_WIDTH(325), KSCALE_WIDTH(15))];
    self.nameLabel.text = @"思绪云骞 186****0380";
    self.nameLabel.font = K_14_FONT;
    self.nameLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.nameLabel.numberOfLines = 0;
    [self.personMessageView addSubview:self.nameLabel];

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(105))];
    button.backgroundColor = KCLEAR_COLOR;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.personMessageView addSubview:button];
    
    
    UIView * messageLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(105), KSCALE_WIDTH(375), KSCALE_WIDTH(5))];
    messageLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.personMessageView addSubview:messageLineView];
    
    
    
    UIView * payLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(125), KSCALE_WIDTH(6), KSCALE_WIDTH(16))];
    payLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.personMessageView addSubview:payLineView];
    
    UILabel * payLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(125), KSCALE_WIDTH(100), KSCALE_WIDTH(16))];
    payLabel.text = @"支付方式";
    payLabel.font = K_16_FONT;
    payLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.personMessageView addSubview:payLabel];
    
    
}


- (void)createFooterView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KTabHight - KSCALE_WIDTH(11) - KNavHight, KSCALE_WIDTH(375),  KTabHight + KSCALE_WIDTH(11))];
    self.footerView.backgroundColor = KBACK_COLOR;
    [self.view addSubview:self.footerView];
    
    self.needLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(120), KSCALE_WIDTH(60))];
    self.needLabel.text = [NSString stringWithFormat:@"¥%@",self.model.goods_price];
    self.needLabel.font = K_20_BFONT;
    self.needLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
    [self.footerView addSubview:self.needLabel];
    
    
    self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(225), KSCALE_WIDTH(9), KSCALE_WIDTH(135), KSCALE_WIDTH(42))];
    self.sureButton.titleLabel.font = K_16_FONT;
    self.sureButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.sureButton setTitle:@"付款" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sureButton withRadius:KSCALE_WIDTH(5)];
    [self.footerView addSubview:self.sureButton];
    
}


- (void)sureAction:(UIButton *)sender {
    
    UIView * backView = [[QCClassFunction shared] createBackView];


    self.payView = [[QCPayView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCREEN_HEIGHT / 2.0 - KSCALE_WIDTH(180), KSCALE_WIDTH(315), KSCALE_WIDTH(315))];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{@"red_price":self.model.goods_price,@"method":@"1",@"gid":self.model.id,@"address":self.addressStr,@"username":self.nameStr,@"usermobile":self.mobileStr}];
    self.payView.messageDic = dic;
    self.payView.type = @"5";
    [self.payView initUI];
    [backView addSubview:self.payView];
    
    
    
}

- (void)buttonAction:(UIButton *)sender {
    //  选择地址
    
    QCAddressListsViewController * addressListsViewController = [[QCAddressListsViewController alloc] init];
    addressListsViewController.hidesBottomBarWhenPushed = YES;
    addressListsViewController.status = @"1";
    addressListsViewController.addressBlock = ^(NSDictionary *addressDic) {
        self.locationLabel.text = addressDic[@"address"];
        self.areaStr = addressDic[@"area"];
        self.addressStr = addressDic[@"address"];
        self.nameStr = addressDic[@"name"];
        self.mobileStr = addressDic[@"mobile"];
        self.nameLabel.text = [NSString stringWithFormat:@"%@    %@",self.nameStr,self.mobileStr];


    };
    [self.navigationController pushViewController:addressListsViewController animated:YES];
}

- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"gid=%@&token=%@&uid=%@",self.model.id,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"gid":self.model.id,@"token":K_TOKEN,@"uid":K_UID};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/order/verifyorder" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        

        
        if ([responseObject[@"status"] intValue] == 1) {
            self.nameLabel.text = [NSString stringWithFormat:@"%@    %@",responseObject[@"data"][@"address"][@"name"],responseObject[@"data"][@"address"][@"mobile"]];
            self.locationLabel.text =  responseObject[@"data"][@"address"][@"address"];
            
            self.areaStr = [NSString stringWithFormat:@"%@%@%@",responseObject[@"data"][@"address"][@"province_name"],responseObject[@"data"][@"address"][@"city_name"],responseObject[@"data"][@"address"][@"area_name"]];
            self.addressStr = responseObject[@"data"][@"address"][@"address"];
            self.nameStr = responseObject[@"data"][@"address"][@"name"];
            self.mobileStr = responseObject[@"data"][@"address"][@"mobile"];
            self.balanceStr = responseObject[@"data"][@"balance"];

            
            for (NSDictionary * dic in responseObject[@"data"][@"card"]) {
                QCCardModel * model = [[QCCardModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
                
            }
            [self.tableView reloadData];
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return KSCALE_WIDTH(52);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSureOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.chooseButton.hidden = NO;

    if (indexPath.row == 0) {
        cell.payLabel.text = [NSString stringWithFormat:@"余额支付：%@",self.balanceStr];
    }else if (indexPath.row == self.dataArr.count + 1) {
        cell.payLabel.text = @"添加银行卡 +";
        cell.chooseButton.hidden = YES;

    }else{
        QCCardModel * model = self.dataArr[indexPath.row - 1];

        [cell fillCellWithModel:model];
    }
    
    if (cell.chooseButton.selected) {
        self.selectButton = cell.chooseButton;
    }
    [cell.chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)chooseAction:(UIButton *)sender  {
    self.selectButton.selected = NO;

    if (sender.selected == YES) {
    }else {
        sender.selected = YES;
        self.selectButton = sender;

    }
        
}



@end
