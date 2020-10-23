//
//  QCAddGroupManagerViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddGroupManagerViewController.h"
#import "QCGroupManagerCell.h"
#import "QCGroupViewController.h"
@interface QCAddGroupManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * footerView;

@end

@implementation QCAddGroupManagerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];
    [self createFooterView];

}

#pragma mark - tapAction
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    
}

- (void)addAction:(UIButton *)sender {
    QCGroupViewController * groupViewController = [[QCGroupViewController alloc] init];
    groupViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:groupViewController animated:YES];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];

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
#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return KSCALE_WIDTH(72);

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCGroupManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}




@end
