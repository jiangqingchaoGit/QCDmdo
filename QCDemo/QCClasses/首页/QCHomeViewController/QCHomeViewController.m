//
//  QCHomeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHomeViewController.h"
#import "QCHomeReusableView.h"
#import "QCHomeItem.h"
#import "QCAdModel.h"
#import "QCBanModel.h"
#import "QCCategoryModel.h"

#import "QCReleaseViewController.h"
#import "QCGoodsDetailsViewController.h"
#import "QCGoodsListViewController.h"
@interface QCHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**自定义导航栏*/

@property (nonatomic, strong) UIView * navView;
@property (nonatomic, assign) NSInteger i;

@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UILabel * addressLable;
@property (nonatomic, strong) UIImageView * addressImageView;

@property (nonatomic, strong) UILabel * weatherLabel;

@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * messageButton;
@property (nonatomic, strong) UIButton * scanButton;
@property (nonatomic, strong) UIView * searchView;
@property (nonatomic, strong) UITextField * searchTextField;


@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataArr;



@property (nonatomic, strong) UIButton * searchButton;


@property (nonatomic, strong) QCHomeReusableView * homeView;

@end

@implementation QCHomeViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.i = 1;
    [self GETGOODSDATA];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createNavView];
    [self createCollectionView];
    [self GETDATA];
    [self checkTheUpdate];
    [self refreshData];

}

#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"limit=15&page=%@",[NSString stringWithFormat:@"%ld",self.i]];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"page":[NSString stringWithFormat:@"%ld",self.i]};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/index" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        

        
        if ([responseObject[@"status"] intValue] == 1) {

            
            

            [self.homeView.bannerData removeAllObjects];
            [self.homeView.classData removeAllObjects];
            [self.homeView.advertisingData removeAllObjects];

            
            for (NSDictionary * dic in responseObject[@"data"][@"ban"]) {
                QCBanModel * model = [[QCBanModel alloc] initWithDictionary:dic error:nil];
                [self.homeView.bannerData addObject:model];
            }
            
            for (NSDictionary * dic in responseObject[@"data"][@"category"]) {
                QCCategoryModel * model = [[QCCategoryModel alloc] initWithDictionary:dic error:nil];
                [self.homeView.classData addObject:model];
            }
            
            for (NSDictionary * dic in responseObject[@"data"][@"ad"]) {
                 QCAdModel * model = [[QCAdModel alloc] initWithDictionary:dic error:nil];
                [self.homeView.advertisingData addObject:model];
            }
            
            

            [self.homeView fillSize];

            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}


- (void)GETGOODSDATA {
    
    NSString * str = [NSString stringWithFormat:@"limit=15&page=%@",[NSString stringWithFormat:@"%ld",self.i]];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"page":[NSString stringWithFormat:@"%ld",self.i]};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];

        
        if ([responseObject[@"status"] intValue] == 1) {
            if (self.i == 1) {
                [self.dataArr removeAllObjects];
            }
            
            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCGoodsModel * model = [[QCGoodsModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            
            
            
            if (self.dataArr.count == 0) {
                self.collectionView.mj_footer.hidden = YES;
            }else{
                self.collectionView.mj_footer.hidden = NO;
            }
            [self.collectionView reloadData];
            

            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}

- (void)refreshData {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.i = 1;
        [self GETGOODSDATA];
        [self GETDATA];

    }];
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.i++;
        [self GETGOODSDATA];
        
    }];
    self.collectionView.mj_footer = footer;
    self.collectionView.mj_header = header;
    
    
}


#pragma mark - tapAction
- (void)leftAction:(UIButton *)sender {

}

- (void)messageAction:(UIButton *)sender {

}

- (void)scanAction:(UIButton *)sender {
    QCReleaseViewController * releaseViewController = [[QCReleaseViewController alloc] init];
    releaseViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:releaseViewController animated:YES];
}
- (void)searchAction:(UIButton *)sender {
    QCGoodsListViewController * goodsListViewController = [[QCGoodsListViewController alloc] init];
    goodsListViewController.hidesBottomBarWhenPushed = YES;
    goodsListViewController.classId = @"0";

    [self.navigationController pushViewController:goodsListViewController animated:YES];
    
}
#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;


    [[QCMapInstance shared] startLocationIsNeedCity:YES WithCompletion:^(CLLocationCoordinate2D coor, NSString *city, NSString *cityCode) {
        city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];


        
        if (city != nil) {
            self.addressLable.text = city;
//            CGFloat labelH = [QCClassFunction getWidthWithString:self.addressLable.text andFontSize:14.0 andConstrainedHeight:24];
//            self.addressImageView.image = [UIImage imageNamed:@"向下箭头"];
//            self.addressImageView.frame = CGRectMake(labelH + 15, 4, 16, 16);
            [self GETWeather];
        }else{

            self.addressLable.text = @"定位";
//            CGFloat labelH = [QCClassFunction getWidthWithString:self.addressLable.text andFontSize:14.0 andConstrainedHeight:24];
//            self.addressImageView.image = [UIImage imageNamed:@"向下箭头"];
//            self.addressImageView.frame = CGRectMake(labelH + 15, 4, 16, 16);
        }
        
        

    }];
    
    
}

- (void)GETWeather {
    NSDictionary * dic = @{@"city":self.addressLable.text};
    [QCAFNetWorking QCGETWeather:@"http://wthrcdn.etouch.cn/weather_mini" parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        NSArray * arr = responseObject[@"data"][@"forecast"];
        
        self.weatherLabel.text = [NSString stringWithFormat:@"%@ %@°C",[arr firstObject][@"type"],responseObject[@"data"][@"wendu"]];

        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (void)createNavView {
    
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KNavHight)];
    [self.view addSubview:self.navView];
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5),KStatusHight, 44, 74)];
    [self.navView addSubview:self.leftView];

    self.addressLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 64, 24)];
    self.addressLable.textColor = KTEXT_COLOR;
    self.addressLable.font = K_14_BFONT;


    self.addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 4, 16, 16)];
    [self.leftView addSubview:self.addressImageView];
    
    [self.leftView addSubview:self.addressLable];
    self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 24, 64, 20)];
    self.weatherLabel.textColor = KTEXT_COLOR;
    self.weatherLabel.font = K_12_FONT;
    self.weatherLabel.font = K_12_FONT;

    [self.leftView addSubview:self.weatherLabel];
    
    
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5),KStatusHight , 44, 74)];
    self.leftButton.backgroundColor = [UIColor clearColor];
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.leftButton];
    
//    self.messageButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280),KStatusHight , 44, 44)];
//    [self.messageButton setImage:KHeaderImage forState:UIControlStateNormal];
//    [self.messageButton addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navView addSubview:self.messageButton];
    
    self.scanButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(330),KStatusHight , 44, 44)];
    [self.scanButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.scanButton addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.scanButton];
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), 3 + KStatusHight , KSCALE_WIDTH(245) , 38)];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.navView addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(12), 12, 14 , 14)];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [searchView addSubview:searchImageView];
    
    UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(38), KSCALE_WIDTH(0), KSCALE_WIDTH(100) , 38)];
    searchLabel.text = @"搜索商品";
    searchLabel.font = K_14_BFONT;
    searchLabel.textColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
    searchLabel.backgroundColor = [UIColor clearColor];
    [searchView addSubview:searchLabel];
    
    
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(225), 38)];
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchButton];
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //  4:3
    layout.itemSize = CGSizeMake(KSCALE_WIDTH(167.5),KSCALE_WIDTH(270));
    layout.minimumInteritemSpacing = KSCALE_WIDTH(10);
    layout.minimumLineSpacing =  KSCALE_WIDTH(12);
    layout.sectionInset = UIEdgeInsetsMake(0, KSCALE_WIDTH(15), 0, KSCALE_WIDTH(15));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,KNavHight,KSCALE_WIDTH(375),KSCREEN_HEIGHT - KNavHight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = KBACK_COLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[QCHomeItem class] forCellWithReuseIdentifier:@"item"];
    [self.collectionView registerClass:[QCHomeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeView"];

    [self.view addSubview:self.collectionView];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    

    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCHomeItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    QCGoodsModel * model = self.dataArr[indexPath.row];
    [item fillItemWithModel:model];

    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QCGoodsDetailsViewController * goodsDetailsViewController  = [[QCGoodsDetailsViewController alloc] init];
    QCGoodsModel * model = self.dataArr[indexPath.row];
    goodsDetailsViewController.hidesBottomBarWhenPushed = YES;
    goodsDetailsViewController.goodsId = model.id;

    [self.navigationController pushViewController:goodsDetailsViewController animated:YES];
}

//  设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    self.homeView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"homeView" forIndexPath:indexPath];
    return self.homeView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KSCREEN_WIDTH, KSCALE_WIDTH(475));

}


#pragma mark - 版本更新
- (void)checkTheUpdate {
    
    NSString * str = [NSString stringWithFormat:@"app_type=ios"];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"app_type":@"ios"};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/version" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        

        
        if ([responseObject[@"status"] intValue] == 1) {
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

@end
