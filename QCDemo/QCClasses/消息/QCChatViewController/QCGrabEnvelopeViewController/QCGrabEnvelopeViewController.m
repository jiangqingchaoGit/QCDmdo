//
//  QCGrabEnvelopeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGrabEnvelopeViewController.h"
#import "QCEnvelopeCell.h"
#import "QCEnvelopView.h"
#import "QCEnveolpModel.h"
//  红包记录
#import "QCEnvelopeViewController.h"
@interface QCGrabEnvelopeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) UIView * headerView;

@property (nonatomic, strong) UIImageView * personImageView;
@property (nonatomic, strong) UILabel * personLabel;
@property (nonatomic, strong) UILabel * moneyLabel;

@end

@implementation QCGrabEnvelopeViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc] init];

    [self initUI];
    [self createTableView];
    [self createHeaderView];
    
    [self GETDATA];
    
}

- (void)GETDATA {
    
//    NSDictionary * dic = @{@"o":@"1",@"v":kFetchNSUserDefaults(@"iphone"),@"a":kFetchNSUserDefaults(@"v"),@"pkId":_envelopeId,@"token":kFetchNSUserDefaults(@"token")};
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *output = [[QCClassFunction AES128_Encrypt:gIv encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    [QCAFNetWorking postBodyWithApi:@"pack.details" json:output success:^(id data, NSURLResponse *response) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
//        if ([data[@"code"] integerValue] == 200) {
//
    
    
            QCEnveolpModel * enveolpModel = [[QCEnveolpModel alloc] init];
//
            [self.dataArr addObject:enveolpModel];
//
//
//            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
//                [self fill];
//            });
//
//
//        }else{
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [QCClassFunction showMessage:data[@"msg"] toView:self.view];
//
//            });
//
//        }
//
//    } failure:^(NSURLResponse *response, NSError *error) {
//
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//            [QCClassFunction showMessage:@"网络请求失败，请重试" toView:self.view];
//
//        });
//
//    }];
}

- (void)fill {
    QCEnveolpModel * model = [_dataArr firstObject];

    
    [_personImageView sd_setImageWithURL:[NSURL URLWithString:model.u] placeholderImage:[UIImage imageNamed:@"personImage"]];

    _personLabel.text =[NSString stringWithFormat:@"%@的红包",model.n];
    
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f分   雷号%@",[model.m floatValue],model.s];


}
#pragma mark - tapAction
- (void)leftAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction:(UIButton *)sender {
    //  红包记录界面
    QCEnvelopeViewController * envelopeViewController = [[QCEnvelopeViewController alloc] init];
    envelopeViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:envelopeViewController animated:YES];
}
#pragma mark - initUI
- (void)initUI {
//    self.title = @"发发发发";
//    self.view.backgroundColor = KBACK_COLOR;
    

    
    
    
}



- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = KBACK_COLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 10;
    [_tableView registerClass:[QCEnvelopeCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[QCEnvelopView class] forHeaderFooterViewReuseIdentifier:@"header"];

    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    [self.view addSubview:_tableView];
}


#pragma mark - createHeaderView
- (void)createHeaderView {
    
    //          //  10|1||1004,思绪云骞,https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKvIeK0jAOPRwfibyohzjYqKzcRS0gx019dQcL09AUFGXKHpaWqLicl9yPWJtViaX3NClukqFecpxSLg/132,457b6836-3287-11e9-b4a3-00163e0a4594,1.13,0
    
//    NSArray * array = [NSArray arrayWithArray:[_moneyArr[3] componentsSeparatedByString:@","]];;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_WIDTH / 639 * 400)];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:_headerView.frame];
    imageView.image = [UIImage imageNamed:@"list"];
    [_headerView addSubview:imageView];
    
    
    
    
    _personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH / 2.0 - 20, KNavHight + 5, 40, 40)];
    _personImageView.image = [UIImage imageNamed:@"header"];
    [_headerView addSubview:_personImageView];
    
    _personLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH / 2.0 - 150, KNavHight + 60, 300, 30)];
    _personLabel.font = K_20_BFONT;
    _personLabel.text = @"思绪云骞";
    _personLabel.textAlignment = NSTextAlignmentCenter;
    _personLabel.textColor = KTEXT_COLOR;
    [_headerView addSubview:_personLabel];


    
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KNavHight + 100, KSCREEN_WIDTH,20)];

    _moneyLabel.font = K_16_FONT;
    _moneyLabel.textColor = KBACK_COLOR;
    _moneyLabel.text = @"100元";
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:_moneyLabel];
    
    _tableView.tableHeaderView = _headerView;
    
    
    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, KNavHight - 20)];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:leftButton];
    
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 80, 20, 80, KNavHight - 20)];
    [rightButton setTitle:@"红包记录" forState:UIControlStateNormal];
    [rightButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    rightButton.titleLabel.font = K_16_FONT;
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:rightButton];
    
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCEnvelopeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    QCEnveolpModel * model = [_dataArr firstObject];
//    QCEnveolpListModel * listModel = model.d[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell fillCellWithModel:listModel];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    QCEnveolpModel * model = [_dataArr firstObject];
//    return model.d.count;
    
    NSLog(@"%ld",self.dataArr.count);
    
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QCEnvelopView * envelopView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    
    QCEnveolpModel * model = [_dataArr firstObject];
    
//    if ([model.remainEnveolp isEqualToString:_gameModel.packCount]) {
//        envelopView.label.text = [NSString stringWithFormat:@"红包%ld秒抢完",[[QCClassFunction URLDecodedString:model.time] integerValue] / 1000];
//    }else{
//        envelopView.label.text = [NSString stringWithFormat:@"已领取%ld/%@  (3分钟内红包未领取完将发起自动退款)",[_gameModel.packCount integerValue] - [[QCClassFunction URLDecodedString:model.remainEnveolp] integerValue],_gameModel.packCount];
//    }
//
    model.m = @"0";
    if ([model.m isEqualToString:@"0"]) {
        envelopView.label.text = [NSString stringWithFormat:@"红包%ld秒抢完",[model.t integerValue] / 1000];
    }else{
        envelopView.label.text = [NSString stringWithFormat:@"已领取%ld/%@  (3分钟内红包未领取完将发起自动退款)",[model.c integerValue] - [model.l integerValue],model.c];
    }
    
    return envelopView;
}




@end
