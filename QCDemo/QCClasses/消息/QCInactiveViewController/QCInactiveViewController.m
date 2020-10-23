//
//  QCInactiveViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCInactiveViewController.h"
#import "QCInactiveCell.h"

#import "QCDeletInactiveViewController.h"
//  不活跃成员
@interface QCInactiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * rightButton;
@end

@implementation QCInactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];

}

#pragma mark - tapAction
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    QCDeletInactiveViewController * deletInactiveViewController = [[QCDeletInactiveViewController alloc] init];
    deletInactiveViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:deletInactiveViewController animated:YES];
}


#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"不活跃成员";
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,0,0)];
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.rightButton.titleLabel.font = K_16_FONT;
    [self.rightButton setTitleColor:[QCClassFunction stringTOColor:@"#666666"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
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
