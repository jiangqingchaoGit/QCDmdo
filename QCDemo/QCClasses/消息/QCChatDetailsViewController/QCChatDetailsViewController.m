//
//  QCChatDetailsViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/17.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChatDetailsViewController.h"
#import "QCChatDetailsCell.h"
#import "QCListModel.h"

#import "QCGroupViewController.h"
#import "QCMessageSearchViewController.h"

@interface QCChatDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;



@end

@implementation QCChatDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - tapAction
- (void)addAction:(UIButton *) sender {
    QCGroupViewController * groupViewController = [[QCGroupViewController alloc] init];
    groupViewController.hidesBottomBarWhenPushed = YES;
    groupViewController.listModel = self.listModel;
    [self.navigationController pushViewController:groupViewController animated:YES];
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"聊天详情";
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(375),KSCREEN_HEIGHT - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.tableView.sectionIndexColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCChatDetailsCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(375), KSCALE_WIDTH(110))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:self.listModel.uhead AppendingString:@"" placeholderImage:@"header"];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.headerView addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(72), KSCALE_WIDTH(52), KSCALE_WIDTH(20))];
    self.nameLabel.font = K_12_FONT;
    self.nameLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.text = self.listModel.unick;
    [self.headerView addSubview:self.nameLabel];
    
    UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(15), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    [addButton setImage:[UIImage imageNamed:@"add_chat"] forState:UIControlStateNormal];
    [QCClassFunction filletImageView:addButton withRadius:KSCALE_WIDTH(26)];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:addButton];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;

            break;
        case 1:
            return 2;

            break;
        case 2:
            return 1;

            break;
        case 3:
            return 1;

            break;
        default:
            break;
    }
    return 0;

        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return KSCALE_WIDTH(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(52);

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCChatDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    switch (indexPath.section) {
        case 0:
            cell.chooseSwitch.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            break;
        case 1:
            cell.chooseSwitch.hidden = NO;
            
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
            cell.chooseSwitch.hidden = YES;

            break;
        case 3:
            cell.chooseSwitch.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


            break;
        default:
            break;
    }
    
    NSArray * titleArr = @[@[@"查找聊天内容"],@[@"消息免打扰",@"置顶聊天"],@[@"清空聊天记录"],@[@"投诉"]];
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            //  查找聊天记录
        {
            QCMessageSearchViewController * messageSearchViewController = [[QCMessageSearchViewController alloc] init];
            messageSearchViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageSearchViewController animated:YES];
        }
            break;
        case 1:

            

            
            break;
        case 2:
            //  清空聊天记录  删除某条数据库
        {
            
            QCChatModel * chatModel = [[QCChatModel alloc] init];
            chatModel.listId = self.listModel.listId;
            [[QCDataBase shared] deleteChatModel:chatModel];

        }
            break;
        case 3:
            //  投诉
            break;
            
        default:
            break;
    }
}

@end
