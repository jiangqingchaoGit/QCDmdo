//
//  QCInactiveViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCInactiveViewController.h"
#import "QCInactiveCell.h"
#import "QCGroupViewController.h"
@interface QCInactiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;
@end

@implementation QCInactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];
    [self createHeaderView];

}

#pragma mark - tapAction
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    QCGroupViewController * groupViewController = [[QCGroupViewController alloc] init];
    groupViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:groupViewController animated:YES];
}

- (void)buttonAction:(UIButton *)sender {

    
    switch (sender.tag) {
        case 1:
            self.incomeButton.selected = YES;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            self.rightButton.hidden = YES;



            break;
        case 2:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;
            self.rightButton.hidden = NO;

            break;
        case 3:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = NO;
            self.withdrawalButton.selected = YES;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = KCLEAR_COLOR;
            self.withdrawalButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.rightButton.hidden = NO;

            break;
            
        default:
            break;
    }
    [self GETDATA];
    
    
}

#pragma mark - GETDATA
- (void)GETDATA {
    
}
#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"群成员管理";
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.rightButton.titleLabel.font = K_16_FONT;
    self.rightButton.hidden = YES;
    [self.rightButton setTitleColor:[QCClassFunction stringTOColor:@"#666666"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
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
    [self.tableView registerClass:[QCInactiveCell class] forCellReuseIdentifier:@"cell"];

    
    [self.view addSubview:self.tableView];
    
    
}


- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(45))];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:view withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:view];
    
    NSArray * titleArr = @[@"7天不活跃",@"禁止发言",@"禁止领红包"];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(111), KSCALE_WIDTH(3), KSCALE_WIDTH(103), KSCALE_WIDTH(29))];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(2)];
        
        [view addSubview:button];
        
        switch (i) {
            case 0:
                self.incomeButton = button;
                self.incomeButton.selected = YES;
                self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
                break;
            case 1:
                self.spendingButton = button;
                break;
            case 2:
                self.withdrawalButton = button;
                break;
                
            default:
                break;
        }

    }
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return KSCALE_WIDTH(72);

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCInactiveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}



@end
