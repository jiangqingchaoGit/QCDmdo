//
//  QCStoresViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCStoresViewController.h"
#import "QCRecommendedCell.h"
#import "QCGoodsDetailsViewController.h"
@interface QCStoresViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * markLabel;

@property (nonatomic, strong) UILabel * releaseLabel;
@property (nonatomic, strong) UILabel * saleLabel;

@property (nonatomic, strong) NSMutableArray * dataArr;




@end

@implementation QCStoresViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];

    [self createTableView];
    [self createHeaderView];
    [self initUI];


    [self GETDATA];

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
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
    [self.tableView registerClass:[QCRecommendedCell class] forCellReuseIdentifier:@"recommendedCell"];

    
    [self.view addSubview:self.tableView];
}

- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(400))];
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(127.5), KSCALE_WIDTH(30), KSCALE_WIDTH(120), KSCALE_WIDTH(120))];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(60)];
    [self.headerView addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(160), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = K_16_FONT;
    self.nameLabel.textColor = KTEXT_COLOR;
    [self.headerView addSubview:self.nameLabel];
    
    self.markLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(200), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.markLabel.textAlignment = NSTextAlignmentCenter;
    self.markLabel.font = K_14_FONT;
    self.markLabel.textColor = KTEXT_COLOR;
    [self.headerView addSubview:self.markLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(245), KSCALE_WIDTH(375), KSCALE_WIDTH(5))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.headerView addSubview:lineView];
    
    
    self.releaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(270), KSCALE_WIDTH(187), KSCALE_WIDTH(30))];
    self.releaseLabel.textAlignment = NSTextAlignmentCenter;
    self.releaseLabel.font = K_20_BFONT;
    self.releaseLabel.textColor = KTEXT_COLOR;
    [self.headerView addSubview:self.releaseLabel];
    
    UILabel * releaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(300), KSCALE_WIDTH(187), KSCALE_WIDTH(30))];
    releaseLabel.text = @"发布宝贝";
    releaseLabel.textAlignment = NSTextAlignmentCenter;
    releaseLabel.font = K_14_FONT;
    releaseLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.headerView addSubview:releaseLabel];
    
    self.saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(188), KSCALE_WIDTH(270), KSCALE_WIDTH(187), KSCALE_WIDTH(30))];
    self.saleLabel.textAlignment = NSTextAlignmentCenter;
    self.saleLabel.font = K_20_BFONT;
    self.saleLabel.textColor = KTEXT_COLOR;
    [self.headerView addSubview:self.saleLabel];
    
    UIView * saleView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(187), KSCALE_WIDTH(270), KSCALE_WIDTH(1), KSCALE_WIDTH(60))];
    saleView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.headerView addSubview:saleView];

    UILabel * saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(188), KSCALE_WIDTH(300), KSCALE_WIDTH(187), KSCALE_WIDTH(30))];
    saleLabel.text = @"在售宝贝";
    saleLabel.textAlignment = NSTextAlignmentCenter;
    saleLabel.font = K_14_FONT;
    saleLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
    [self.headerView addSubview:saleLabel];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(350), KSCALE_WIDTH(375), KSCALE_WIDTH(5))];
    lineView1.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.headerView addSubview:lineView1];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(370), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    label.font = K_16_BFONT;
    label.text = @"在售宝贝";
    label.textColor = [QCClassFunction stringTOColor:@"#000000"];
    [self.headerView addSubview:label];
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"店铺详情";
}



- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"limit=%@&page=%@&user_id=%@",@"15",@"1",self.uid];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"limit":@"15",@"page":@"1",@"user_id":self.uid};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/merchant" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        

        
        if ([responseObject[@"status"] intValue] == 1){
            for (NSDictionary * dic in responseObject[@"data"][@"goods"]) {
                QCGoodsModel * model = [[QCGoodsModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            
            [QCClassFunction sd_imageView:self.headerImageView ImageURL:responseObject[@"data"][@"user"][@"head"] AppendingString:nil placeholderImage:@"header"];
            self.nameLabel.text = responseObject[@"data"][@"user"][@"nick"];
            self.markLabel.text = @"已实名认证";
            self.releaseLabel.text = [responseObject[@"data"][@"stock"] stringValue];
            self.saleLabel.text = [responseObject[@"data"][@"in_stock"] stringValue];

            
            [self.tableView reloadData];
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)fill {


}




#pragma mark - UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(120);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCRecommendedCell * cell = [tableView dequeueReusableCellWithIdentifier:@"recommendedCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCGoodsModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCGoodsDetailsViewController * goodsDetailsViewController  = [[QCGoodsDetailsViewController alloc] init];
    QCGoodsModel * model = self.dataArr[indexPath.row];
    goodsDetailsViewController.hidesBottomBarWhenPushed = YES;
    goodsDetailsViewController.goodsId = model.id;

    [self.navigationController pushViewController:goodsDetailsViewController animated:YES];
    
}









@end
