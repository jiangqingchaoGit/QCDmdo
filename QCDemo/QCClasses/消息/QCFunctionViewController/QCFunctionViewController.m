//
//  QCFunctionViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCFunctionViewController.h"
#import "QCFunctionCell.h"

//  添加好友
#import "QCAddFriendsViewController.h"
#import "SWQRCodeConfig.h"
#import "SWQRCodeViewController.h"
@interface QCFunctionViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation QCFunctionViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}


//在页面消失的时候就让navigationbar还原样式

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    

    [self createTableView];
}

- (void)functionAction:(UIButton *)sender {
    
    NSLog(@"%ld",sender.tag);
    
    [self dismissViewControllerAnimated:NO completion:^{

        
        switch (sender.tag) {
            case 1:
            {
                QCAddFriendsViewController * addFriendsViewController = [[QCAddFriendsViewController alloc] init];
                addFriendsViewController.hidesBottomBarWhenPushed = YES;
                [self.messageViewController.navigationController pushViewController:addFriendsViewController animated:YES];
            }
                break;
            case 2:
            {
                //  发起群聊
            }
                break;
            case 3:
            {
                SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
                config.scannerType = SWScannerTypeBoth;
                            
                SWQRCodeViewController *qrcodeVC = [[SWQRCodeViewController alloc]init];
                qrcodeVC.codeConfig = config;
                [self.messageViewController.navigationController pushViewController:qrcodeVC animated:YES];
            }
                break;
            case 4:
            {
                //  帮助
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - initUI

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    
    
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(20), KSCALE_WIDTH(170), KSCALE_WIDTH(200)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCFunctionCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(50);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * titleArr = @[@"添加朋友",@"发起群聊",@"扫一扫",@"帮助"];
    if (indexPath.row == 3) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
    }
    cell.contentLabel.text = titleArr[indexPath.row];
    [cell.functionButton addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.functionButton.tag = indexPath.row + 1;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}


@end
