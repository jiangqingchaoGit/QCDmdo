//
//  QCEnvelopeView.m
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCEnvelopeView.h"
#import "QCGetEnvelopeViewController.h"
#import "QCChatViewController.h"
#import "QCGroupChatViewController.h"


@interface QCEnvelopeView()

//  红包状态界面
@property (nonatomic, strong) UIImageView * backImageView;
@property (nonatomic, strong) UILabel * statuLabel;
@property (nonatomic, strong) UILabel * personLabel;
@property (nonatomic, strong) UIButton * robBUtton;
@property (nonatomic, strong) UIImageView * nickImageView;
@property (nonatomic, strong) UIButton * detailButton;
@property (nonatomic, strong) AVAudioPlayer * player1;


@end

@implementation QCEnvelopeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    NSError *err;
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"coinCollide" withExtension:@"mp3"];
    _player1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url1 error:&err];
    
    self.backgroundColor = KWHITE_COLOR;
    self.backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backImageView.image = [UIImage imageNamed:@"baoBk"];
    [self addSubview:self.backImageView];
    
    self.nickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(131.5), KSCALE_WIDTH(60), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    [self.nickImageView sd_setImageWithURL:[NSURL URLWithString:[QCClassFunction URLDecodedString:@""]] placeholderImage:[UIImage imageNamed:@"header"]];
    [QCClassFunction filletImageView:self.nickImageView withRadius:KSCALE_WIDTH(26)];
    [self addSubview:self.nickImageView];
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(50), KSCALE_WIDTH(127), KSCALE_WIDTH(215), KSCALE_WIDTH(30))];
    self.personLabel.text =[NSString stringWithFormat:@"%@的红包",[QCClassFunction URLDecodedString:@"思绪云骞"]];
    self.personLabel.font = K_16_BFONT;
    self.personLabel.textAlignment = NSTextAlignmentCenter;
    self.personLabel.textColor = [QCClassFunction stringTOColor:@"#ffb333"];
    [self addSubview:self.personLabel];
    
    
    self.statuLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(50), KSCALE_WIDTH(157), KSCALE_WIDTH(215), KSCALE_WIDTH(30))];
    self.statuLabel.text =[NSString stringWithFormat:@"%@手慢了,红包派完了",[QCClassFunction URLDecodedString:@""]];
    self.statuLabel.font = K_20_BFONT;
    self.statuLabel.textAlignment = NSTextAlignmentCenter;
    self.statuLabel.textColor = [QCClassFunction stringTOColor:@"#ffb333"];
    [self addSubview:self.statuLabel];
    
    self.robBUtton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH - 60, self.bounds.size.height - 50)];
    self.robBUtton.backgroundColor = [UIColor clearColor];
    self.robBUtton.userInteractionEnabled = NO;
    [self.robBUtton addTarget:self action:@selector(robAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.robBUtton];

    
    self.detailButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), (KSCALE_WIDTH(315) / 529.0 * 877 ) - KSCALE_WIDTH(50), KSCALE_WIDTH(315), KSCALE_WIDTH(50))];
    [self.detailButton setTitle:@"查看红包详情>" forState:UIControlStateNormal];
    [self.detailButton setTitleColor:[QCClassFunction stringTOColor:@"#ffb333"] forState:UIControlStateNormal];
    self.detailButton.titleLabel.font = K_14_FONT;
    [self.detailButton addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.detailButton];


    
    

}

- (void)grabEnvelopeWithStatus:(NSString *)envelopeStatus withModel:(nonnull QCChatModel *)chatModel{
    self.model = chatModel;

    if ([envelopeStatus isEqualToString:@"0"]) {

        //  1.1.1 抢红包
        //  1.1.1.1 进入红包详情
        //  1.1.2 查看红包详情
        self.backImageView.image = [UIImage imageNamed:@"baoBk"];
        self.statuLabel.text = @"";
        self.detailButton.hidden = NO;
        self.robBUtton.userInteractionEnabled = YES;
        
        
    }
    
    if ([envelopeStatus isEqualToString:@"1"]) {
        
        [[QCDataBase shared] changeChatModel:self.model];

        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
            QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }else{
            QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }
        
        

        self.backImageView.image = [UIImage imageNamed:@"hongbao"];
        self.statuLabel.text = @"手慢了,红包已经抢完了";
        self.detailButton.hidden = NO;
        self.robBUtton.userInteractionEnabled = YES;
        
        
    }
    
    if ([envelopeStatus isEqualToString:@"2"]) {
        //  已经抢过了直接进入详情
        [[QCDataBase shared] changeChatModel:self.model];
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
            QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }else{
            QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }
        QCGetEnvelopeViewController * grabEnvelopeViewController = [[QCGetEnvelopeViewController alloc] init];
        grabEnvelopeViewController.hidesBottomBarWhenPushed = YES;
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[self.model.message componentsSeparatedByString:@"|"]];
        grabEnvelopeViewController.envelopeId = arr[1];

        [[QCClassFunction parentController:self].navigationController pushViewController:grabEnvelopeViewController animated:YES];

        
        
    }
    
    if ([envelopeStatus isEqualToString:@"3"]) {
        
        //  1.1.2 查看红包详情
        [[QCDataBase shared] changeChatModel:self.model];
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
            QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }else{
            QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }
        self.statuLabel.text = @"红包已过期";
        self.robBUtton.userInteractionEnabled = NO;
        self.detailButton.hidden = NO;
        self.backImageView.image = [UIImage imageNamed:@"hongbao"];

        
        
    }
    
    
    if ([envelopeStatus isEqualToString:@"4"]) {
        //  自己的红包不可以抢
        //  获取红包信息进入详情页
        [[QCDataBase shared] changeChatModel:self.model];
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCGroupChatViewController class]]) {
            QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }else{
            QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction  getCurrentViewController];
            [chatViewController GETDATA];

        }
        
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[self.model.message componentsSeparatedByString:@"|"]];
        
        QCGetEnvelopeViewController * grabEnvelopeViewController = [[QCGetEnvelopeViewController alloc] init];
        grabEnvelopeViewController.hidesBottomBarWhenPushed = YES;
        grabEnvelopeViewController.envelopeId = arr[1];

        [[QCClassFunction parentController:self].navigationController pushViewController:grabEnvelopeViewController animated:YES];
        
    }
}

#pragma mark - tapAction
- (void)robAction:(UIButton *)sender {
    //  抢红包
    
    
    if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCChatViewController class]]) {
        QCChatViewController * chatViewController = (QCChatViewController *)[QCClassFunction getCurrentViewController];

        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[self.model.message componentsSeparatedByString:@"|"]];

        NSString * str = [NSString stringWithFormat:@"red_id=%@&token=%@&uid=%@",arr[1],K_TOKEN,K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"red_id":arr[1],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        [QCAFNetWorking QCPOST:@"/api/finance/redreceive" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {


            [[QCDataBase shared] changeChatModel:self.model];

            if ([responseObject[@"status"]  intValue] == 1) {
                NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];

                //  改变数据库
                [self.player1 play];

                
                
                [dataDic setValue:@"1" forKey:@"ctype"];
                
                if ([self.model.uid isEqualToString:K_UID]) {
                    [dataDic setValue:[NSString stringWithFormat:@"你领取了%@的红包",@"自己"] forKey:@"selfMessage"];

                }else{
                    [dataDic setValue:[NSString stringWithFormat:@"你领取了%@的红包",self.model.unick] forKey:@"selfMessage"];
                    [dataDic setValue:[NSString stringWithFormat:@"%@领取了你的红包",K_NICK] forKey:@"message"];

                }

                [dataDic setValue:@"18" forKey:@"mtype"];
                [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.model.uid] forKey:@"msgid"];
                [dataDic setValue:self.model.gid forKey:@"gid"];
                [dataDic setValue:self.model.uid forKey:@"touid"];
                [dataDic setValue:K_UID forKey:@"uid"];
                [dataDic setValue:self.model.listId forKey:@"listId"];
                [dataDic setValue:@"0" forKey:@"isSend"];
                [dataDic setValue:@"0" forKey:@"disturb"];

                [dataDic setValue:self.model.gname forKey:@"gname"];
                [dataDic setValue:self.model.ghead forKey:@"ghead"];
                [dataDic setValue:self.model.tonick forKey:@"tnick"];
                [dataDic setValue:self.model.tohead forKey:@"thead"];
                [dataDic setValue:self.model.unick forKey:@"unick"];
                [dataDic setValue:self.model.uhead forKey:@"uhead"];



                NSDictionary * info = @{@"fuid":self.model.gid,@"type":@"2"};



                [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {

                    //  获取发送状态 1

                    [dataDic setValue:@"1" forKey:@"canSend"];
                    [dataDic setValue:@"" forKey:@"canMessage"];

                    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];


                    if (dataArr.count > 0) {
                        QCChatModel * model = [dataArr lastObject];



                        if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                            
                            [chatViewController.footerView sendTime];

                        }else{


                        }

                    }else{
                        [chatViewController.footerView sendTime];

                    }
                    [chatViewController.footerView storeMessageWithModel:dataDic];
                    
                    QCGetEnvelopeViewController * grabEnvelopeViewController = [[QCGetEnvelopeViewController alloc] init];
                    grabEnvelopeViewController.hidesBottomBarWhenPushed = YES;
                    grabEnvelopeViewController.envelopeId = arr[1];
                    [[QCClassFunction parentController:self].navigationController pushViewController:grabEnvelopeViewController animated:YES];
                    
                    chatViewController.backView.hidden = YES;
                    self.hidden = YES;
                    

                } failure:^(NSString *error) {
                    //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                    [dataDic setValue:@"0" forKey:@"canSend"];
                    [dataDic setValue:error forKey:@"canMessage"];

                    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];


                    if (dataArr.count > 0) {
                        QCChatModel * model = [dataArr lastObject];
                        if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 0) {
                            [chatViewController.footerView sendTime];

                        }
                    }else{
                        [chatViewController.footerView sendTime];

                    }
                    [chatViewController.footerView storeMessageWithModel:dataDic];


                    
                }];


            }else{

                
                if ([responseObject[@"act"] intValue] == 1) {
                    //  已经领完
                    [self grabEnvelopeWithStatus:@"1" withModel:self.model];
                    
                }
                
                if ([responseObject[@"act"] intValue] == 2) {
                    //  已过期
                    [self grabEnvelopeWithStatus:@"3" withModel:self.model];
                    
                }
                
            }



        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    //        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];


        }];

    }else{
        QCGroupChatViewController * chatViewController = (QCGroupChatViewController *)[QCClassFunction getCurrentViewController];

        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[self.model.message componentsSeparatedByString:@"|"]];

        NSString * str = [NSString stringWithFormat:@"red_id=%@&token=%@&uid=%@",arr[1],K_TOKEN,K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"red_id":arr[1],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};

        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        [QCAFNetWorking QCPOST:@"/api/finance/redreceive" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {

            
            

            [[QCDataBase shared] changeChatModel:self.model];

            if ([responseObject[@"status"]  intValue] == 1) {
                NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];

                //  改变数据库
                [self.player1 play];

                
                
                [dataDic setValue:@"1" forKey:@"ctype"];
                

                
                if ([self.model.uid isEqualToString:[K_UID stringValue]]) {
                    [dataDic setValue:[NSString stringWithFormat:@"你领取了%@的红包",@"自己"] forKey:@"selfMessage"];

                }else{
                    [dataDic setValue:[NSString stringWithFormat:@"你领取了%@的红包",self.model.unick] forKey:@"selfMessage"];
                    [dataDic setValue:[NSString stringWithFormat:@"%@领取了你的红包",K_NICK] forKey:@"message"];

                }

                [dataDic setValue:@"18" forKey:@"mtype"];
                [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.model.uid] forKey:@"msgid"];
                [dataDic setValue:self.model.gid forKey:@"gid"];
                [dataDic setValue:self.model.uid forKey:@"touid"];
                [dataDic setValue:K_UID forKey:@"uid"];
                [dataDic setValue:self.model.listId forKey:@"listId"];
                [dataDic setValue:@"0" forKey:@"isSend"];
                [dataDic setValue:@"0" forKey:@"disturb"];

                [dataDic setValue:self.model.gname forKey:@"gname"];
                [dataDic setValue:self.model.ghead forKey:@"ghead"];
                [dataDic setValue:self.model.tonick forKey:@"tnick"];
                [dataDic setValue:self.model.tohead forKey:@"thead"];
                [dataDic setValue:self.model.unick forKey:@"unick"];
                [dataDic setValue:self.model.uhead forKey:@"uhead"];



                NSDictionary * info = @{@"fuid":self.model.gid,@"type":@"2"};



                [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {

                    //  获取发送状态 1

                    [dataDic setValue:@"1" forKey:@"canSend"];
                    [dataDic setValue:@"" forKey:@"canMessage"];

                    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];


                    if (dataArr.count > 0) {
                        QCChatModel * model = [dataArr lastObject];



                        if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                            
                            [chatViewController.footerView sendTime];

                        }else{


                        }

                    }else{
                        [chatViewController.footerView sendTime];

                    }
                    [chatViewController.footerView storeMessageWithModel:dataDic];
                    
                    QCGetEnvelopeViewController * grabEnvelopeViewController = [[QCGetEnvelopeViewController alloc] init];
                    grabEnvelopeViewController.hidesBottomBarWhenPushed = YES;
                    grabEnvelopeViewController.envelopeId = arr[1];
                    [[QCClassFunction parentController:self].navigationController pushViewController:grabEnvelopeViewController animated:YES];
                    
                    chatViewController.backView.hidden = YES;
                    self.hidden = YES;
                    

                } failure:^(NSString *error) {
                    //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                    [dataDic setValue:@"0" forKey:@"canSend"];
                    [dataDic setValue:error forKey:@"canMessage"];

                    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];


                    if (dataArr.count > 0) {
                        QCChatModel * model = [dataArr lastObject];
                        if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 0) {
                            [chatViewController.footerView sendTime];

                        }
                    }else{
                        [chatViewController.footerView sendTime];

                    }
                    [chatViewController.footerView storeMessageWithModel:dataDic];


                    
                }];


            }else{

                
                if ([responseObject[@"act"] intValue] == 1) {
                    //  已经领完
                    [self grabEnvelopeWithStatus:@"1" withModel:self.model];
                    
                }
                
                if ([responseObject[@"act"] intValue] == 2) {
                    //  已过期
                    [self grabEnvelopeWithStatus:@"3" withModel:self.model];
                    
                }
                
            }



        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    //        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];


        }];

    }
    
  
    
    


}

- (void)detailAction:(UIButton *)sender {
    //  红包详情
    QCGetEnvelopeViewController * grabEnvelopeViewController = [[QCGetEnvelopeViewController alloc] init];
    grabEnvelopeViewController.hidesBottomBarWhenPushed = YES;
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    [arr addObjectsFromArray:[self.model.message componentsSeparatedByString:@"|"]];
    grabEnvelopeViewController.envelopeId = arr[1];
    [[QCClassFunction parentController:self].navigationController pushViewController:grabEnvelopeViewController animated:YES];
    
}






@end
