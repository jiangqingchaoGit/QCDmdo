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
@interface QCHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**自定义导航栏*/

@property (nonatomic, strong) UIView * navView;
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

}
- (void)viewDidLoad {
    [super viewDidLoad];
    


    [self initUI];
    [self createNavView];
    [self createCollectionView];


}

#pragma mark - tapAction
- (void)leftAction:(UIButton *)sender {

}

- (void)messageAction:(UIButton *)sender {

}

- (void)scanAction:(UIButton *)sender {

}
- (void)searchAction:(UIButton *)sender {
    
}
#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;

}

- (void)createNavView {
    
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KNavHight)];
    [self.view addSubview:self.navView];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5),KStatusHight , 44, 44)];
    [self.leftButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.leftButton];
    
    self.messageButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280),KStatusHight , 44, 44)];
    [self.messageButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.messageButton addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.messageButton];
    
    self.scanButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(330),KStatusHight , 44, 44)];
    [self.scanButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.scanButton addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.scanButton];
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(50), 3 + KStatusHight , KSCALE_WIDTH(225) , 38)];
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
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCHomeItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

//  设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    self.homeView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"homeView" forIndexPath:indexPath];
    return self.homeView;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KSCREEN_WIDTH, KSCALE_WIDTH(540));

}


@end
