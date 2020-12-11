//
//  QCGoodsDetailsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGoodsDetailsViewController.h"
#import "QCNavigationBar.h"
#import "QCGoodsDetailsModel.h"
#import "QCBlindBuyViewController.h"


//  确认订单界面
#import "QCSureOrderViewController.h"
/*
 *  滚动切换视图
 */
#import "GKCycleScrollView.h"
#import "GKPageControl.h"
#import "QCGoodsDetailsCell.h"
#import "QCPayView.h"
#import "QCRecommendedCell.h"

#import "QCStoresViewController.h"
@interface QCGoodsDetailsViewController ()<UIScrollViewDelegate,GKCycleScrollViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;

@property (nonatomic, strong) QCNavigationBar * navigationBar;
@property (nonatomic, strong) GKCycleScrollView * cycleScrollView;
@property (nonatomic, strong) GKPageControl * pageControl;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * goodsArr;

@property (nonatomic, strong) NSMutableArray * imageArr;
@property (nonatomic, strong) NSMutableArray * imageDetailsArr;

@property (nonatomic, strong) UIView * messageView;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * freeLabel;
@property (nonatomic, strong) UILabel * unoldLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) UILabel * onsaleLabel;
@property (nonatomic, strong) UIView * salelineView;

@property (nonatomic, strong) UIButton * storeButton;


@property (nonatomic, strong) UIView * detailslineView;

@property (nonatomic, strong) UIView * detailsView;
@property (nonatomic, strong) UILabel * introduceLabel;

@property (nonatomic, strong) UIView * footerView;


@property (nonatomic, strong) UIButton * collectionButton;
@property (nonatomic, strong) UIButton * chatButton;
@property (nonatomic, strong) UIButton * buyButton;
@property (nonatomic, strong) QCPayView * payView;



@end

@implementation QCGoodsDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    self.goodsArr = [[NSMutableArray alloc] init];

    self.imageArr = [[NSMutableArray alloc] init];
    self.imageDetailsArr = [[NSMutableArray alloc] init];

    [self createTableView];
    [self createHeaderView];
    [self createFooterView];
    [self initUI];


    [self GETDATA];

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KBACK_COLOR;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets=NO;
        
    }
    [self.tableView registerClass:[QCGoodsDetailsCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QCRecommendedCell class] forCellReuseIdentifier:@"recommendedCell"];

    
    [self.view addSubview:self.tableView];
}

- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(700))];
    self.tableView.tableHeaderView = self.headerView;

    [self bannerView];
    [self createMessageView];
    [self createDetailsView];
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;

    
    self.navigationBar = [[QCNavigationBar alloc] init];
    self.navigationBar.backColor = [UIColor whiteColor];
    self.navigationBar.titleLabel.text = @"商品详情";

    [self.navigationBar.rightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar.rightButton setImage:[UIImage imageNamed:@"share_s"] forState:UIControlStateNormal];
    [self.navigationBar.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.navigationBar];
    [self.navigationBar setNav];
    [self.navigationBar hiddenNav];
}

- (void)bannerView {
    self.cycleScrollView = [[GKCycleScrollView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCREEN_WIDTH , KSCALE_WIDTH(320))];
    self.cycleScrollView.backgroundColor = [UIColor clearColor];
    self.cycleScrollView.dataSource = (id)self;
    self.cycleScrollView.delegate = (id)self;
    self.cycleScrollView.isChangeAlpha = NO;
    self.cycleScrollView.isAutoScroll = YES;
    self.cycleScrollView.isInfiniteLoop = YES;
    self.cycleScrollView.leftRightMargin = KSCALE_WIDTH(0);
    [self.headerView addSubview:self.cycleScrollView];
    [self.cycleScrollView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.cycleScrollView);
        make.bottom.mas_equalTo(KSCALE_WIDTH(-10));
        make.height.mas_equalTo(KSCALE_WIDTH(15));
    }];
    
}

- (void)createMessageView {
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(320), KSCALE_WIDTH(375), KSCALE_WIDTH(255))];
    self.messageView.backgroundColor = KBACK_COLOR;
    [self.headerView addSubview:self.messageView];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
//    self.priceLabel.text = @"¥3300-¥3600";
    self.priceLabel.font = K_20_BFONT;
    self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
    [self.messageView addSubview:self.priceLabel];
    
    
    
    self.freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(21), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
//    self.freeLabel.text = @"包邮";
    self.freeLabel.font = K_10_FONT;
    self.freeLabel.layer.borderWidth = KSCALE_WIDTH(1);
    self.freeLabel.textAlignment = NSTextAlignmentCenter;
    self.freeLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
    self.freeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [QCClassFunction filletImageView:self.freeLabel withRadius:KSCALE_WIDTH(4)];
    [self.messageView addSubview:self.freeLabel];

    self.unoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(320), KSCALE_WIDTH(21), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
//    self.unoldLabel.text = @"全新";
    self.unoldLabel.font = K_10_FONT;
    self.unoldLabel.layer.borderWidth = KSCALE_WIDTH(1);
    self.unoldLabel.textAlignment = NSTextAlignmentCenter;
    self.unoldLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
    self.unoldLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [QCClassFunction filletImageView:self.unoldLabel withRadius:KSCALE_WIDTH(4)];
    [self.messageView addSubview:self.unoldLabel];

    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(50), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
//    self.addressLabel.text = @"重庆市-渝北区";
    self.addressLabel.font = K_12_FONT;
    self.addressLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.messageView addSubview:self.addressLabel];

    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(80), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
//    self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
    self.contentLabel.font = K_14_FONT;
    self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.contentLabel.numberOfLines = 0;
    [self.messageView addSubview:self.contentLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(155), KSCALE_WIDTH(375), KSCALE_WIDTH(5))];
    self.lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.messageView addSubview:self.lineView];

    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(179), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.messageView addSubview:self.headerImageView];
    
    self.nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(179), KSCALE_WIDTH(100), KSCALE_WIDTH(52))];
//    self.nickLabel.text = @"思绪云骞";
    self.nickLabel.font = K_16_FONT;
    self.nickLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.messageView addSubview:self.nickLabel];
    
    self.salelineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(239), KSCALE_WIDTH(165), KSCALE_WIDTH(1), KSCALE_WIDTH(80))];
    self.salelineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.messageView addSubview:self.salelineView];


    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(240), KSCALE_WIDTH(179), KSCALE_WIDTH(135), KSCALE_WIDTH(32))];
//    self.numberLabel.text = @"13";
    self.numberLabel.font = K_18_BFONT;
    self.numberLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.messageView addSubview:self.numberLabel];
    
    self.onsaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(240), KSCALE_WIDTH(211), KSCALE_WIDTH(135), KSCALE_WIDTH(20))];
    self.onsaleLabel.text = @"在售宝贝";
    self.onsaleLabel.font = K_12_FONT;
    self.onsaleLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    self.onsaleLabel.textAlignment = NSTextAlignmentCenter;
    [self.messageView addSubview:self.onsaleLabel];
    
    
    self.storeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(160), KSCALE_WIDTH(375), KSCALE_WIDTH(90))];
    self.storeButton.backgroundColor = KCLEAR_COLOR;
    [self.storeButton addTarget:self action:@selector(storeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageView addSubview:self.storeButton];
    
    self.detailslineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(250), KSCALE_WIDTH(375), KSCALE_WIDTH(5))];
    self.detailslineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.messageView addSubview:self.detailslineView];
    
}

- (void)createDetailsView {
    self.detailsView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(575), KSCALE_WIDTH(375), KSCALE_WIDTH(120))];
    self.detailsView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.detailsView];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    label.text = @"商品详情";
    label.font = K_18_BFONT;
    label.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.detailsView addSubview:label];
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(50), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
//    self.introduceLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
    self.introduceLabel.font = K_14_FONT;
    self.introduceLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.introduceLabel.numberOfLines = 0;
    [self.detailsView addSubview:self.introduceLabel];
    
    
    
}

- (void)createFooterView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(11) - KTabHight, KSCALE_WIDTH(375), KSCALE_WIDTH(11) + KTabHight)];
    self.footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.footerView];
    
    UIImageView * collectionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(2), KSCALE_WIDTH(36), KSCALE_WIDTH(36))];
    collectionImageView.image = [UIImage imageNamed:@"收藏"];
    [self.footerView addSubview:collectionImageView];
    
    UILabel * collectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(40), KSCALE_WIDTH(36), KSCALE_WIDTH(20))];
    collectionLabel.text = @"收藏";
    collectionLabel.font = K_12_FONT;
    collectionLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    collectionLabel.textAlignment = NSTextAlignmentCenter;
    [self.footerView addSubview:collectionLabel];
    
    
    self.chatButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(9), KSCALE_WIDTH(135), KSCALE_WIDTH(42))];
    self.chatButton.backgroundColor = [QCClassFunction stringTOColor:@"#66CC66"];
    self.chatButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView:self.chatButton withRadius:KSCALE_WIDTH(5)];
    [self.chatButton addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.chatButton setTitle:@"联系卖家" forState:UIControlStateNormal];
    [self.chatButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.footerView addSubview:self.chatButton];
    
    self.buyButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(225), KSCALE_WIDTH(9), KSCALE_WIDTH(135), KSCALE_WIDTH(42))];
    self.buyButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.buyButton.titleLabel.font = K_16_FONT;
    [QCClassFunction filletImageView: self.buyButton withRadius:KSCALE_WIDTH(5)];
    [self.buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyButton setTitle:@"支付" forState:UIControlStateNormal];
    [self.buyButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.footerView addSubview:self.buyButton];
    
    
    
}

- (GKPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [GKPageControl new];
        _pageControl.style = GKPageControlStyleSizeDot;
        _cycleScrollView.pageControl = _pageControl;
        
    }
    return _pageControl;
}


#pragma mark - tapAction
- (void)shareAction:(UIButton *)sender {
    
}

- (void)leftAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)chatAction:(UIButton *)sender {
    
}

- (void)buyAction:(UIButton *)sender {
    QCGoodsDetailsModel * model  = [self.dataArr firstObject];
    QCSureOrderViewController * sureOrderViewController = [[QCSureOrderViewController alloc] init];
    sureOrderViewController.hidesBottomBarWhenPushed = YES;
    sureOrderViewController.model = model;
    [self.navigationController pushViewController:sureOrderViewController animated:YES];
    

    
}

- (void)storeAction:(UIButton *)sender {
    
    QCGoodsDetailsModel * model = [self.dataArr firstObject];
    QCStoresViewController * storesViewController  = [[QCStoresViewController alloc] init];
    storesViewController.hidesBottomBarWhenPushed = YES;
    storesViewController.uid = model.uid;
    [self.navigationController pushViewController:storesViewController animated:YES];
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
                NSLog(@"%@",model.cellH);

                
                
                [self.imageDetailsArr addObject:model];
            }
            
            for (NSDictionary * dic in responseObject[@"data"][@"goods"]) {
                QCGoodsModel * model = [[QCGoodsModel alloc] initWithDictionary:dic error:nil];


                
                
                [self.goodsArr addObject:model];
            }
            
            [self.cycleScrollView reloadData];
            [self fill];
            [self.tableView reloadData];

            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)fill {
    QCGoodsDetailsModel * model = [self.dataArr firstObject];
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    if ([model.delivery_type isEqualToString:@"1"]) {
        self.freeLabel.text = @"自提";
        self.freeLabel.hidden = NO;

    }
    if ([model.delivery_type isEqualToString:@"3"]) {
        self.freeLabel.hidden = YES;
    }
    if ([model.delivery_type isEqualToString:@"2"]) {
        self.freeLabel.text = @"包邮";
        self.freeLabel.hidden = NO;

    }
    
    if ([model.is_new isEqualToString:@"0"]) {
        self.unoldLabel.text = @"二手";

    }else{
        self.unoldLabel.text = @"全新";

    }
    self.addressLabel.text = model.ship_address;
    self.contentLabel.text = model.content;
    self.nickLabel.text = model.nick;
    self.headerImageView.image = [UIImage imageNamed:@"header"];
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head AppendingString:@"" placeholderImage:@""];
    self.numberLabel.text = model.num;
    self.introduceLabel.text = model.content;

}




#pragma mark - UITableViewDelegate

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    label.font = K_18_BFONT;
    label.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [view addSubview:label];
    
    if (section == 0) {
        label.text = @"为您推荐";

    }else{
        label.text = @"";

    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return KSCALE_WIDTH(60);

    }else{
        return KSCALE_WIDTH(11) + KTabHight;

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.imageDetailsArr.count;

    }else{
        return self.goodsArr.count;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QCImageDetailsModel * model = self.imageDetailsArr[indexPath.row];
        return [model.cellH floatValue] + KSCALE_WIDTH(10);

    }else{
        return KSCALE_WIDTH(120);

    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
        QCGoodsDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        QCImageDetailsModel * model = self.imageDetailsArr[indexPath.row];
        [cell fillCellWithModel:model];
        return cell;
    }else{
        QCRecommendedCell * cell = [tableView dequeueReusableCellWithIdentifier:@"recommendedCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        QCGoodsModel * model = self.goodsArr[indexPath.row];
        [cell fillCellWithModel:model];
        return cell;

    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {

    }else{
        QCGoodsModel * model = self.goodsArr[indexPath.row];
        QCGoodsDetailsViewController * goodsDetailsViewController  = [[QCGoodsDetailsViewController alloc] init];
        goodsDetailsViewController.hidesBottomBarWhenPushed = YES;
        goodsDetailsViewController.goodsId = model.id;

        [self.navigationController pushViewController:goodsDetailsViewController animated:YES];
    }

    
}






#pragma mark - GKCycleScrollViewDataSource
- (NSInteger)numberOfCellsInCycleScrollView:(GKCycleScrollView *)cycleScrollView {
    
    
    return self.imageArr.count;
}

- (void)cycleScrollView:(GKCycleScrollView *)cycleScrollView didSelectCellAtIndex:(NSInteger)index {
    
    
    
    
}
- (GKCycleScrollViewCell *)cycleScrollView:(GKCycleScrollView *)cycleScrollView cellForViewAtIndex:(NSInteger)index {
    GKCycleScrollViewCell *cell = [cycleScrollView dequeueReusableCell];
    if (!cell) {
        cell = [GKCycleScrollViewCell new];
//        cell.layer.cornerRadius = KSCALE_WIDTH(10.0f);
        cell.layer.masksToBounds = YES;
        cell.imageView.contentMode = UIViewContentModeScaleToFill;
        
        
    }
    
        QCImageDetailsModel * model = self.imageArr[index];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img]];
    
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
//    cell.imageView.layer.cornerRadius = KSCALE_WIDTH(10.0f);
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}


#pragma mark - scrollViewDelegata
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = (offsetY) / KSCALE_WIDTH(375 * 4 / 3.0);
    [self.navigationBar showNavWithAlpha:alpha];
    
}



@end
