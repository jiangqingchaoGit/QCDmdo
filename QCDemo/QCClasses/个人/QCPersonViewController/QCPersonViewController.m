//
//  QCPersonViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonViewController.h"
#import "QCPersonHeaderView.h"
#import "QCPersonCell.h"

//  我的钱包
#import "QCWalletViewController.h"
@interface QCPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) QCPersonHeaderView * headerView;

@end

@implementation QCPersonViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
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
    [self.tableView registerClass:[QCPersonCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[QCPersonHeaderView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(300) + KStatusHight)];
    self.headerView.backgroundColor = KBACK_COLOR;
    [self.headerView initUI];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(55);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCPersonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray * titleArr = @[@"钱包",@"帮助",@"客服",@"设置"];
    cell.headerImageView.image = [UIImage imageNamed:titleArr[indexPath.row]];
    cell.titleLabel.text = titleArr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            QCWalletViewController * walletViewController = [[QCWalletViewController alloc] init];
            walletViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:walletViewController animated:YES];
        }
            break;
            
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}




@end
