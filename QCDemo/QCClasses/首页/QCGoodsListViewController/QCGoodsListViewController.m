//
//  QCGoodsListViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGoodsListViewController.h"
#import "QCHomeItem.h"
#import "QCListReusableView.h"

#import "QCGoodsDetailsViewController.h"
@interface QCGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) QCListReusableView * homeView;

@property (nonatomic, strong) UIView * navView;
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * scanButton;
@property (nonatomic, strong) UITextField * searchTextField;






@end

@implementation QCGoodsListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.typeStr = @"1";
    self.i = 1;
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createNavView];
    [self createCollectionView];
    [self GETDATA];
    [self refreshData];

}




#pragma mark - GETDATA


- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"limit=15&name=%@&page=%@&sotr=%@&type_id=%@",self.searchTextField.text,[NSString stringWithFormat:@"%ld",self.i],self.typeStr,self.classId];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"name":self.searchTextField.text,@"page":[NSString stringWithFormat:@"%ld",self.i],@"sotr":self.typeStr,@"type_id":self.classId};
    
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
        [self GETDATA];

    }];
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.i++;
        [self GETDATA];
        
    }];
    self.collectionView.mj_footer = footer;
//    self.collectionView.mj_header = header;
    
    
}


#pragma mark - tapAction
- (void)leftAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scanAction:(UIButton *)sender {
    self.searchTextField.text = @"";
    [self.searchTextField resignFirstResponder];

}

- (void)resignAction {
    self.searchTextField.text = @"";
    [self.searchTextField resignFirstResponder];
}



#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    
}

- (void)createNavView {
    
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KNavHight)];
    [self.view addSubview:self.navView];
    

    
    
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0),KStatusHight , 44, 44)];
    [self.leftButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.leftButton];

    
    self.scanButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(330),KStatusHight , 44, 44)];
    self.scanButton.titleLabel.font = K_14_FONT;
    [self.scanButton addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scanButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.scanButton setTitleColor:[QCClassFunction stringTOColor:@"#666666"] forState:UIControlStateNormal];
    [self.navView addSubview:self.scanButton];
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(50), KSCALE_WIDTH(3) + KStatusHight, KSCALE_WIDTH(275) , KSCALE_WIDTH(38))];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#f2F2F2"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.view addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(15) + KStatusHight, KSCALE_WIDTH(14) , KSCALE_WIDTH(14))];
    searchImageView.image = [UIImage imageNamed:@"search"];
    [self.view addSubview:searchImageView];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), 3 + KStatusHight, KSCALE_WIDTH(200) , KSCALE_WIDTH(38))];
    self.searchTextField.placeholder = @"请输入搜索关键字";
    self.searchTextField.font = K_14_FONT;
    self.searchTextField.textColor = [QCClassFunction stringTOColor:@"#333333"];
    self.searchTextField.backgroundColor = [UIColor clearColor];
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeyDone;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.view addSubview:self.searchTextField];
    
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
    [self.collectionView registerClass:[QCListReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeView"];

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
    
    [self resignAction];
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
    return CGSizeMake(KSCREEN_WIDTH, KSCALE_WIDTH(50));

}



- (void)textFieldDidChange:(UITextField *)sender {
    


}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]){
        
        
        //  进行关键字搜索
        
        self.i = 1;
        [self GETDATA];
        return NO;
    }
    return YES;
}



-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {

    
    if([touch.view isDescendantOfView:self.collectionView]){
        return NO;
    }

   return YES;

}
@end
