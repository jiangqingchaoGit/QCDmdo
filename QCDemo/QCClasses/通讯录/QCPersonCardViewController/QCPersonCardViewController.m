//
//  QCPersonCardViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/13.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonCardViewController.h"
#import "QCChatViewController.h"
#import "AppDelegate.h"
@interface QCPersonCardViewController ()


@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * cardLabel;

@property (nonatomic, strong) UILabel * markLabel;
@property (nonatomic, strong) UILabel * nickLabel;
@property (nonatomic, strong) UIImageView * nickImageView;


@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) NSString * nickName;


@end

@implementation QCPersonCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
}

- (void)rightAction:(UITapGestureRecognizer *)sender {
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.1 创建按钮
    UIAlertAction * sendAction = [UIAlertAction actionWithTitle:@"发送名片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction * shieldingAction = [UIAlertAction actionWithTitle:@"加入黑名单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shieldingAction];
    }];
    
    UIAlertAction * deleteAction = [UIAlertAction actionWithTitle:@"删除好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteAction];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    
    // 2.2 添加按钮
    [alertController addAction:sendAction];
    [alertController addAction:shieldingAction];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    
    // 3.显示警报控制器
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
}

- (void)sendAction:(UIButton *)sender {
    QCListModel * listModel = [[QCListModel alloc] init];
    listModel.listId = [NSString stringWithFormat:@"%@|000000|%@",self.model.uid,self.model.fuid];
    listModel.type = @"chat";
    listModel.uid = self.model.fuid;
    listModel.rid = self.model.uid;
    listModel.msgid = [NSString stringWithFormat:@"%@|%@|%@",self.model.uid,[QCClassFunction getNowTimeTimestamp3],self.model.fuid];;
    listModel.message = @"";
    listModel.time = [QCClassFunction getNowTimeTimestamp3];
    listModel.count = @"0";
    listModel.headImage = @"";
    listModel.isTop = @"0";
    listModel.isRead = @"1";
    listModel.isChat = @"2";
    listModel.cType = @"0";
    
    NSLog(@"%@ %@",K_HEADIMAGE,K_NICK);
    listModel.tohead = K_HEADIMAGE;
    listModel.tonick = K_NICK;
    listModel.uhead = self.model.head?self.model.head:@"";
    listModel.unick = self.model.nick?self.model.nick:self.model.fname;
    listModel.ghead = @"";
    listModel.gname = @"";
    listModel.disturb = @"0";
    listModel.isBanned = @"0";

    listModel.mtype = @"0";
    

    
    QCChatViewController * chatViewController = [[QCChatViewController alloc] init];
    chatViewController.hidesBottomBarWhenPushed = YES;
    chatViewController.model = listModel;
    
    
    if (@available(iOS 10.0, *)) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        AppDelegate * apDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        QCTarBarController * tarBarController = (QCTarBarController *)apDelegate.window.rootViewController;
        tarBarController.selectedIndex = 1;
        [tarBarController.selectedViewController pushViewController:chatViewController animated:YES];

    } else {
        // Fallback on earlier versions
        [self.navigationController popToRootViewControllerAnimated:NO];
        AppDelegate * apDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        QCTarBarController * tarBarController = (QCTarBarController *)apDelegate.window.rootViewController;
        tarBarController.selectedIndex = 1;
        [tarBarController.selectedViewController pushViewController:chatViewController animated:YES];
    }
    
    
}

- (void)changeAction:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置备注" message:@""preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请设置备注";
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

#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"详细资料";
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:self.model.head AppendingString:@"" placeholderImage:@"header"];
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.view addSubview:self.headerImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(26))];
    self.nameLabel.font = K_16_FONT;
    self.nameLabel.textColor = KTEXT_COLOR;
    if (self.model.fname == nil || [self.model.fname isEqualToString:@""]) {
        self.nameLabel.text = self.model.nick;

    }else {
        self.nameLabel.text = [NSString stringWithFormat:@"%@   (昵称:%@)",self.model.fname,self.model.nick];
    }
    [self.view addSubview:self.nameLabel];
    
    self.cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(36), KSCALE_WIDTH(200), KSCALE_WIDTH(26))];
    self.cardLabel.font = K_14_FONT;
    self.cardLabel.textColor = [QCClassFunction stringTOColor:@"#999999"];
    self.cardLabel.text =  [NSString stringWithFormat:@"多多号:%@",self.model.account];
    [self.view addSubview:self.cardLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(79), KSCALE_WIDTH(355), KSCALE_WIDTH(1))];
    lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    [self.view addSubview:lineView];
    
    self.markLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(200), KSCALE_WIDTH(26))];
    self.markLabel.font = K_16_FONT;
    self.markLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
    self.markLabel.text = @"设置备注";
    [self.view addSubview:self.markLabel];
    

    
    UIButton * changeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(80), KSCALE_WIDTH(375), KSCALE_WIDTH(46))];
    changeButton.backgroundColor = KCLEAR_COLOR;
    [changeButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    

    self.nickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(350), KSCALE_WIDTH(98), KSCALE_WIDTH(10), KSCALE_WIDTH(10))];
    self.nickImageView.image = [UIImage imageNamed:@"leftarrow"];
    [self.view addSubview:self.nickImageView];
    
    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(275) + KStatusHight, KSCALE_WIDTH(309), KSCALE_WIDTH(50))];
    self.sendButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.sendButton.titleLabel.font = K_18_FONT;
    [self.sendButton setTitle:@"发送消息" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:KTEXT_COLOR forState:UIControlStateSelected];
    [self.sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.sendButton withRadius:KSCALE_WIDTH(13)];
    [self.view addSubview:self.sendButton];
}


- (void)changeNickName {

    NSString * str = [NSString stringWithFormat:@"fname=%@&fuid=%@&token=%@&uid=%@",self.nickName,self.model.fuid,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fname":self.nickName,@"fuid":self.model.fuid,@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/buddy_nick" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {

            self.nameLabel.text = [NSString stringWithFormat:@"%@   (昵称:%@)",self.nickName,self.model.nick];

            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)shieldingAction {

    NSString * str = [NSString stringWithFormat:@"fuid=%@&is_black=%@&token=%@&uid=%@",self.model.fuid,@"1",K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"fuid":self.model.fuid,@"is_black":@"1",@"token":K_TOKEN,@"uid":K_UID};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/is_black" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {

            
            
        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}

- (void)deleteAction {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除该好友"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
    // 2.创建并添加按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString * str = [NSString stringWithFormat:@"fuid=%@&token=%@&uid=%@",self.model.fuid,K_TOKEN,K_UID];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"fuid":self.model.fuid,@"token":K_TOKEN,@"uid":K_UID};
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        
        
        
        
        [QCAFNetWorking QCPOST:@"/api/chat/del_friend" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            
            if ([responseObject[@"status"] intValue] == 1) {
                [UIView animateWithDuration:0 delay:1 options:0 animations:^{
                    [QCClassFunction showMessage:@"删除成功" toView:self.view];

                } completion:^(BOOL finished) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
                
            }else{
                [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
                
            }
            
            
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

  


@end
