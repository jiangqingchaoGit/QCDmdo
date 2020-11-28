//
//  QCAddGroupManagerViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddGroupManagerViewController.h"
#import "QCGroupManagerCell.h"
#import "QCGroupManagerViewController.h"
@interface QCAddGroupManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@end

@implementation QCAddGroupManagerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self GETDATA];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    [self initUI];
    [self createTableView];
    [self createFooterView];
    
}

- (void)GETDATA {
    
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&token=%@&uid=%@&user_type=%@",self.group_id,K_TOKEN,K_UID,@"2"];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"token":K_TOKEN,@"uid":K_UID,@"user_type":@"2"};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_member" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            for (NSDictionary * dic in responseObject[@"data"]) {
                QCGroupDataModel * model = [[QCGroupDataModel alloc] initWithDictionary:dic error:nil];
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
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    
}

- (void)addAction:(UIButton *)sender {
    QCGroupManagerViewController * groupManagerViewController = [[QCGroupManagerViewController alloc] init];
    groupManagerViewController.numberArr = self.numberArr;
    groupManagerViewController.group_id = self.group_id;

    groupManagerViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:groupManagerViewController animated:YES];
}
#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"添加群管理";
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:KHeaderImage];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375),KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCGroupManagerCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:self.tableView];
    
    
}


- (void)createFooterView {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_HEIGHT(667) - KNavHight - KSCALE_WIDTH(62), KSCALE_WIDTH(375), KSCALE_WIDTH(62))];
    self.footerView.backgroundColor = KBACK_COLOR;
    [self.view addSubview:self.footerView];
    
    UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    addButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC33"];
    addButton.titleLabel.font = K_18_FONT;
    [addButton setTitle:@"新增管理员" forState:UIControlStateNormal];
    [addButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:addButton withRadius:KSCALE_WIDTH(13)];
    [self.footerView addSubview:addButton];
    
}

- (void)deletAction:(UIButton *)sender {
    
    
    QCGroupManagerCell * cell = (QCGroupManagerCell *)[[sender superview]superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCGroupDataModel * model = self.dataArr[indexPath.row];
    
    

    //  移除群聊
    NSString * str = [NSString stringWithFormat:@"group_id=%@&muid=%@&token=%@&uid=%@&user_type=%@",self.group_id,[NSString stringWithFormat:@"%@,",model.uid],K_TOKEN,K_UID,@"1"];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,@"muid":[NSString stringWithFormat:@"%@,",model.uid],@"token":K_TOKEN,@"uid":K_UID,@"user_type":@"1"};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_manage" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self GETDATA];
            
            
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
    
    return KSCALE_WIDTH(72);
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCGroupDataModel * model = self.dataArr[indexPath.row];
    QCGroupManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell.deletButton addTarget:self action:@selector(deletAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell fillCellWithModel:model];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}




@end
