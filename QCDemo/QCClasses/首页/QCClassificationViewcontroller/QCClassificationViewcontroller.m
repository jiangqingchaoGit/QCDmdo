//
//  QCClassificationViewcontroller.m
//  QCDemo
//
//  Created by JQC on 2020/12/1.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCClassificationViewcontroller.h"
#import "QCCityCell.h"
#import "QCCityItem.h"

#import "QCGoodsListViewController.h"
@interface QCClassificationViewcontroller ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * classArr;

@property (nonatomic, strong) NSString * pidStr;

/*
 *  选中cell
 */

@property (nonatomic, strong) NSIndexPath * indexPath;

@end

@implementation QCClassificationViewcontroller
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pidStr = @"0";

    self.dataArr = [NSMutableArray new];
    self.classArr = [NSMutableArray new];

    [self initUI];
    [self createTableView];
    [self createCollectionView];
    [self GETDATA];
    
}


#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"pid=%@",self.pidStr];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"pid":self.pidStr};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/goods/category" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        if ([responseObject[@"status"] intValue] == 1) {

            if ([self.pidStr isEqualToString:@"0"]) {
                [self.dataArr removeAllObjects];
                for (NSDictionary * dic in responseObject[@"data"]) {
                    QCClassificationModel * model = [[QCClassificationModel alloc] initWithDictionary:dic error:nil];
                    [self.dataArr addObject:model];
                }
                [self.tableView reloadData];
            }else{
                [self.classArr removeAllObjects];
                for (NSDictionary * dic in responseObject[@"data"]) {
                    QCClassificationModel * model = [[QCClassificationModel alloc] initWithDictionary:dic error:nil];
                    [self.classArr addObject:model];
                }
                [self.collectionView reloadData];

            }
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}
#pragma mark - initUI (初始化UI)
- (void)initUI {
    self.view.backgroundColor = KWHITE_COLOR;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH / 4.0 - 0.5, 0, 0.5, KSCREEN_HEIGHT - KNavHight)];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
}

#pragma mark - tableView
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH / 4.0 - 2, KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[QCCityCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(50);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCCityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCClassificationModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    if (indexPath.row == 0) {
        self.pidStr = model.id;
        [self GETDATA];
    }else{
    }
    
    if (_indexPath == nil && indexPath.row == 0) {
        cell.provinceLabel.font = K_16_BFONT;
        _indexPath = indexPath;


    }else{
        cell.provinceLabel.font = K_14_FONT;

    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_indexPath != nil) {
        QCCityCell * cell = [tableView cellForRowAtIndexPath:_indexPath];
        cell.provinceLabel.font = K_14_FONT;
    }
    QCCityCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.provinceLabel.font = K_16_BFONT;
    _indexPath = indexPath;
    
    QCClassificationModel * model = self.dataArr[indexPath.row];
    self.pidStr = model.id;
    [self GETDATA];

}

#pragma mark - collectionView
- (void)createCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //  4:3
    layout.itemSize = CGSizeMake(KSCREEN_WIDTH / 4.0, KSCALE_WIDTH(110));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH / 4.0, 0, KSCREEN_WIDTH / 4.0 * 3, KSCREEN_HEIGHT - KNavHight) collectionViewLayout:layout];
    _collectionView.backgroundColor = KWHITE_COLOR;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[QCCityItem class] forCellWithReuseIdentifier:@"item"];
    [self.view addSubview:_collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCCityItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    QCClassificationModel * model = self.classArr[indexPath.row];
    [item fillCellWithModel:model];

    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
    
    
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    self.cityBlock(@"重庆市");
    if ([self.status isEqualToString:@"0"]) {
        QCClassificationModel * model = self.classArr[indexPath.row];
        self.classBlock(model.name,model.pid);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //  商品列表界面
        QCClassificationModel * model = self.classArr[indexPath.row];
        QCGoodsListViewController * goodsListViewController = [[QCGoodsListViewController alloc] init];
        goodsListViewController.hidesBottomBarWhenPushed = YES;
        goodsListViewController.classId = model.id;
        [self.navigationController pushViewController:goodsListViewController animated:YES];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}







@end
