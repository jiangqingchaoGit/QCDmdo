//
//  QCPayTypeView.m
//  QCDemo
//
//  Created by JQC on 2020/12/8.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPayTypeView.h"
#import "QCPayCell.h"
#import "QCAddBankViewController.h"

#import "QCSendEnvelopeViewController.h"
#import "QCTransferViewController.h"


@interface QCPayTypeView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UIButton * selectButton;
@end

@implementation QCPayTypeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KBACK_COLOR;
    }
    return self;
}

- (void)initUI {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
    if ([self.statusStr isEqualToString:@"0"]) {
        //  充值提现
        label.text = [NSString stringWithFormat:@"选择%@银行卡",self.typeStr];

    }
    if ([self.statusStr isEqualToString:@"1"]) {
        //  交易
        label.text = [NSString stringWithFormat:@"选择%@方式",self.typeStr];

    }
    label.font = K_16_FONT;
    [self addSubview:label];
    self.dataArr = [[NSMutableArray alloc] init];
    
    [self createTableView];
    [self GETDATA];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(52), KSCALE_WIDTH(375), KSCALE_WIDTH(260)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionFooterHeight = 0.01;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCPayCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:self.tableView];
    
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
    NSString * str = [NSString stringWithFormat:@"token=%@&uid=%@",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    
    NSDictionary * dic = @{@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    [QCAFNetWorking QCPOST:@"/api/user/card_list" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
        
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            [self.dataArr removeAllObjects];
            
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCBankModel * model = [[QCBankModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            [self.tableView reloadData];
            
        }else{
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.statusStr isEqualToString:@"0"]) {
        return self.dataArr.count + 1;

    }
    return self.dataArr.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(52);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.chooseButton.hidden = NO;
    
    
    if ([self.statusStr isEqualToString:@"0"]) {

        if (indexPath.row == self.dataArr.count) {
            cell.payLabel.text = @"添加新银行卡";
            cell.chooseButton.hidden = YES;


        }else{
            QCBankModel * model = self.dataArr[indexPath.row];
            [cell fillCellWithModel:model];
        }
    }else{
        
        if (indexPath.row == 0) {
            cell.payLabel.text = @"余额支付";

        }else if (indexPath.row == self.dataArr.count + 1) {
            cell.payLabel.text = @"添加新银行卡";
            cell.chooseButton.hidden = YES;


        }else{
            QCBankModel * model = self.dataArr[indexPath.row - 1];
            [cell fillCellWithModel:model];
        }
        
    }
    


    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCPayCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectButton.selected = NO;
    cell.chooseButton.selected = YES;
    self.selectButton = cell.chooseButton;
    
    if ([self.statusStr isEqualToString:@"0"]) {
        if (indexPath.row == self.dataArr.count) {
            QCAddBankViewController * addBankViewController = [[QCAddBankViewController alloc] init];
            addBankViewController.hidesBottomBarWhenPushed = YES;
            [[QCClassFunction currentNC] pushViewController:addBankViewController animated:YES];
            
        
        }else{
            //  选择银行卡
            QCBankModel * model = self.dataArr[indexPath.row];
            NSDictionary * dic = @{@"payType":@"2",@"bankId":model.id?model.id:@"",@"payName":model.bank_name?model.bank_name:@"",@"payNo":model.bank_no?model.bank_no:@""};
            self.typeBlock(dic);

        }
        
    }else {
        if (indexPath.row == 0) {
            NSDictionary * dic = @{@"payType":@"1",@"bankId":@"",@"payName":@"余额支付",@"payNo":@""};
            self.typeBlock(dic);


        }else if (indexPath.row == self.dataArr.count + 1) {
            QCAddBankViewController * addBankViewController = [[QCAddBankViewController alloc] init];
            addBankViewController.hidesBottomBarWhenPushed = YES;
            [[QCClassFunction currentNC] pushViewController:addBankViewController animated:YES];


        }else{
            //  选择银行卡
            QCBankModel * model = self.dataArr[indexPath.row];
            NSDictionary * dic = @{@"payType":@"2",@"bankId":model.id?model.id:@"",@"payName":model.bank_name?model.bank_name:@"",@"payNo":model.bank_no?model.bank_no:@""};
            self.typeBlock(dic);
        }
        
    }
   
    [[self superview] removeFromSuperview];

    

}



@end
