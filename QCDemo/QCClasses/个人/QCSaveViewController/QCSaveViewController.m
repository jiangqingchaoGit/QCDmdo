//
//  QCSaveViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSaveViewController.h"
#import "QCPersonSaveCell.h"
// 更换手机号
#import "QCPersonBindingViewController.h"
// 忘记登录密码
#import "QCForgetPasswordViewController.h"
// 修改登录密码
#import "QCChangePasswordViewController.h"
// 手势密码
#import "QCTouchpasswordViewController.h"
// 注销账号
#import "QCCancellationViewController.h"
#import "YWUnlockView.h"

@interface QCSaveViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footView;

@end

@implementation QCSaveViewController

-(void)viewWillAppear:(BOOL)animated {
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
- (void)dissolutionAction:(UIButton *)sender {
    
    QCCancellationViewController * cancellationViewController = [[QCCancellationViewController alloc] init];
    cancellationViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:cancellationViewController animated:YES completion:nil];
}


#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"安全";
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
    [self.tableView registerClass:[QCPersonSaveCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(130))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(137.5), KSCALE_WIDTH(5), KSCALE_WIDTH(100), KSCALE_WIDTH(100))];
    headerImageView.image = [UIImage imageNamed:@"safety"];
    headerImageView.contentMode = UIViewContentModeCenter;
    [self.headerView addSubview:headerImageView];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_HEIGHT(667) - KNavHight - KSCALE_WIDTH(51), KSCALE_WIDTH(375), KSCALE_WIDTH(51))];
    [self.view addSubview:self.footView];

    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.footView addSubview:lineView];
    
    UIButton * dissolutionButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(1), KSCALE_WIDTH(375), KSCALE_WIDTH(45))];
    dissolutionButton.backgroundColor = KBACK_COLOR;
    dissolutionButton.titleLabel.font =K_18_FONT;
    [dissolutionButton setTitle:@"注销账号" forState:UIControlStateNormal];
    [dissolutionButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [dissolutionButton addTarget:self action:@selector(dissolutionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:dissolutionButton];
    
    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return 4;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(46);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * titleArr = @[@"修改登录密码",@"忘记登录密码",@"更换手机号",@"应用锁"];
    QCPersonSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = titleArr[indexPath.row];
    
    cell.contentLabel.hidden = YES;
    cell.chooseSwitch.hidden = YES;

    if (indexPath.row == 3) {
        cell.contentLabel.hidden = NO;
        cell.chooseSwitch.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;

    }else{
        
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            QCChangePasswordViewController * changePasswordViewController = [[QCChangePasswordViewController alloc] init];
            changePasswordViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:changePasswordViewController animated:YES];
        }
            break;
        case 1:
        {
            QCForgetPasswordViewController * forgetPasswordViewController = [[QCForgetPasswordViewController alloc] init];
            forgetPasswordViewController.hidesBottomBarWhenPushed = YES;
            forgetPasswordViewController.phoneStr = K_PHONE;


            [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
        }
            break;
        case 2:
        {
            QCPersonBindingViewController * personBindingViewController = [[QCPersonBindingViewController alloc] init];
            personBindingViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:personBindingViewController animated:YES];
        }
            break;
        case 3:
        {

            [YWUnlockView showUnlockViewWithType:YWUnlockViewCreate callBack:^(BOOL result) {
                NSLog(@"-->%@",@(result));
            }];
        }
            break;
            
            
        default:
            break;
    }
}


@end
