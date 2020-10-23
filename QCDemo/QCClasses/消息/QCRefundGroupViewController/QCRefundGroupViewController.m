//
//  QCRefundGroupViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCRefundGroupViewController.h"
#import "QCRefundCell.h"
//  退群成员
@interface QCRefundGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * selfButton;
@property (nonatomic, strong) UIButton * passiveButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;

@end

@implementation QCRefundGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - tapAction
- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:

            self.selfButton.selected = YES;
            self.passiveButton.selected = NO;
            self.selfButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
            self.passiveButton.backgroundColor = KCLEAR_COLOR;
            break;
        case 2:
            self.passiveButton.selected = YES;
            self.selfButton.selected = NO;
            self.passiveButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
            self.selfButton.backgroundColor = KCLEAR_COLOR;
            break;

            
        default:
            break;
    }
}
#pragma mark - initUI

- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"退群成员";
    

    
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
    [self.tableView registerClass:[QCRefundCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(52))];
    

    
    NSArray * titleArr = @[@"自己退群",@"被移出群"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(72) + i * KSCALE_WIDTH(126), KSCALE_WIDTH(5), KSCALE_WIDTH(105), KSCALE_WIDTH(32))];
        button.backgroundColor = KCLEAR_COLOR;
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#FFFFFF"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(5)];
        
        [self.headerView addSubview:button];
        
        switch (i) {
            case 0:
                self.selfButton = button;
                self.selfButton.selected = YES;
                self.selfButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
                break;
            case 1:
                
                self.passiveButton = button;

                break;

                
            default:
                break;
        }

    }
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(67);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCRefundCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
