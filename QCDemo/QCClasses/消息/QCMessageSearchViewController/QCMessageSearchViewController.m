//
//  QCMessageSearchViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCMessageSearchViewController.h"
#import "QCSearchCell.h"
@interface QCMessageSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField * searchTextField;
@property (nonatomic, strong) UIButton * cancelButton;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footerView;

@end

@implementation QCMessageSearchViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}



#pragma mark - tapAction

- (void)resignAction {
    [self.searchTextField resignFirstResponder];
}

- (void)cancelAction:(UIButton *)sender {
    [self.searchTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];;

    
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(6) + KStatusHight, KSCALE_WIDTH(305) , KSCALE_WIDTH(38))];
    searchView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = KSCALE_WIDTH(3);
    [self.view addSubview:searchView];
    
    UIImageView * searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(18) + KStatusHight, KSCALE_WIDTH(14) , KSCALE_WIDTH(14))];
    searchImageView.image = KHeaderImage;
    [self.view addSubview:searchImageView];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(6) + KStatusHight, KSCALE_WIDTH(200) , KSCALE_WIDTH(38))];
    self.searchTextField.placeholder = @"请输入搜索关键字";
    self.searchTextField.font = K_14_BFONT;
    self.searchTextField.textColor = [QCClassFunction stringTOColor:@"#333333"];
    self.searchTextField.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.searchTextField];
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(320), KSCALE_WIDTH(6) + KStatusHight, KSCALE_WIDTH(55), KSCALE_WIDTH(38))];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = K_16_FONT;
    [self.cancelButton setTitleColor:[QCClassFunction stringTOColor:@"#000000"] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavHight, KSCALE_WIDTH(375), KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCSearchCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)createHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375), KSCALE_WIDTH(50))];
    self.headerView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(5), KSCALE_WIDTH(300), KSCALE_WIDTH(40))];
    label.text = @"联系人";
    label.font = K_14_FONT;
    label.textColor = KTEXT_COLOR;
    [self.headerView addSubview:label];
    self.tableView.tableHeaderView = self.headerView;
    
}




#pragma mark - UITableViewDelegate,UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(82);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}



@end
