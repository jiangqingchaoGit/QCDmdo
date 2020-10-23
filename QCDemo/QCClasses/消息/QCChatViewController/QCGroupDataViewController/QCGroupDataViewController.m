//
//  QCGroupDataViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/21.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupDataViewController.h"
//  群资料
#import "QCGroupDataCell.h"
#import "QCGroupItem.h"

//  群管理
#import "GroupManagerViewController.h"
@interface QCGroupDataViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footView;

@property (nonatomic, strong) UICollectionView * collectionView;


@end

@implementation QCGroupDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self createCollectionView];
}

#pragma mark - tapAction
- (void)dissolutionAction:(UIButton *)sender {
    
}


#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"聊天信息(6)";
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
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(210))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(204), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [self.headerView addSubview:lineView];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(375), KSCALE_WIDTH(50))];
    self.tableView.tableFooterView = self.footView;
    UIButton * dissolutionButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(375), KSCALE_WIDTH(45))];
    dissolutionButton.backgroundColor = KCLEAR_COLOR;
    dissolutionButton.titleLabel.font =K_18_FONT;
    [dissolutionButton setTitle:@"解散本群" forState:UIControlStateNormal];
    [dissolutionButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [dissolutionButton addTarget:self action:@selector(dissolutionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:dissolutionButton];
    
    
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //  4:3
    layout.itemSize = CGSizeMake(KSCALE_WIDTH(60),KSCALE_WIDTH(95));
    layout.minimumInteritemSpacing = KSCALE_WIDTH(8.75);
    layout.minimumLineSpacing =  KSCALE_WIDTH(0);
    layout.sectionInset = UIEdgeInsetsMake(0, KSCALE_WIDTH(20), 0, KSCALE_WIDTH(20));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,KSCALE_WIDTH(10),KSCALE_WIDTH(375),KSCALE_WIDTH(190)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = KBACK_COLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[QCGroupItem class] forCellWithReuseIdentifier:@"item"];
    [self.headerView addSubview:self.collectionView];
    

}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;

            break;
        case 2:
            return 2;

            break;
        case 3:
            return 4;

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
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(5), KSCALE_WIDTH(345), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
    [view addSubview:lineView];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(46);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * arr = @[@[@"群名称",@"群头像",@"我在本群昵称",@"群号/群二维码"],@[@"聊天置顶",@"消息免打扰"],@[@"群管理",@"长时间未领取的红包"],@[@"查找聊天内容",@"发布群公告",@"清空聊天记录",@"举报投诉"]];
    QCGroupDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = arr[indexPath.section][indexPath.row];
    
    switch (indexPath.section) {
        case 0:
            cell.chooseSwitch.hidden = YES;

            if (indexPath.row == 1) {
                cell.contentLabel.hidden = YES;
                cell.headerImageView.hidden = NO;
                cell.accessoryType = UITableViewCellAccessoryNone;


            }else{
                cell.contentLabel.hidden = NO;
                cell.headerImageView.hidden = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


            }
            break;
        case 1:

            cell.contentLabel.hidden = YES;
            cell.headerImageView.hidden = YES;
            cell.chooseSwitch.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;


            break;
        case 2:
            cell.contentLabel.hidden = YES;
            cell.headerImageView.hidden = YES;
            cell.chooseSwitch.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:

            cell.contentLabel.hidden = YES;
            cell.headerImageView.hidden = YES;
            cell.chooseSwitch.hidden = YES;
            if (indexPath.row == 0 || indexPath.row == 3) {

                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;

            }
            break;
            
        default:
            break;
    }
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:

                    break;
                case 1:
                    
                    break;

                    
                default:
                    break;
            }
            break;

        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    
                    //  群管理
                    GroupManagerViewController * groupManagerViewController = [[GroupManagerViewController alloc] init];
                    groupManagerViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:groupManagerViewController animated:YES];
                }
                    break;
                case 1:
                    
                    break;

                    
                default:
                    break;
            }
            break;

        case 3:
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    
                    break;
                case 2:
                    
                    break;
                case 3:
                    
                    break;
                    
                default:
                    break;
            }
            break;

            
        default:
            break;
    }
    
}








#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCGroupItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        item.identityLabel.hidden = NO;
    }else{
        item.identityLabel.hidden = YES;

    }
    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}







@end
