//
//  GroupManagerViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "GroupManagerViewController.h"
#import "QCGroupDataCell.h"
#import "GroupManagerCell.h"
//  设置管理员
#import "QCAddGroupManagerViewController.h"
//  不活跃成员
#import "QCInactiveViewController.h"
//  退群成员
#import "QCRefundGroupViewController.h"
//  新群管理
#import "QCNewGroupManagerViewController.h"
//  群助手
#import "QCAssistantViewController.h"
//  群申请列表
#import "QCGroupRpplyListViewController.h"
#import "QCGroupSetModel.h"
@interface GroupManagerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;


@property (nonatomic, strong) NSTimer * messageTimer;
@property (nonatomic, strong) NSMutableArray * messageArr;
@property (nonatomic, strong) NSString * muteStr;




@end

@implementation GroupManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createTableView];
    
}

- (void)dealloc {
    self.refreshBlock(@"1");
}
#pragma mark - tapAction
- (void)switchBtnAction:(UISwitch *)sender {
    
    
    NSString * urlStr;
    NSString * typeStr;
    NSString * type;

    
    QCGroupDataCell * cell = (QCGroupDataCell *)[[sender superview]superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (sender.isOn) {
        
        switch (indexPath.row) {
            case 0:
                //  全员禁言
                self.muteStr = @"3";
                [self bannedAction:@"全员禁言"];
                return;
                break;
                
            case 1:
                urlStr = @"group_privacy";
                typeStr = @"is_privacy";
                type = @"1";
                break;
            case 2:
                urlStr = @"group_verify";
                typeStr = @"is_verify";
                type = @"1";

                break;
            case 3:
                urlStr = @"";
                typeStr = @"";
                type = @"";
                return;

                break;
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                //  解除全员禁言
                self.muteStr = @"0";
                [self bannedAction:@"全员禁言已解除"];
                return;
                break;
                
            case 1:
                //  群隐私
                urlStr = @"group_privacy";
                typeStr = @"is_privacy";
                type = @"0";
                break;
            case 2:
                //  群验证
                urlStr = @"group_verify";
                typeStr = @"is_verify";
                type = @"0";

                break;
            case 3:
                urlStr = @"";
                typeStr = @"";
                type = @"";
                return;

                break;
            default:
                break;
        }
    }
    
    
    NSString * str = [NSString stringWithFormat:@"group_id=%@&%@=%@&token=%@&uid=%@",self.group_id,typeStr,type,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"group_id":self.group_id,typeStr:type,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",urlStr] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {

            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
    
    
    
}


- (void)bannedAction:(NSString *)bannedStr {
    
    NSString * str = [NSString stringWithFormat:@"fuid=%@&group_id=%@&is_mute=%@&time=%@&token=%@&uid=%@",@"0",self.group_id,self.muteStr,@"0",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":@"0",@"group_id":self.group_id,@"time":@"0",@"is_mute":self.muteStr,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};

    [QCAFNetWorking QCPOST:[NSString stringWithFormat:@"/api/chat/%@",@"is_mute"] parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            //  全员禁言
            [self sendTextMessage:bannedStr];
            
            
            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            //  全员禁言失败

        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}



#pragma mark - initUI
- (void)initUI {
    
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"群管理";
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
    [self.tableView registerClass:[QCGroupDataCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[GroupManagerCell class] forCellReuseIdentifier:@"managerCell"];

    
    [self.view addSubview:self.tableView];
    
    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 1;

            break;
        case 2:
            return 4;

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
    if (section == 0) {
        return 0;
    }
    return KSCALE_WIDTH(11);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 2) {
        
        return KSCALE_WIDTH(60);

    }else{
        return KSCALE_WIDTH(52);

    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray * arr = @[@[@"设置管理员",@"群成员管理",@"群申请列表",@"退群成员"],@[@"营销助手"],@[@"全员禁言",@"群成员保护模式",@"加群验证",@"风控拦截"],@[@"群主管理权转让"]];
    NSArray * titleArr = @[@"开启后，群成员不允许发送任何消息",@"开启后，群成员不是好友不可互看资料",@"开启后，需群主或管理员同意后才可加入群聊",@"开启后，成员不能发送网址、电话与二维码图片"];

    
    if (indexPath.section == 2) {
        
        QCGroupSetModel * model = [self.groupDataArr firstObject];


        GroupManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"managerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = arr[indexPath.section][indexPath.row];
        cell.contentLabel.text = titleArr[indexPath.row];
        cell.chooseSwitch.hidden = NO;
        [cell.chooseSwitch addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventValueChanged | UIControlEventTouchDragExit];

        cell.accessoryType = UITableViewCellAccessoryNone;
        
        switch (indexPath.row) {
            case 0:
                if ([model.is_mute isEqualToString:@"1"]) {
                    cell.chooseSwitch.on = YES;
                }else{
                    cell.chooseSwitch.on = NO;

                }
                break;
            case 1:
                if ([model.is_privacy isEqualToString:@"1"]) {
                    cell.chooseSwitch.on = YES;
                }else{
                    cell.chooseSwitch.on = NO;

                }
                break;
            case 2:
                if ([model.is_verify isEqualToString:@"1"]) {
                    cell.chooseSwitch.on = YES;
                }else{
                    cell.chooseSwitch.on = NO;

                }
                break;
                
            case 3:
                cell.chooseSwitch.on = YES;

                break;
                
            default:
                break;
        }
        
        return cell;

    }else{
        QCGroupDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLabel.text = arr[indexPath.section][indexPath.row];
        
        
        switch (indexPath.section) {
            case 0:
                cell.chooseSwitch.hidden = YES;
                cell.headerImageView.hidden = YES;

                break;
            case 1:

                cell.contentLabel.hidden = YES;
                cell.headerImageView.hidden = YES;
                cell.chooseSwitch.hidden = YES;
                cell.titleLabel.textColor = [QCClassFunction stringTOColor:@"#F42011"];

                break;
            case 2:
 
                break;
            case 3:
                cell.contentLabel.hidden = YES;
                cell.headerImageView.hidden = YES;
                cell.chooseSwitch.hidden = YES;
                break;

                
            default:
                break;
        }
        cell.contentLabel.hidden = YES;

        
        return cell;
    }

    

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    QCAddGroupManagerViewController * addGroupManagerViewController = [[QCAddGroupManagerViewController alloc] init];
                    addGroupManagerViewController.group_id = self.group_id;
                    addGroupManagerViewController.numberArr = self.numberArr;

                    addGroupManagerViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:addGroupManagerViewController animated:YES];
                }
                    break;
                case 1:
                {
                    QCInactiveViewController * inactiveViewController = [[QCInactiveViewController alloc] init];
                    inactiveViewController.hidesBottomBarWhenPushed = YES;
                    inactiveViewController.group_id = self.group_id;

                    [self.navigationController pushViewController:inactiveViewController animated:YES];
                }
                    break;
                case 2:
                {

                    QCGroupRpplyListViewController * groupRpplyListViewController = [[QCGroupRpplyListViewController alloc] init];
                    groupRpplyListViewController.group_id = self.group_id;
                    groupRpplyListViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:groupRpplyListViewController animated:YES];
                }
                    break;
                case 3:
                {

                    QCRefundGroupViewController * refundGroupViewController = [[QCRefundGroupViewController alloc] init];
                    refundGroupViewController.group_id = self.group_id;
                    refundGroupViewController.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:refundGroupViewController animated:YES];
                }
                    break;

                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            QCAssistantViewController * assistantViewController = [[QCAssistantViewController alloc] init];
            assistantViewController.hidesBottomBarWhenPushed = YES;
            assistantViewController.group_id = self.group_id;

            [self.navigationController pushViewController:assistantViewController animated:YES];
        }
            break;
        case 2:

            
            break;
        case 3:
        {
            QCNewGroupManagerViewController * newGroupManagerViewController = [[QCNewGroupManagerViewController alloc] init];
            newGroupManagerViewController.hidesBottomBarWhenPushed = YES;
            newGroupManagerViewController.group_id = self.group_id;

            [self.navigationController pushViewController:newGroupManagerViewController animated:YES];
        }
            
            
            
            break;

        default:
            break;
    }
    
}


- (void)sendTextMessage:(NSString *)bannedStr {
    self.messageArr = [NSMutableArray new];
    NSMutableArray * arr = [[QCDataBase shared] querywithListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.group_id]];
    QCListModel * listModel;
    if (arr.count > 0) {
        listModel = [arr firstObject];
    }
    
    
    
    NSString * type = listModel.type;
    NSString * ctype = listModel.cType;    //  0 为单聊  传入touid  1为群聊 传入gid
    NSString * message = bannedStr;
    NSString * mtype = @"11";    //  消息类别
    NSString * msgid = [NSString stringWithFormat:@"%@|%@|%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.group_id];
    NSString * gid = self.group_id;
    NSString * touid = self.group_id;
    NSString * uid = K_UID;
    
    NSString * listId = [NSString stringWithFormat:@"%@|000000|%@",K_UID,self.group_id];
    NSString * time = [QCClassFunction getNowTimeTimestamp3];
    NSString * isSend = @"0";
    NSString * canSend = @"1";
    NSString * canMessage = @"0";
    NSString * disturb = listModel.disturb;


    NSString * smsid = @"0";
    NSString * count = listModel.count;
    NSString * isTop = listModel.isTop;
    NSString * isRead = listModel.isRead?listModel.isRead:@"0";
    NSString * isChat = listModel.isChat;
    
    NSString * isBanned;
    if ([self.muteStr isEqualToString:@"3"]) {
        isBanned = @"1";
    }
    if ([self.muteStr isEqualToString:@"0"]) {
        isBanned = @"0";
    }
    

    
    //  先存消息
    NSDictionary * chatDic = @{@"chatId":msgid,@"listId":listId,@"type":type,@"uid":uid,@"rid":touid,@"msgid":msgid,@"message":message,@"time":time,@"ctype":ctype,@"smsid":smsid,@"gid":gid,@"mtype":mtype,@"isSend":isSend,@"canSend":canSend,@"canMessage":canMessage};
    
    QCChatModel * chatModel = [[QCChatModel alloc] initWithDictionary:chatDic error:nil];
    [[QCDataBase shared] insertChatModel:chatModel];
    
    
    //  在更新消息表格
    NSDictionary * listDic = @{@"listId":listId,@"type":type,@"uid":touid,@"rid":uid,@"msgid":msgid,@"message":message,@"time":time,@"count":count,@"isTop":isTop,@"isRead":isRead,@"isChat":isChat,@"cType":ctype,@"mtype":mtype,@"disturb":disturb,@"isBanned":isBanned};
//    QCListModel * model = [[QCListModel alloc] initWithDictionary:listDic error:nil];
//    [[QCDataBase shared] isBannedListModel:model withIsBanned:isBanned];
    listModel.message = message;
    listModel.isBanned = isBanned;
    listModel.uid = self.group_id;

    
    [[QCDataBase shared] queryByListId:listModel];
    

    message = [NSString stringWithFormat:@"%@|0",message];

    NSString * str = [NSString stringWithFormat:@"ctype=%@&gid=%@&message=%@&msgid=%@&mtype=%@&token=%@&touid=%@&type=%@&uid=%@",ctype,gid,message,msgid,mtype,K_TOKEN,@"0",type,uid];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"ctype":ctype,@"gid":gid,@"message":message,@"mtype":mtype,@"msgid":msgid ,@"token":K_TOKEN,@"touid":@"0",@"type":type,@"uid":uid};
    
    
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    
    NSDictionary * rangeDic =  @{msgid:jsonString};
    [self.messageArr insertObject:rangeDic atIndex:0];
    

    
    if (!self.messageTimer) {
        self.messageTimer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];

    }
    
    [[QCWebSocket shared] reciveData:^(NSString * _Nonnull msgid) {

        for (NSDictionary * dic in self.messageArr) {

                NSArray *arrKeys = [dic allKeys];

                for (int i = 0 ; i < arrKeys.count ; i++)
                {
                    if ([arrKeys[i] isEqualToString:msgid]) {
                        [self.messageArr removeObject:dic];
                    }
                }

        }
    }];
    
    
}
- (void)Timered:(NSTimer*)timer {
    
    for (NSDictionary * dic in self.messageArr) {

        if (dic) {
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [[QCWebSocket shared] sendDataToServer:obj];

            }];
        }

    }

}





@end
