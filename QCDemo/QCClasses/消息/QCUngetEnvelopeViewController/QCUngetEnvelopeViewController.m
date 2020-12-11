//
//  QCUngetEnvelopeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/12/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCUngetEnvelopeViewController.h"
#import "QCOtherEnvelopeCell.h"

@interface QCUngetEnvelopeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation QCUngetEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self GETDATA];
    [self createTableView];
}
- (void)initUI {
    self.title = @"未领取红包";
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCOtherEnvelopeCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
}

- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&token=%@&uid=%@",self.group_id,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    [QCAFNetWorking QCPOST:@"/api/chat/undonered" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];

            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCUngetModel * model = [[QCUngetModel alloc] initWithDictionary:dic error:nil];
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

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(108.5);
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCOtherEnvelopeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    QCUngetModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithUngetModel:model];

    


    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}
@end
