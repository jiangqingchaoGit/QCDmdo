//
//  QCAddInactiveTimeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddInactiveTimeViewController.h"
#import "QCChooseTimeCell.h"
#import "QCInactiveViewController.h"
@interface QCAddInactiveTimeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) QCChooseTimeCell * currentCell;

@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) NSString * timeStr;

@end

@implementation QCAddInactiveTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self createTableView];
    
    self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(300), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    self.addButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC33"];
    self.addButton.titleLabel.font = K_18_FONT;
    self.addButton.alpha = 0.5;
    self.addButton.userInteractionEnabled = NO;
    [self.addButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.addButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.addButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.addButton];
}


- (void)addAction:(UIButton *)sender {
    
    NSString * out_uid = [NSString stringWithFormat:@"%@,",self.fuid];
    
    NSString * type = @"is_mute";

    NSString * str = [NSString stringWithFormat:@"fuid=%@&group_id=%@&%@=%@&time=%@&token=%@&uid=%@",out_uid,self.group_id,type,@"1",self.timeStr,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":out_uid,@"group_id":self.group_id,@"time":self.timeStr,type:@"1",@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    
    
    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",type] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
                        
            
            QCInactiveViewController * inactiveViewController = [self.navigationController.viewControllers objectAtIndex:4];
            [self.navigationController popToViewController:inactiveViewController animated:YES];
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



- (void)initUI{
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"选择禁言时间";
    

}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[QCChooseTimeCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)chooseAction:(UIButton *)sender {
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(52);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCChooseTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    NSArray * timeArr = @[@"禁言10分钟",@"禁言半小时",@"禁言一小时",@"禁言12小时",@"永久禁言"];
    cell.timeLabel.text = timeArr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QCChooseTimeCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.currentCell) {
        self.currentCell.chooseButton.selected = NO;
    }
    if (cell.chooseButton.selected == YES) {
        cell.chooseButton.selected = NO;
    }else{
        cell.chooseButton.selected = YES;
    }
    self.currentCell = cell;
    
    switch (indexPath.row) {
        case 0:
            self.timeStr = @"10";
            break;
        case 1:
            self.timeStr = @"30";

            break;
        case 2:
            self.timeStr = @"60";

            break;
        case 3:
            self.timeStr = @"720";

            break;
        case 4:
            self.timeStr = @"99999999";

            break;
            
        default:
            break;
    }
    
    if (self.timeStr) {
        
        self.addButton.alpha = 1;
        self.addButton.userInteractionEnabled = YES;
    }
}



@end
