//
//  QCEnvelopeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCEnvelopeViewController.h"
#import "QCEnvelopCell.h"

@interface QCEnvelopeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * numberLabel;

@property (nonatomic, strong) UIButton * incomeButton;
@property (nonatomic, strong) UIButton * spendingButton;
@property (nonatomic, strong) UIButton * withdrawalButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;

@end

@implementation QCEnvelopeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - tapAction

- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

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



            break;
        case 2:
            self.incomeButton.selected = NO;
            self.spendingButton.selected = YES;
            self.withdrawalButton.selected = NO;
            self.incomeButton.backgroundColor = KCLEAR_COLOR;
            self.spendingButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
            self.withdrawalButton.backgroundColor = KCLEAR_COLOR;

            break;

            
        default:
            break;
    }
}
#pragma mark - initUI

- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"红包明细";
    

    
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
    [self.tableView registerClass:[QCEnvelopCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(235) + KTabHight)];
    self.headerView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.view addSubview:self.headerView];

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(160) + KTabHight)];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    [self.headerView addSubview:view];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KStatusHight, KSCALE_WIDTH(175), KSCALE_WIDTH(44))];
    titleLabel.font = KSCALE_FONT(16);
    titleLabel.textColor = KBACK_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"红包明细";
    titleLabel.backgroundColor = KCLEAR_COLOR;
    [self.headerView addSubview:titleLabel];
    
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.backButton];
    

    UILabel * balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KStatusHight + KSCALE_WIDTH(60), KSCALE_WIDTH(200), KSCALE_WIDTH(16))];
    balanceLabel.text = @"收到红包共计（元）";
    balanceLabel.font = K_14_FONT;
    balanceLabel.textColor = [QCClassFunction stringTOColor:@"#FFFFFF"];;
    [self.headerView addSubview:balanceLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KStatusHight + KSCALE_WIDTH(80), KSCALE_WIDTH(200), KSCALE_WIDTH(40))];
    self.moneyLabel.text = @"0.00";
    self.moneyLabel.font = K_40_BFONT;
    self.moneyLabel.textColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.headerView addSubview:self.moneyLabel];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KStatusHight + KSCALE_WIDTH(140), KSCALE_WIDTH(200), KSCALE_WIDTH(16))];
    self.numberLabel.text = @"红包总数：999个";
    self.numberLabel.font = K_14_FONT;
    self.numberLabel.textColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    [self.headerView addSubview:self.numberLabel];
    
    UIView * chooseView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(190) + KTabHight, KSCALE_WIDTH(335), KSCALE_WIDTH(35))];
    chooseView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [QCClassFunction filletImageView:chooseView withRadius:KSCALE_WIDTH(4)];
    [self.headerView addSubview:chooseView];
    
    NSArray * titleArr = @[@"我收到的红包",@"我发出的红包"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5) + i * KSCALE_WIDTH(175), KSCALE_WIDTH(3), KSCALE_WIDTH(150), KSCALE_WIDTH(29))];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i + 1;
        button.titleLabel.font = K_14_FONT;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#999999"] forState:UIControlStateNormal];
        [button setTitleColor:[QCClassFunction stringTOColor:@"#363636"] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [QCClassFunction filletImageView:button withRadius:KSCALE_WIDTH(2)];
        
        [chooseView addSubview:button];
        
        switch (i) {
            case 0:
                self.incomeButton = button;
                self.incomeButton.selected = YES;
                self.incomeButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
                break;
            case 1:
                self.spendingButton = button;
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
    return KSCALE_WIDTH(60);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCEnvelopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}

@end
