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
#import "QCGroupSetModel.h"
#import "QCGroupItem.h"
#import "QCGroupPersonModel.h"
//  群管理
#import "GroupManagerViewController.h"
//
#import "QCGroupChooseViewController.h"
#import "QCGroupDeleteViewController.h"

//  二维码
#import "QCPersonCodeViewController.h"
//  好友资料
#import "QCPersonCardViewController.h"
#import "QCBookModel.h"
#import "QCSearchViewController.h"
#import "QCMessageSearchViewController.h"

//  未领取的红包
#import "QCUngetEnvelopeViewController.h"

//  举报投诉
#import "QCComplaintsViewController.h"
@interface QCGroupDataViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>



@property (nonatomic, strong) NSMutableArray * messageArr;

@property (nonatomic, strong) QCGroupPersonModel * personModel;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * footView;

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIButton * dissolutionButton;
@property (nonatomic, strong) NSString * groupName;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * announcementStr;

@property (nonatomic, strong) NSIndexPath * indexPath;



@property (nonatomic, strong) NSData * headerImageData;//图片数据
@property (nonatomic, strong) UIImageView * dataImageView;//图片数据

@property (nonatomic,strong)UIImagePickerController * picker1;
@property (nonatomic,strong)UIImagePickerController * picker2;


@property (nonatomic, strong) NSTimer * messageTimer;
@property (nonatomic, strong) NSMutableArray * tipArr;

@end

@implementation QCGroupDataViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messageArr = [[NSMutableArray alloc] init];
    
    
    self.status = 0;
    
    [self initUI];
    [self createTableView];
    [self createHeaderView];
    [self createCollectionView];
    
    [self setSize];
    
    [self fillView];
    [self.collectionView reloadData];
    [self.tableView reloadData];
    
}

#pragma mark - GETGroupData
- (void)GETGroupData {
    
    NSString * str = [NSString stringWithFormat:@"id=%@&token=%@&uid=%@",self.groupId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"id":self.groupId,@"token":K_TOKEN,@"uid":K_UID};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.dataArr removeAllObjects];
            [self.personDataArr removeAllObjects];
            [self.groupDataArr removeAllObjects];
            
            
            for (NSDictionary * dic in responseObject[@"data"][@"list"]) {
                QCGroupDataModel * model = [[QCGroupDataModel alloc] initWithDictionary:dic error:nil];
                [self.dataArr addObject:model];
            }
            
            QCGroupSetModel * model = [[QCGroupSetModel alloc] initWithDictionary:responseObject[@"data"][@"group"] error:nil];
            [self.groupDataArr addObject:model];
            
            
            QCGroupPersonModel * personModel = [[QCGroupPersonModel alloc] initWithDictionary:responseObject[@"data"][@"user"] error:nil];
            [self.personDataArr addObject:personModel];
            
            
            
            [self setSize];
            [self fillView];
            [self.collectionView reloadData];
            [self.tableView reloadData];
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}




#pragma mark - tapAction

- (void)switchBtnAction:(UISwitch *)sender {
    
    
    
    QCGroupDataCell * cell = (QCGroupDataCell *)[[sender superview]superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (sender.isOn) {
        
        switch (indexPath.row) {
            case 0:
                //  聊天置顶
            {
                [[QCDataBase shared] upTopByListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId] withIsTop:@"1"];
            }
                break;
                
            case 1:
                //  消息免打扰
            {
                [[QCDataBase shared] upDisturbByListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId] withIsDisturb:@"1"];
                
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                [[QCDataBase shared] upTopByListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId] withIsTop:@"0"];
            }
                break;
                
            case 1:
            {
                
                [[QCDataBase shared] upDisturbByListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId] withIsDisturb:@"0"];
            }
                break;
                
            default:
                break;
        }
    }
    
    
    
    
    
    
}


- (void)dissolutionAction:(UIButton *)sender {
    
    NSString * statusStr;
    if (self.status == 3) {
        //  解散
        statusStr = @"disband";
    }else{
        statusStr = @"group_out";
        
    }
    
    //      退出
    NSString * str = [NSString stringWithFormat:@"group_id=%@&token=%@&uid=%@",self.groupId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.groupId,@"token":K_TOKEN,@"uid":K_UID};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",statusStr] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            
            QCChatModel * chatModel = [[QCChatModel alloc] init];
            chatModel.listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId];
            [[QCDataBase shared] deleteChatModel:chatModel];
            
            QCListModel * listModel = [[QCListModel alloc] init];
            listModel.listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId];
            [[QCDataBase shared] deleteListModel:listModel];

            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}



#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    
}

- (void)fillView {
    
    if (self.groupDataArr.count != 0) {
        QCGroupSetModel * model = [self.groupDataArr firstObject];
        self.title = model.name;
    }
    
    
    [self.messageArr removeAllObjects];
    
    QCGroupSetModel * model = [self.groupDataArr firstObject];
    QCGroupPersonModel * personModel = [self.personDataArr firstObject];
    [self.messageArr addObject:model.name];
    [self.messageArr addObject:model.head_img];
    [self.messageArr addObject:personModel.nick_name];
    [self.messageArr addObject:model.group_code];
    
}

- (void)setSize {
    
    self.personModel = [self.personDataArr firstObject];
    
    NSInteger peopleNum = 0;
    if ([self.personModel.user_type isEqualToString:@"1"]) {
        peopleNum = self.dataArr.count + 1;
        self.status = 1;
        [self.dissolutionButton setTitle:@"退出该群" forState:UIControlStateNormal];
        
    }else if ([self.personModel.user_type isEqualToString:@"2"]){
        peopleNum = self.dataArr.count + 2;
        self.status = 2;
        [self.dissolutionButton setTitle:@"退出该群" forState:UIControlStateNormal];
        
        
    }else if ([self.personModel.user_type isEqualToString:@"3"]) {
        peopleNum = self.dataArr.count + 2;
        self.status = 3;
        [self.dissolutionButton setTitle:@"解散本群" forState:UIControlStateNormal];
        
    }
    self.collectionView.frame = CGRectMake(0,KSCALE_WIDTH(10),KSCALE_WIDTH(375),KSCALE_WIDTH(95) * ((int)ceil(peopleNum / 5.0)));
    self.headerView.frame = CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335),  KSCALE_WIDTH(95) * ((int)ceil(peopleNum / 5.0)));
    
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
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(0))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(375), KSCALE_WIDTH(50))];
    self.tableView.tableFooterView = self.footView;
    self.dissolutionButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(375), KSCALE_WIDTH(45))];
    self.dissolutionButton.backgroundColor = KCLEAR_COLOR;
    self.dissolutionButton.titleLabel.font =K_18_FONT;
    [self.dissolutionButton setTitle:@"解散本群" forState:UIControlStateNormal];
    [self.dissolutionButton setTitleColor:[QCClassFunction stringTOColor:@"#FF3300"] forState:UIControlStateNormal];
    [self.dissolutionButton addTarget:self action:@selector(dissolutionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.dissolutionButton];
    
    
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return KSCALE_WIDTH(11);
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
                if ( self.messageArr.count > 0) {
                    [QCClassFunction sd_imageView:cell.headerImageView ImageURL:self.messageArr[indexPath.row] AppendingString:@"" placeholderImage:@"header"];
                    
                }
                
            }else{
                cell.contentLabel.hidden = NO;
                cell.headerImageView.hidden = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                if ( self.messageArr.count > 0) {
                    cell.contentLabel.text = self.messageArr[indexPath.row];
                    
                }
                
                if (indexPath.row == 0) {
                    if (self.status == 0) {
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        
                    }else if (self.status == 3) {
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                        
                    }else {
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        
                    }
                }
                
                
                
            }
            break;
        case 1:
            
        {
            cell.contentLabel.hidden = YES;
            cell.headerImageView.hidden = YES;
            cell.chooseSwitch.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            NSMutableArray * arr = [[QCDataBase shared] querywithListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId]];
            QCListModel * model = [arr firstObject];
            
            
            if (indexPath.row == 0) {
                if ([model.isTop isEqualToString:@"1"]) {
                    cell.chooseSwitch.on = YES;
                }else{
                    cell.chooseSwitch.on = NO;
                    
                }
            }
            
            if (indexPath.row == 1) {
                if ([model.disturb isEqualToString:@"1"]) {
                    cell.chooseSwitch.on = YES;
                }else{
                    cell.chooseSwitch.on = NO;
                    
                }
            }
            
            
            
            
            [cell.chooseSwitch addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventValueChanged | UIControlEventTouchDragExit];
            
        }
            
            break;
        case 2:
            cell.contentLabel.hidden = YES;
            cell.headerImageView.hidden = YES;
            cell.chooseSwitch.hidden = YES;
            
            if (indexPath.row == 0) {
                if (self.status == 0) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }else if (self.status == 3) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                }else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
            }
            
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
            
            if (indexPath.row == 1) {
                if (self.status == 0) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }else if (self.status == 3) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.contentLabel.hidden = NO;
                    cell.contentLabel.text = @"群公告";
                    
                }else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    
                }
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
                    if (self.status == 3) {
                        
                        self.indexPath = indexPath;
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改群名片"message:@""preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                            textField.placeholder = @"输入群名片";
                        }];
                        
                        
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            UITextField * userName = alertController.textFields.firstObject;
                            //  修改群名称
                            self.groupName = userName.text;
                            [self changeGroupName];
                        }];
                        // 2.3 添加按钮
                        [alertController addAction:cancelAction];
                        [alertController addAction:loginAction];
                        
                        // 3.显示警报控制器
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }
                    break;
                case 1:
                {
                    QCGroupDataCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    self.dataImageView =  cell.headerImageView;
                    [self takePhoto];
                }
                    
                    break;
                case 2:
                {
                    
                    self.indexPath = indexPath;
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改我的昵称"message:@""preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                        textField.placeholder = @"输入新昵称";
                        
                    }];
                    
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        UITextField * userName = alertController.textFields.firstObject;
                        //  修改群名称
                        self.nickName = userName.text;
                        [self changeNickName];
                    }];
                    // 2.3 添加按钮
                    [alertController addAction:cancelAction];
                    [alertController addAction:loginAction];
                    
                    // 3.显示警报控制器
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                    break;
                case 3:
                {
                    QCPersonCodeViewController * personCodeViewController = [[QCPersonCodeViewController alloc] init];
                    personCodeViewController.hidesBottomBarWhenPushed = YES;
                    personCodeViewController.groupDataArr = self.groupDataArr;
                    [self.navigationController pushViewController:personCodeViewController animated:YES];
                }
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
                    if (self.status == 3) {
                        //  群管理
                        QCGroupSetModel * model = [self.groupDataArr firstObject];
                        GroupManagerViewController * groupManagerViewController = [[GroupManagerViewController alloc] init];
                        groupManagerViewController.group_id = model.id;
                        groupManagerViewController.numberArr = self.dataArr;
                        groupManagerViewController.groupDataArr = self.groupDataArr;
                        
                        groupManagerViewController.refreshBlock = ^(NSString * _Nullable str) {
                            [self GETGroupData];
                        };
                        groupManagerViewController.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:groupManagerViewController animated:YES];
                    }
                    break;
                case 1:
                {
                    QCUngetEnvelopeViewController  * ungetEnvelopeViewController = [[QCUngetEnvelopeViewController alloc] init];
                    ungetEnvelopeViewController.hidesBottomBarWhenPushed = YES;
                    ungetEnvelopeViewController.group_id = self.groupId;
                    [self.navigationController pushViewController:ungetEnvelopeViewController animated:YES];
                }
                    
                    break;
                    
                    
                default:
                    break;
            }
            break;
            
        case 3:
            switch (indexPath.row) {
                case 0:
                {
                    QCMessageSearchViewController * messageSearchViewController = [[QCMessageSearchViewController alloc] init];
                    messageSearchViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:messageSearchViewController animated:YES];
                }
                    break;
                case 1:
                    if (self.status == 3) {
                        //  发布群公告
                            
                            self.indexPath = indexPath;
                            
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发布群公告"message:@""preferredStyle:UIAlertControllerStyleAlert];
                            
                            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                                textField.placeholder = @"输入公告内容";
                                
                            }];
                            
                            
                            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            }];
                            UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                UITextField * userName = alertController.textFields.firstObject;
                                //  修改群名称
                                self.announcementStr = userName.text;
                                [self sendAnnouncement];
                            }];
                            // 2.3 添加按钮
                            [alertController addAction:cancelAction];
                            [alertController addAction:loginAction];
                            
                            // 3.显示警报控制器
                            [self presentViewController:alertController animated:YES completion:nil];
                        
                    }
                    break;
                case 2:
                {
    
                    QCChatModel * chatModel = [[QCChatModel alloc] init];
                    chatModel.listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId];
                    [[QCDataBase shared] deleteChatModel:chatModel];
                }
                    break;
                case 3:
                {
                    QCComplaintsViewController * complaintsViewController = [[QCComplaintsViewController alloc] init];
                    complaintsViewController.hidesBottomBarWhenPushed = YES;
                    complaintsViewController.status = @"group";
                    complaintsViewController.targer_id = self.groupId;

                    [self.navigationController pushViewController:complaintsViewController animated:YES];
                }
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
    
    
    if (self.status == 0) {
        return self.dataArr.count;
        
    } else if (self.status == 1) {
        
        return self.dataArr.count + 1;
        
    }else{
        
        
        return self.dataArr.count + 2;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCGroupItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    if (indexPath.row < self.dataArr.count) {
        QCGroupDataModel * model = self.dataArr[indexPath.row];
        [item fillCellWithModel:model];
    }else{
        item.identityLabel.hidden = YES;
        item.nameLabel.text = @"";
        if (indexPath.row == self.dataArr.count) {
            item.headerImageView.image = [UIImage imageNamed:@"add_chat"];

        }else{
            item.headerImageView.image = [UIImage imageNamed:@"jian_chat"];

        }
    }
    
    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row < self.dataArr.count) {
        //   好友关系验证
        QCGroupDataModel * model = self.dataArr[indexPath.row];
        NSString * str = [NSString stringWithFormat:@"fuid=%@&token=%@&uid=%@",model.uid,K_TOKEN,K_UID];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"fuid":model.uid,@"token":K_TOKEN,@"uid":K_UID};
        
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        
        
        
        [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/verif_friend"] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            
            
            if ([responseObject[@"status"] intValue] == 1) {
                if ([responseObject[@"data"][@"is_friend"] intValue] == 1) {
                    //  跳转好友资料界面
                    QCBookModel * bookModel = [[QCBookModel alloc] initWithDictionary:responseObject[@"data"] error:nil];
                    QCPersonCardViewController * personCardViewController = [[QCPersonCardViewController alloc] init];
                    personCardViewController.hidesBottomBarWhenPushed = YES;
                    personCardViewController.model = bookModel;
                    [self.navigationController pushViewController:personCardViewController animated:YES];
                    
                }else{
                    QCGroupSetModel * model = [self.groupDataArr firstObject];
                    if ([model.is_privacy isEqualToString:@"1"]) {
                    
                    }else {
                        //  添加好友页面
                        QCSearchViewController * searchViewController = [[QCSearchViewController alloc] init];
                        searchViewController.hidesBottomBarWhenPushed = YES;
                        searchViewController.searchStr = responseObject[@"data"][@"mobile"];
                        [self.navigationController pushViewController:searchViewController animated:YES];
                    }
                }
                
                
            }else{
                [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
                
            }
            
            
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
        }];
        
        
        
        
        
    }
    if (indexPath.row == self.dataArr.count) {
        //  添加
        QCGroupChooseViewController * groupChooseViewController = [[QCGroupChooseViewController alloc] init];
        groupChooseViewController.numberArr = self.dataArr;
        QCGroupSetModel * model = [self.groupDataArr firstObject];
        groupChooseViewController.group_id = model.id;
        groupChooseViewController.refreshBlock = ^(NSString * _Nullable str) {
            [self GETGroupData];
        };
        [self.navigationController pushViewController:groupChooseViewController animated:YES];
    }
    
    if (indexPath.row == self.dataArr.count + 1) {
        //  删除
        QCGroupDeleteViewController * groupDeleteViewController = [[QCGroupDeleteViewController alloc] init];
        groupDeleteViewController.numberArr = self.dataArr;
        QCGroupSetModel * model = [self.groupDataArr firstObject];
        groupDeleteViewController.group_id = model.id;
        groupDeleteViewController.refreshBlock = ^(NSString * _Nullable str) {
            [self GETGroupData];
        };
        [self.navigationController pushViewController:groupDeleteViewController animated:YES];
    }
}



- (void)changeGroupName {
    
    
    NSLog(@"%@",self.groupDataArr);
    QCGroupSetModel * model = [self.groupDataArr firstObject];
    
    //  移除群聊
    NSString * str = [NSString stringWithFormat:@"group_id=%@&name=%@&token=%@&uid=%@",model.id,self.groupName,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":model.id,@"name":self.groupName,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_name" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            
            QCGroupDataCell * cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
            cell.contentLabel.text = self.groupName;
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)changeNickName {
    NSLog(@"%@",self.groupDataArr);
    
    
    QCGroupSetModel * model = [self.groupDataArr firstObject];
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&nick=%@&token=%@&uid=%@",model.id,self.nickName,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":model.id,@"nick":self.nickName,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_nick" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            QCGroupDataCell * cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
            cell.contentLabel.text = self.nickName;
            
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}
- (void)sendAnnouncement {
    NSLog(@"%@",self.groupDataArr);
    
    
    QCGroupSetModel * model = [self.groupDataArr firstObject];
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&placard=%@&token=%@&uid=%@",model.id,self.announcementStr,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":model.id,@"placard":self.announcementStr,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_placard" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            QCGroupDataCell * cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
            cell.contentLabel.text = self.announcementStr;
            
            [self sendTextMessage:self.announcementStr];
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
}


#pragma mark - UIImagePickerController
-(void)takePhoto
{
    kWeakSelf(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 判断是否可以打开相机，模拟器无法使用此功能
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            weakself.picker1 = [[UIImagePickerController alloc]init];
            // 允许编辑
            weakself.picker1.allowsEditing = YES;
            weakself.picker1.delegate = self;
            // 调用打开相机
            weakself.picker1.sourceType = UIImagePickerControllerSourceTypeCamera;
            weakself.picker1.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:weakself.picker1 animated:YES completion:nil];
            
        } else {
            
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 从相册选择相片
        weakself.picker2 = [[UIImagePickerController alloc]init];
        weakself.picker2.allowsEditing = YES;
        weakself.picker2.delegate = self;
        weakself.picker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        weakself.picker2.videoQuality=UIImagePickerControllerQualityTypeLow;
        weakself.picker2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:weakself.picker2 animated:NO completion:nil];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
}


//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [[UIImage alloc] init];
    image = info[UIImagePickerControllerEditedImage];
    if (picker == _picker1) {
        // 1. 拍照，要把拍下来的照片保存到相册里面
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    
    
    self.headerImageData = UIImageJPEGRepresentation(image, .1);
    if (self.headerImageData.length>100*1024) {
        if (self.headerImageData.length>1024*1024) {//1M以及以上
            self.headerImageData = UIImageJPEGRepresentation(image, .1);
        }else if (self.headerImageData.length>512*1024) {//0.5M-1M
            self.headerImageData =UIImageJPEGRepresentation(image, .5);
            
        }else if (self.headerImageData.length>200*1024) {//0.25M-0.5M
            self.headerImageData = UIImageJPEGRepresentation(image, .9);
        }
    }
    self.dataImageView.image = [UIImage imageWithData:self.headerImageData];
    [self UploadImageWithImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


// MARK: -- 上传图片
- (void)UploadImageWithImage:(UIImage *)img {
    
    NSString * encodedImageStr = [self.headerImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];;
    NSString * str = [NSString stringWithFormat:@"file=%@&group_id=%@&name=%@&token=%@&uid=%@",encodedImageStr,self.groupId,@".png",K_TOKEN,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"file":encodedImageStr,@"group_id":self.groupId,@"name":@".png",@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group_head" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}



//  发送群公告
- (void)sendTextMessage:(NSString *)bannedStr {
    self.tipArr = [NSMutableArray new];
    
    NSString * type = @"chat";
    NSString * ctype = @"1";    //  0 为单聊  传入touid  1为群聊 传入gid
    NSString * message = bannedStr;
    NSString * mtype = @"22";    //  消息类别
    NSString * msgid = [NSString stringWithFormat:@"%@|%@|%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.groupId];
    NSString * gid = self.groupId;
    NSString * touid = self.groupId;
    NSString * uid = K_UID;
    
    NSString * listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId];
    NSString * time = [QCClassFunction getNowTimeTimestamp3];
    NSString * isSend = @"0";
    NSString * canSend = @"1";
    NSString * canMessage = @"0";
    NSString * disturb = @"0";


    NSString * smsid = @"0";
    NSString * count = @"0";
    NSString * isTop = @"0";
    NSString * isRead = @"0";
    NSString * isChat = @"0";
    NSString * isBanned = @"0";


    //  先存消息
    NSDictionary * chatDic = @{@"chatId":msgid,@"listId":listId,@"type":type,@"uid":uid,@"rid":touid,@"msgid":msgid,@"message":message,@"time":time,@"ctype":ctype,@"smsid":smsid,@"gid":gid,@"mtype":mtype,@"isSend":isSend,@"canSend":canSend,@"canMessage":canMessage};
    
    QCChatModel * chatModel = [[QCChatModel alloc] initWithDictionary:chatDic error:nil];
    [[QCDataBase shared] insertChatModel:chatModel];
    
    
    //  在更新消息表格
    NSDictionary * listDic = @{@"listId":listId,@"type":type,@"uid":touid,@"rid":uid,@"msgid":msgid,@"message":message,@"time":time,@"count":count,@"isTop":isTop,@"isRead":isRead,@"isChat":isChat,@"cType":ctype,@"mtype":mtype,@"disturb":disturb,@"isBanned":isBanned};
    QCListModel * model = [[QCListModel alloc] initWithDictionary:listDic error:nil];
    [[QCDataBase shared] queryByListId:model];
    
    message = [NSString stringWithFormat:@"%@|0",message];

    NSString * str = [NSString stringWithFormat:@"ctype=%@&gid=%@&message=%@&msgid=%@&mtype=%@&token=%@&touid=%@&type=%@&uid=%@",ctype,gid,message,msgid,mtype,K_TOKEN,touid,type,uid];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"ctype":ctype,@"gid":gid,@"message":message,@"mtype":mtype,@"msgid":msgid ,@"token":K_TOKEN,@"touid":touid,@"type":type,@"uid":uid};
    
    
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    
    NSDictionary * rangeDic =  @{msgid:jsonString};
    [self.tipArr insertObject:rangeDic atIndex:0];
    

    
    if (!self.messageTimer) {
        self.messageTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];

    }
    [[QCWebSocket shared] reciveData:^(NSString * _Nonnull msgid) {

        for (NSDictionary * dic in self.tipArr) {

                NSArray *arrKeys = [dic allKeys];

                for (int i = 0 ; i < arrKeys.count ; i++)
                {
                    if ([arrKeys[i] isEqualToString:msgid]) {
                        [self.tipArr removeObject:dic];
                    }
                }

        }
    }];
    
    
}
- (void)Timered:(NSTimer*)timer {
    
    for (NSDictionary * dic in self.tipArr) {

        if (dic) {
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [[QCWebSocket shared] sendDataToServer:obj];

            }];
        }

    }

}




@end
