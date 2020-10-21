//
//  QCGroupViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupViewController.h"
#import "QCGroupCell.h"

@interface QCGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UILabel * numberLabel;

@end

@implementation QCGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    
}


#pragma mark - tapAction
- (void)rightAction:(UIButton *)sender {
    
}

- (void)searchAction:(UIButton *)sender {
    
}

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationItem.title = @"添加群成员";
    
 
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(60), KSCALE_WIDTH(44))];

    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(7), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
    self.numberLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    self.numberLabel.text = @"确认(1)";
    self.numberLabel.textColor = KBACK_COLOR;
    self.numberLabel.font = K_14_FONT;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [QCClassFunction filletImageView:self.numberLabel withRadius:KSCALE_WIDTH(3)];
    
    [view addSubview:self.numberLabel];
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
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCGroupCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    UILabel * searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(6), KSCALE_WIDTH(100) , KSCALE_WIDTH(38))];
    searchLabel.text = @"多多好/手机号";
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
    QCGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}


//添加TableView头视图标题

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {


    return @[@"A",@"B",@"C"][section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"A",@"B",@"C"];
}


//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index]; // -1 添加了搜索标识
    }
}





@end
