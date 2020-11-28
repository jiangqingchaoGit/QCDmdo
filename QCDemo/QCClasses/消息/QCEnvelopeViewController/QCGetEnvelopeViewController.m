//
//  QCGetEnvelopeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGetEnvelopeViewController.h"
#import "QCGetEnvelopeCell.h"
#import "QCEnvelopView.h"
#import "QCEnvelopeViewController.h"
//#import "QCEnvelopeRecordViewController.h"

@interface QCGetEnvelopeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSDictionary * dataDic;

@property (nonatomic, strong) UIView * headerView;

@property (nonatomic, strong) UIImageView * personImageView;
@property (nonatomic, strong) UILabel * personLabel;
@property (nonatomic, strong) UILabel * moneyLabel;


@end

@implementation QCGetEnvelopeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [[NSMutableArray alloc] init];

    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self GETDATA];
    
}


- (void)GETDATA {
  
    NSString * str = [NSString stringWithFormat:@"red_id=%@&token=%@&uid=%@",self.envelopeId,K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"red_id":self.envelopeId,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/finance/receiverecord" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            for (NSDictionary * dic in responseObject[@"data"][@"list"]) {
                QCGetEnvelopeModel * model = [[QCGetEnvelopeModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            
            self.dataDic = responseObject;
            [self fill];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

- (void)fill {
    [self.personImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"data"][@"head"]] placeholderImage:[UIImage imageNamed:@"personImage"]];
    self.personLabel.text =[NSString stringWithFormat:@"%@的红包",self.dataDic[@"data"][@"nick"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.dataDic[@"data"][@"red_price"]];
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
    self.view.backgroundColor = KBACK_COLOR;
    
}


- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = KBACK_COLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 10;
    [self.tableView registerClass:[QCGetEnvelopeCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QCEnvelopView class] forHeaderFooterViewReuseIdentifier:@"header"];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    [self.view addSubview:self.tableView];
}


#pragma mark - createHeaderView
- (void)createHeaderView {

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_WIDTH / 639 * 400)];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:_headerView.frame];
    imageView.image = [UIImage imageNamed:@"list"];
    [self.headerView addSubview:imageView];
    
    
    
    
    self.personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH / 2.0 - KSCALE_WIDTH(21), KNavHight + KSCALE_WIDTH(5), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
    [QCClassFunction  filletImageView:self.personImageView withRadius:KSCALE_WIDTH(21)];
    [self.headerView addSubview:self.personImageView];
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KNavHight + KSCALE_WIDTH(60), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.personLabel.font = K_20_BFONT;
    self.personLabel.textAlignment = NSTextAlignmentCenter;
    self.personLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
    [self.headerView addSubview:_personLabel];


    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KNavHight + KSCALE_WIDTH(100), KSCREEN_WIDTH,KSCALE_WIDTH(20))];

    self.moneyLabel.font = K_16_FONT;
    self.moneyLabel.textColor = KBACK_COLOR;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.moneyLabel];
    
    self.tableView.tableHeaderView = self.headerView;
    
    
    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, KNavHight - 20)];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:leftButton];
    
    
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 80, 20, 80, KNavHight - 20)];
    [rightButton setTitle:@"红包记录" forState:UIControlStateNormal];
//    [rightButton setTitleColor:K_SURE1_COLOR forState:UIControlStateNormal];
    rightButton.titleLabel.font = K_16_FONT;
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rightButton];
    
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCGetEnvelopeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    QCGetEnvelopeModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
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

//    if ([model.m isEqualToString:@"0"]) {
//        envelopView.label.text = [NSString stringWithFormat:@"红包%ld秒抢完",[model.t integerValue] / 1000];
//    }else{
//    }
//
//    (3分钟内红包未领取完将发起自动退款)
    
    envelopView.label.text = [NSString stringWithFormat:@"已领取%@/%@",self.dataDic[@"data"][@"gain_num"],self.dataDic[@"data"][@"red_num"]];

    return envelopView;
}
@end
