//
//  GroupManagerViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "GroupManagerViewController.h"
#import "QCGroupDataCell.h"
#import "GroupManagerCell.h"
//  设置管理员
#import "QCAddGroupManagerViewController.h"
//  不活跃成员
#import "QCInactiveViewController.h"
//  退群成员
#import "QCRefundGroupViewController.h"
//  新群管理
#import "QCNewGroupManagerViewController.h"
//  群助手
#import "QCAssistantViewController.h"
@interface GroupManagerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;



@end

@implementation GroupManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];}

#pragma mark - tapAction

#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"群管理";
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
    [self.tableView registerClass:[QCGroupDataCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[GroupManagerCell class] forCellReuseIdentifier:@"managerCell"];

    
    [self.view addSubview:self.tableView];
    
    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;

            break;
        case 2:
            return 3;

            break;
        case 3:
            return 1;

            break;
            
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return KSCALE_WIDTH(11);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = KCLEAR_COLOR;
    
    if (section != 3) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(5), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [view addSubview:lineView];
    }

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 2) {
        
        return KSCALE_WIDTH(60);

    }else{
        return KSCALE_WIDTH(46);

    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * arr = @[@[@"设置管理员",@"群成员管理",@"退群成员"],@[@"营销助手"],@[@"群成员保护模式",@"加群验证",@"风控拦截"],@[@"群主管理权转让"]];
    NSArray * titleArr = @[@"开启后，群成员不是好友不可互看资料",@"开启后，需群主或管理员同意后才可加入群聊",@"开启后，成员不能发送网址、电话与二维码图片"];

    
    if (indexPath.section == 2) {
        
        GroupManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"managerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = arr[indexPath.section][indexPath.row];
        cell.contentLabel.text = titleArr[indexPath.row];
        cell.chooseSwitch.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;

    }else{
        QCGroupDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = arr[indexPath.section][indexPath.row];
        
        switch (indexPath.section) {
            case 0:
                cell.chooseSwitch.hidden = YES;
                cell.headerImageView.hidden = YES;

                break;
            case 1:

                cell.contentLabel.hidden = YES;
                cell.headerImageView.hidden = YES;
                cell.chooseSwitch.hidden = YES;
                cell.titleLabel.textColor = [QCClassFunction stringTOColor:@"#F42011"];

                break;
            case 2:

                break;
            case 3:
                cell.contentLabel.hidden = YES;
                cell.headerImageView.hidden = YES;
                cell.chooseSwitch.hidden = YES;
                break;

                
            default:
                break;
        }
        return cell;
    }

    

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    QCAddGroupManagerViewController * addGroupManagerViewController = [[QCAddGroupManagerViewController alloc] init];
                    addGroupManagerViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:addGroupManagerViewController animated:YES];
                }
                    break;
                case 1:
                {
                    QCInactiveViewController * inactiveViewController = [[QCInactiveViewController alloc] init];
                    inactiveViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:inactiveViewController animated:YES];
                }
                    break;
                case 2:
                {

                    QCRefundGroupViewController * refundGroupViewController = [[QCRefundGroupViewController alloc] init];
                    refundGroupViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:refundGroupViewController animated:YES];
                }
                    break;

                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            QCAssistantViewController * assistantViewController = [[QCAssistantViewController alloc] init];
            assistantViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:assistantViewController animated:YES];
        }
            break;
        case 2:

            
            break;
        case 3:
        {
            QCNewGroupManagerViewController * newGroupManagerViewController = [[QCNewGroupManagerViewController alloc] init];
            newGroupManagerViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newGroupManagerViewController animated:YES];
        }
            
            break;

        default:
            break;
    }
    
}





@end
