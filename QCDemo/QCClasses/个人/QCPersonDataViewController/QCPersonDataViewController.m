//
//  QCPersonDataViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonDataViewController.h"
#import "QCPersonDataCell.h"
#import "QCChangeNicknameViewController.h"
#import "QCPersonCodeViewController.h"
@interface QCPersonDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * idLabel;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;

@end

@implementation QCPersonDataViewController

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
    
    
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}


#pragma mark - tapAction
- (void)copyAction:(UIButton *)sender {
    
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title  = @"个人资料";
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
    [self.tableView registerClass:[QCPersonDataCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(195))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(154.5), KSCALE_WIDTH(20), KSCALE_WIDTH(66), KSCALE_WIDTH(66))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(33)];
    [self.headerView addSubview:self.headerImageView];
    
    self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(90), KSCALE_WIDTH(375), KSCALE_WIDTH(30))];
    self.idLabel.text = @"多多号:182836238";
    self.idLabel.font = K_14_FONT;
    self.idLabel.textAlignment = NSTextAlignmentCenter;
    self.idLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    [self.headerView addSubview:self.idLabel];
    
    UIButton * copyButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(160), KSCALE_WIDTH(120), KSCALE_WIDTH(55), KSCALE_WIDTH(30))];
    copyButton.titleLabel.font = K_12_FONT;
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [copyButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:copyButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(179), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.headerView addSubview:lineView];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(50);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * titleArr = @[@"电话",@"昵称",@"我的二维码"];
    NSArray * contentArr = @[@"18672910380",@"思绪云骞",@""];

    QCPersonDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = titleArr[indexPath.row];
    cell.contentLabel.text = contentArr[indexPath.row];
    cell.picImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.row == 2) {
        cell.picImageView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
        {
            QCChangeNicknameViewController * changeNicknameViewController = [[QCChangeNicknameViewController alloc] init];
            changeNicknameViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:changeNicknameViewController animated:YES completion:nil];
        }
            break;
        case 2:
        {
            QCPersonCodeViewController * personCodeViewController = [[QCPersonCodeViewController alloc] init];
            personCodeViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personCodeViewController animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}


@end
