//
//  QCMessageViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCMessageViewController.h"
#import "QCMessageCell.h"
#import "QCFunctionViewController.h"

//  添加朋友
#import "QCAddFriendsViewController.h"
//  发起群聊
#import "QCGroupViewController.h"
//  扫一扫
//  帮助
@interface QCMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) QCFunctionViewController * functionViewController;
@end

@implementation QCMessageViewController


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
- (void)rightAction:(UITapGestureRecognizer *)sender {
    
    //  扫一扫
    
    //  初始化弹出控制器
    self.functionViewController = [QCFunctionViewController new];
    self.functionViewController.tableView.scrollEnabled=NO;
    //  背景色
    
    //  弹出视图的显示样式
    self.functionViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    //  1、弹出视图的大小
    self.functionViewController.preferredContentSize = CGSizeMake(KSCALE_WIDTH(170), KSCALE_WIDTH(208));
    
    //  弹出视图的代理
    self.functionViewController.popoverPresentationController.delegate = self;
    
    //  弹出视图的参照视图、从哪弹出
    self.functionViewController.popoverPresentationController.sourceView = sender.view;
    
    //  弹出视图的尖头位置：参照视图底边中间位置
    self.functionViewController.popoverPresentationController.sourceRect = sender.view.bounds;
    
    //  弹出视图的箭头方向
    self.functionViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    //  弹出
    [self presentViewController:self.functionViewController animated:YES completion:^{
        self.functionViewController.messageViewController = self;
    }];
    
    
}

- (void)searchAction:(UIButton *)sender {
    //  搜索
}

#pragma mark - initUI

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationItem.title = @"消息";
    

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:KHeaderImage];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];

    
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
    [self.tableView registerClass:[QCMessageCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(6), KSCALE_WIDTH(345) , KSCALE_WIDTH(38))];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.headerView addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(18), KSCALE_WIDTH(14) , KSCALE_WIDTH(14))];
    searchImageView.image = KHeaderImage;
    [self.headerView addSubview:searchImageView];
    
    UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(6), KSCALE_WIDTH(50) , KSCALE_WIDTH(38))];
    searchLabel.text = @"搜索";
    searchLabel.font = K_14_BFONT;
    searchLabel.textColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
    searchLabel.backgroundColor = [UIColor clearColor];
    [self.headerView addSubview:searchLabel];
    
    
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 50)];
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:searchButton];

    
        
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(72);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
        {
            QCGroupViewController * groupViewController = [[QCGroupViewController alloc] init];
            groupViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:groupViewController animated:YES];
        }
        default:
            break;
    }
    
}


- (BOOL) popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{

   return YES;

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{

    return UIModalPresentationNone;

}
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{



}



@end
