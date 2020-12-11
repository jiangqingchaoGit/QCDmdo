//
//  QCHelpViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHelpViewController.h"
#import "QCHelpCell.h"

#import "QCHelpViewDetailsController.h"
@interface QCHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * idLabel;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation QCHelpViewController

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
    
    self.dataArr = [[NSMutableArray alloc] init];
    
    [self initUI];
    [self GETDATA];
    [self createTableView];
    [self createHeaderView];
}



- (void)GETDATA {


    NSString * str = [NSString stringWithFormat:@"title=%@",@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    
    NSDictionary * dic = @{@"title":@""};

    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/help" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {


        if ([responseObject[@"status"] intValue] == 1) {
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCHelpModel * model = [[QCHelpModel alloc] initWithDictionary:dic error:nil];
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



#pragma mark - tapAction
- (void)copyAction:(UIButton *)sender {
    
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title  = @"帮助中心";
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCHelpCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(130))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    UILabel * helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(61), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    helpLabel.text = @"帮助";
    helpLabel.font = K_24_BFONT;
    helpLabel.textColor = KTEXT_COLOR;
    helpLabel.textAlignment = NSTextAlignmentLeft;
    [self.headerView addSubview:helpLabel];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(96), KSCALE_WIDTH(300), KSCALE_WIDTH(18))];
    tipLabel.text = @"常见问题";
    tipLabel.font = K_14_FONT;
    tipLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    [self.headerView addSubview:tipLabel];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(56);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    QCHelpCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    QCHelpModel * model = self.dataArr[indexPath.row];
    cell.titleLabel.text = model.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCHelpViewDetailsController * helpViewDetailsController = [[QCHelpViewDetailsController alloc]  init];
    QCHelpModel * model = self.dataArr[indexPath.row];
    helpViewDetailsController.hidesBottomBarWhenPushed = YES;
    helpViewDetailsController.contentStr = model.content;
    helpViewDetailsController.title = model.title;

    [self.navigationController pushViewController:helpViewDetailsController animated:YES];
}



@end
