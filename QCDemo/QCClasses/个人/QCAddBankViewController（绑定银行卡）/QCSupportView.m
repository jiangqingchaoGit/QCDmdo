//
//  QCSupportView.m
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSupportView.h"
#import "QCSupportCell.h"

@interface QCSupportView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end
@implementation QCSupportView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KBACK_COLOR;
        
        [self initUI];
    }
    return self;
}

#pragma mark - GETDATA
- (void)GETDATA {

    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/bank" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];


        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];

            for (NSDictionary * dic in responseObject[@"data"]) {

                QCSupportModel * model = [[QCSupportModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self];

        }



    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}





#pragma mark - initUI

- (void)initUI {

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    label.text = @"请选择开户行";
    label.font = K_16_FONT;
    [self addSubview:label];
    
    self.backgroundColor = KBACK_COLOR;
    self.dataArr  = [[NSMutableArray alloc] init];
    [self createTableView];
    [self GETDATA];

   
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(52), KSCALE_WIDTH(375), KSCALE_WIDTH(260)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCSupportCell class] forCellReuseIdentifier:@"cell"];
    
    [self addSubview:self.tableView];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(52);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSupportCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QCSupportModel * model = self.dataArr[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSupportModel * model = self.dataArr[indexPath.row];
    self.bankBlock(model.id, model.bank_name);
    [[self superview] removeFromSuperview];

    

}


@end
