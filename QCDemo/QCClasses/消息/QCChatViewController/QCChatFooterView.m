//
//  QCChatFooterView.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChatFooterView.h"
#import "QCExpressionItem.h"
#import "QCChatViewController.h"



#import "TZImagePickerController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

//  发送红包
#import "QCSendEnvelopeViewController.h"
//  发送名片
#import "QCSendCardViewController.h"
//  转账
#import "QCTransferViewController.h"

#define KVIEW_H (KSCREEN_HEIGHT - KSCALE_WIDTH(58) -KNavHight)

@interface QCChatFooterView ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) QCChatViewController * chatViewController;
@property (nonatomic, strong) UIButton * voiceButton;
@property (nonatomic, strong) UIButton * speakButton;

@property (nonatomic, strong) UIButton * expressionButton;
@property (nonatomic, strong) UIView * expressionView;
@property (nonatomic, strong) UICollectionView * collectionView;


@property (nonatomic, strong) UIButton * functionButton;
@property (nonatomic, strong) UIView * functionView;

@property (nonatomic, assign) CGFloat changeH;
@property (nonatomic, assign) CGFloat viewH;


@property (nonatomic, strong) NSData * headerImageData;//图片数据
@property (nonatomic, strong) UIImageView * dataImageView;//图片数据

@property (nonatomic,strong)UIImagePickerController * picker1;
@property (nonatomic,strong)UIImagePickerController * picker2;

//  发语音
@property (nonatomic, assign) NSInteger countDown;  //  时间
@property (nonatomic, strong) NSTimer * timer;            //定时器

@property (nonatomic, strong) AVAudioSession * session;
@property (nonatomic, strong) AVAudioRecorder * recorder;    //录音器
@property (nonatomic, strong) NSString * recordFilePath;     //录音文件沙盒地址
@property (nonatomic, assign) BOOL isLeaveSpeakBtn;     //是否上滑

@property (nonatomic,strong)AVPlayer * player;

@property (nonatomic, strong) NSTimer * messageTimer;
@property (nonatomic, strong) NSMutableArray * messageArr;


@end
@implementation QCChatFooterView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.keyboardStr = @"1";
        [self initUI];
        [self createCollectionView];
    }
    return self;;
}



- (void)initUI {
    
    
    self.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.voiceButton = [[UIButton alloc] init];
    [self.voiceButton setImage:[UIImage imageNamed:@"yuyinb"] forState:UIControlStateNormal];
    [self.voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.voiceButton];
    
    
    
    
    
    self.expressionButton = [[UIButton alloc] init];
    [self.expressionButton setImage:[UIImage imageNamed:@"smile"] forState:UIControlStateNormal];
    [self.expressionButton addTarget:self action:@selector(expressionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.expressionButton];
    
    
    
    self.functionButton = [[UIButton alloc] init];
    [self.functionButton setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    [self.functionButton addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.functionButton];
    
    self.functionView = [[UIView alloc] init];
    
    NSArray * titleArr = @[@"相册",@"相机",@"红包",@"转账",@"宝贝",@"名片",@"戳一戳",@"收藏"];
    NSArray * imageArr = @[@"xiangce",@"paishe",@"hongbao-1",@"zhuanzhang",@"baobei",@"mingpian",@"chuoyichuo",@"collection"];
    
    for (NSInteger i = 0; i < 2; i++) {
        for (NSInteger j = 0; j < 4; j++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(27.5) + KSCALE_WIDTH(90) * j, KSCALE_WIDTH(15) + i * KSCALE_WIDTH(90), KSCALE_WIDTH(50), KSCALE_WIDTH(50))];
            imageView.image = [UIImage imageNamed:imageArr[i*4+j]];
            imageView.contentMode = UIViewContentModeCenter;
            [self.functionView addSubview:imageView];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(27.5) + KSCALE_WIDTH(90) * j, KSCALE_WIDTH(70) + i * KSCALE_WIDTH(90), KSCALE_WIDTH(50), KSCALE_WIDTH(20))];
            label.text = titleArr[i*4+j];
            label.font = K_14_FONT;
            label.textColor = [QCClassFunction stringTOColor:@"#666666"];
            label.textAlignment = NSTextAlignmentCenter;
            [self.functionView addSubview:label];
            
            UIButton * functionButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(7.5) + KSCALE_WIDTH(90) * j, KSCALE_WIDTH(15) + i * KSCALE_WIDTH(90), KSCALE_WIDTH(90), KSCALE_WIDTH(110))];
            functionButton.backgroundColor = KCLEAR_COLOR;
            functionButton.tag = i * 4 + j + 1;
            [functionButton addTarget:self action:@selector(funcAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.functionView addSubview:functionButton];
            
        }
    }
    
    self.functionView.backgroundColor = KBACK_COLOR;
    [self addSubview:self.functionView];
    
    
    self.expressionView = [[UIView alloc] init];
    self.expressionView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.expressionView];
    
    
    
    
    self.contentTextView = [[UITextView alloc] init];
    self.contentTextView.font = K_16_FONT;
    self.contentTextView.backgroundColor = KBACK_COLOR;
    self.contentTextView.delegate = self;
    self.contentTextView.returnKeyType = UIReturnKeySend;
    self.contentTextView.userInteractionEnabled = YES;
    self.contentTextView.enablesReturnKeyAutomatically = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [self addSubview:self.contentTextView];
    
    
    
    self.speakButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.speakButton.hidden = YES;
    self.speakButton.backgroundColor = [UIColor purpleColor];;
    [self.speakButton setImage:[UIImage imageNamed:@"header"] forState:UIControlStateNormal];
    [self.speakButton setImage:[UIImage imageNamed:@"header"] forState:UIControlStateHighlighted];
    [self.speakButton addTarget:self action:@selector(recordButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.speakButton addTarget:self action:@selector(recordButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.speakButton addTarget:self action:@selector(recordButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self.speakButton addTarget:self action:@selector(recordButtonTouchUpDragExit) forControlEvents:UIControlEventTouchDragExit];
    [self.speakButton addTarget:self action:@selector(recordButtonTouchUpDragEnter) forControlEvents:UIControlEventTouchDragEnter];
    [self addSubview:self.speakButton];
    
    
    self.changeH = KSCALE_WIDTH(35.5);
    self.viewH = KVIEW_H;
    
    self.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5), KSCREEN_WIDTH, KSCALE_WIDTH(408) + self.changeH - KSCALE_WIDTH(35.5));
    
    self.contentTextView.frame = CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(11.25), KSCALE_WIDTH(213), self.changeH);
    
    self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(12), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
    
    self.expressionButton.frame = CGRectMake(KSCALE_WIDTH(283), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
    
    self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), self.viewH + KSCALE_WIDTH(58), KSCALE_WIDTH(375), KSCALE_WIDTH(260));
    
    
    self.functionButton.frame = CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
    
    self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), self.viewH + KSCALE_WIDTH(58), KSCALE_WIDTH(375), KSCALE_WIDTH(220));
    
    self.speakButton.frame = CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(11.25), KSCALE_WIDTH(213), KSCALE_WIDTH(35.5));
    
    
}
- (void)createCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //  4:3
    layout.itemSize = CGSizeMake(KSCALE_WIDTH(51),KSCALE_WIDTH(51));
    layout.minimumInteritemSpacing = KSCALE_WIDTH(0);
    layout.minimumLineSpacing =  KSCALE_WIDTH(0);
    layout.sectionInset = UIEdgeInsetsMake(KSCALE_WIDTH(9), KSCALE_WIDTH(9), KSCALE_WIDTH(9), KSCALE_WIDTH(9));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,KSCALE_WIDTH(0),KSCALE_WIDTH(375),KSCALE_WIDTH(260)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = KBACK_COLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[QCExpressionItem class] forCellWithReuseIdentifier:@"item"];
    [self.expressionView addSubview:self.collectionView];
}

- (void)getParent {
    self.chatViewController = (QCChatViewController *)[QCClassFunction parentController:self];
}

#pragma mark - tapAction
- (void)voiceAction:(UIButton *)sender {
    [self.contentTextView resignFirstResponder];
    
    self.expressionButton.selected = NO;
    self.functionButton.selected = NO;
    
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        self.speakButton.hidden = NO;
        self.changeH = KSCALE_WIDTH(35.5);
        self.viewH = KVIEW_H;
        [self updataSize];
        
    }else{
        
        sender.selected = NO;
        self.speakButton.hidden = YES;
        
        self.viewH = KVIEW_H;
        [self.contentTextView becomeFirstResponder];
        [self getTextViewH:self.contentTextView];
    }
    
    
    
}

- (void)expressionAction:(UIButton *)sender {
    [self.contentTextView resignFirstResponder];
    self.voiceButton.selected = NO;
    self.functionButton.selected = NO;
    self.speakButton.hidden = YES;
    
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        self.viewH = KVIEW_H - KSCALE_WIDTH(260);
        [self getTextViewH:self.contentTextView];
        [UIView animateWithDuration:0.25 animations:^{
            self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(22.5) + self.changeH, KSCALE_WIDTH(375), KSCALE_WIDTH(260));
            self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), KSCREEN_HEIGHT - KNavHight, KSCALE_WIDTH(375), KSCALE_WIDTH(220));
            
        }];
        
    }else{
        sender.selected = NO;
        self.viewH = KVIEW_H;
        [self.contentTextView becomeFirstResponder];
        [self getTextViewH:self.contentTextView];
        
        
        
    }
    
}

- (void)functionAction:(UIButton *)sender {
    [self.contentTextView resignFirstResponder];
    self.voiceButton.selected = NO;
    self.expressionButton.selected = NO;
    self.speakButton.hidden = YES;
    
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        self.viewH = KVIEW_H - KSCALE_WIDTH(220);
        [self getTextViewH:self.contentTextView];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), KSCREEN_HEIGHT - KNavHight, KSCALE_WIDTH(375), KSCALE_WIDTH(260));
            self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(22.5) + self.changeH, KSCALE_WIDTH(375), KSCALE_WIDTH(220));
        }];
        
    }else{
        sender.selected = NO;
        self.viewH = KVIEW_H;
        [self.contentTextView becomeFirstResponder];
        [self getTextViewH:self.contentTextView];
    }
}

- (void)expressionImageAction:(UIButton *)sender {
    NSDictionary *emotions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ChatEmotions" ofType:@"plist"]];
    NSArray *allValues = [emotions allValues];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    textAttachment.image = [UIImage imageNamed:allValues[sender.tag - 1]]; //要添加的图片

    
    CGFloat width = CGRectGetWidth(self.contentTextView.frame);
    self.contentTextView.text = [NSString stringWithFormat: @"%@%@",self.contentTextView.text,allValues[sender.tag]];
    CGSize newSize = [self.contentTextView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    self.changeH = newSize.height;
    

    
    if (self.changeH > 73.5) {
        self.changeH = 73.5;
    }
    
    self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), self.changeH + KSCALE_WIDTH(22.5), KSCALE_WIDTH(375), KSCALE_WIDTH(220));

    
    [self updataSize];
    
    
}

- (void)funcAction:(UIButton *)sender {
    

    
    switch (sender.tag) {
        case 1:
            [self takePhoto];
            break;
        case 2:
            [self takeCamera];
            break;
        case 3:
        {
            QCSendEnvelopeViewController * sendEnvelopeViewController = [[QCSendEnvelopeViewController alloc] init];
            sendEnvelopeViewController.hidesBottomBarWhenPushed = YES;
            
            
            sendEnvelopeViewController.myBlock = ^(NSMutableDictionary * _Nonnull envelopeDic) {
                //  先http请求
                
                
                NSString * str = [NSString stringWithFormat:@"key=%@&method=%@&red_num=%@&red_price=%@&red_type=%@&target_id=%@&target_type=%@&token=%@&uid=%@",envelopeDic[@"key"],envelopeDic[@"method"],envelopeDic[@"red_num"],envelopeDic[@"red_price"],envelopeDic[@"red_type"],self.chatViewController.model.uid,envelopeDic[@"target_type"],K_TOKEN,K_UID?K_UID:@""];
                
                
                NSString * signStr = [QCClassFunction MD5:str];
                NSDictionary * dic = @{@"key":envelopeDic[@"key"],@"method":envelopeDic[@"method"],@"red_num":envelopeDic[@"red_num"],@"red_price":envelopeDic[@"red_price"],@"red_type":envelopeDic[@"red_type"],@"target_type":envelopeDic[@"target_type"],@"target_id":self.chatViewController.model.uid,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
                
                
                
                
                NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
                NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                
                NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
                [QCAFNetWorking QCPOST:@"/api/finance/red" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
                    
                    
                    
                    if ([responseObject[@"status"]  intValue] == 1) {
                        NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
                        [dataDic setValue:@"0" forKey:@"ctype"];
                        [dataDic setValue:[NSString stringWithFormat:@"0|%@|%@|%@",responseObject[@"data"][@"red_id"],envelopeDic[@"message"],envelopeDic[@"red_price"]] forKey:@"message"];
                        [dataDic setValue:[NSString stringWithFormat:@"0|%@|%@|%@",responseObject[@"data"][@"red_id"],envelopeDic[@"message"],envelopeDic[@"red_price"]] forKey:@"selfMessage"];

                        [dataDic setValue:@"3" forKey:@"mtype"];
                        [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
                        [dataDic setValue:@"0" forKey:@"gid"];
                        [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
                        [dataDic setValue:K_UID forKey:@"uid"];
                        [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
                        [dataDic setValue:@"0" forKey:@"isSend"];
                        [dataDic setValue:@"0" forKey:@"disturb"];
                        
                        [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
                        [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
                        [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
                        [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
                        [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
                        [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
                        
                        
                        
                        NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
                        
                        
                        
                        [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
                            
                            //  获取发送状态 1
                            
                            [dataDic setValue:@"1" forKey:@"canSend"];
                            [dataDic setValue:@"" forKey:@"canMessage"];
                            
                            NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                            
                            
                            if (dataArr.count > 0) {
                                QCChatModel * model = [dataArr lastObject];
                                
                                
                                
                                if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                                    [self sendTime];
                                    
                                }else{
                                    
                                    
                                }
                                
                            }else{
                                [self sendTime];
                                
                            }
                            [self storeMessageWithModel:dataDic];
                            
                        } failure:^(NSString *error) {
                            //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                            [dataDic setValue:@"0" forKey:@"canSend"];
                            [dataDic setValue:error forKey:@"canMessage"];
                            
                            NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                            
                            
                            if (dataArr.count > 0) {
                                QCChatModel * model = [dataArr lastObject];
                                if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                                    [self sendTime];
                                    
                                }
                            }else{
                                [self sendTime];
                                
                            }
                            [self storeMessageWithModel:dataDic];
                            
                            
                        }];
                        
                        
                    }else{
                        
                        [QCClassFunction showMessage:responseObject[@"msg"] toView:[QCClassFunction parentController:self].view];
                        
                    }
                    
                    
                    
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:[QCClassFunction parentController:self].view];
                    
                    
                }];
                
                
                
                
                
            };
            
            [[QCClassFunction parentController:self].navigationController pushViewController:sendEnvelopeViewController animated:YES];
            
        }
            break;
        case 4:
        {
            QCTransferViewController * transferViewController = [[QCTransferViewController alloc] init];
            transferViewController.hidesBottomBarWhenPushed = YES;
            transferViewController.myBlock = ^(NSMutableDictionary * _Nonnull messageDic) {
                //  先http请求
                
                NSString * str = [NSString stringWithFormat:@"amount=%@&key=%@&method=%@&token=%@&touid=%@&uid=%@",messageDic[@"red_price"],messageDic[@"key"],messageDic[@"method"],K_TOKEN,self.chatViewController.model.uid,K_UID?K_UID:@""];
                NSString * signStr = [QCClassFunction MD5:str];
                NSDictionary * dic = @{@"amount":messageDic[@"red_price"],@"key":messageDic[@"key"],@"method":messageDic[@"method"],@"touid":self.chatViewController.model.uid,@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
                
                NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
                NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                
                NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
                [QCAFNetWorking QCPOST:@"/api/finance/transfer" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
                    
                    
                    
                    if ([responseObject[@"status"]  intValue] == 1) {
                        NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
                        [dataDic setValue:@"0" forKey:@"ctype"];
                        [dataDic setValue:[NSString stringWithFormat:@"0|%@|%@",responseObject[@"data"][@"tran_id"],messageDic[@"red_price"]] forKey:@"message"];
                        [dataDic setValue:[NSString stringWithFormat:@"0|%@|%@",responseObject[@"data"][@"tran_id"],messageDic[@"red_price"]] forKey:@"selfMessage"];

                        [dataDic setValue:@"13" forKey:@"mtype"];
                        [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
                        [dataDic setValue:@"0" forKey:@"gid"];
                        [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
                        [dataDic setValue:K_UID forKey:@"uid"];
                        [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
                        [dataDic setValue:@"0" forKey:@"isSend"];
                        [dataDic setValue:@"0" forKey:@"disturb"];
                        
                        [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
                        [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
                        [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
                        [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
                        [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
                        [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
                        
                        
                        
                        NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
                        
                        
                        
                        [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
                            
                            //  获取发送状态 1
                            
                            [dataDic setValue:@"1" forKey:@"canSend"];
                            [dataDic setValue:@"" forKey:@"canMessage"];
                            
                            NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                            
                            
                            if (dataArr.count > 0) {
                                QCChatModel * model = [dataArr lastObject];
                                
                                
                                
                                if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                                    [self sendTime];
                                    
                                }else{
                                    
                                    
                                }
                                
                            }else{
                                [self sendTime];
                                
                            }
                            [self storeMessageWithModel:dataDic];
                            
                        } failure:^(NSString *error) {
                            //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                            [dataDic setValue:@"0" forKey:@"canSend"];
                            [dataDic setValue:error forKey:@"canMessage"];
                            
                            NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                            
                            
                            if (dataArr.count > 0) {
                                QCChatModel * model = [dataArr lastObject];
                                if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                                    [self sendTime];
                                    
                                }
                            }else{
                                [self sendTime];
                                
                            }
                            [self storeMessageWithModel:dataDic];
                            
                            
                        }];
                        
                        
                    }else{
                        
                        [QCClassFunction showMessage:responseObject[@"msg"] toView:[QCClassFunction parentController:self].view];
                        
                    }
                    
                    
                    
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:[QCClassFunction parentController:self].view];
                    
                    
                }];
                
                
                
                
                
            };
            [[QCClassFunction parentController:self].navigationController pushViewController:transferViewController animated:YES];
        }
            
            break;
        case 5:
            
            break;
        case 6:
        {
            
            QCSendCardViewController * sendCardViewController = [[QCSendCardViewController alloc] init];
            sendCardViewController.hidesBottomBarWhenPushed = YES;
            
            
            sendCardViewController.myBlock = ^(NSString * _Nonnull messageStr) {
                
                
                NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
                [dataDic setValue:@"0" forKey:@"ctype"];
                [dataDic setValue:messageStr forKey:@"message"];
                [dataDic setValue:messageStr forKey:@"selfMessage"];
                [dataDic setValue:@"6" forKey:@"mtype"];
                [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
                [dataDic setValue:@"0" forKey:@"gid"];
                [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
                [dataDic setValue:K_UID forKey:@"uid"];
                [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
                [dataDic setValue:@"0" forKey:@"isSend"];
                [dataDic setValue:@"0" forKey:@"disturb"];
                
                [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
                [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
                [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
                [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
                [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
                [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
                
                
                
                NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
                [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
                    
                    //  获取发送状态 1
                    
                    [dataDic setValue:@"1" forKey:@"canSend"];
                    [dataDic setValue:@"" forKey:@"canMessage"];
                    
                    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                    
                    
                    if (dataArr.count > 0) {
                        QCChatModel * model = [dataArr lastObject];
                        
                        
                        
                        if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                            [self sendTime];
                            
                        }else{
                            
                            
                        }
                        
                    }else{
                        [self sendTime];
                        
                    }
                    [self storeMessageWithModel:dataDic];
                    
                } failure:^(NSString *error) {
                    //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                    [dataDic setValue:@"0" forKey:@"canSend"];
                    [dataDic setValue:error forKey:@"canMessage"];
                    
                    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                    
                    
                    if (dataArr.count > 0) {
                        QCChatModel * model = [dataArr lastObject];
                        if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                            [self sendTime];
                            
                        }
                    }else{
                        [self sendTime];
                        
                    }
                    [self storeMessageWithModel:dataDic];
                    
                    
                }];
            };
            
            [[QCClassFunction parentController:self].navigationController pushViewController:sendCardViewController animated:YES];
            
            
        }
            break;
        case 7:
        {
            
            
            NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
            [dataDic setValue:@"0" forKey:@"ctype"];
            [dataDic setValue:@"0" forKey:@"message"];
            [dataDic setValue:@"0" forKey:@"selfMessage"];
            [dataDic setValue:@"5" forKey:@"mtype"];
            [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
            [dataDic setValue:@"0" forKey:@"gid"];
            [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
            [dataDic setValue:K_UID forKey:@"uid"];
            [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
            [dataDic setValue:@"0" forKey:@"isSend"];
            [dataDic setValue:@"0" forKey:@"disturb"];
            
            [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
            [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
            [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
            [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
            [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
            [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
            
            
            
            NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
            [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
                
                //  获取发送状态 1
                
                [dataDic setValue:@"1" forKey:@"canSend"];
                [dataDic setValue:@"" forKey:@"canMessage"];
                
                NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                
                
                if (dataArr.count > 0) {
                    QCChatModel * model = [dataArr lastObject];
                    
                    
                    
                    if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                        [self sendTime];
                        
                    }else{
                        
                        
                    }
                    
                }else{
                    [self sendTime];
                    
                }
                [self storeMessageWithModel:dataDic];
                
            } failure:^(NSString *error) {
                //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                [dataDic setValue:@"0" forKey:@"canSend"];
                [dataDic setValue:error forKey:@"canMessage"];
                
                NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                
                
                if (dataArr.count > 0) {
                    QCChatModel * model = [dataArr lastObject];
                    if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                        [self sendTime];
                        
                    }
                }else{
                    [self sendTime];
                    
                }
                [self storeMessageWithModel:dataDic];
                
                
            }];
        }
            break;
        case 8:
            
            break;
            
        default:
            break;
    }
}

#pragma mark - updataSize

- (void)packUp {
    [self.contentTextView resignFirstResponder];
    self.expressionButton.selected = NO;
    self.functionButton.selected = NO;
    
    if (self.voiceButton.selected == YES) {
        
    }else{
        self.viewH = KVIEW_H;
        [self getTextViewH:self.contentTextView];
    }
    
    
}
- (void)updataSize {
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.chatViewController.contentH < (self.viewH - self.changeH + KSCALE_WIDTH(35.5)) && self.viewH != KVIEW_H) {
            
            
        }else if (self.chatViewController.contentH > (self.viewH - self.changeH + KSCALE_WIDTH(35.5)) && self.chatViewController.contentH < KVIEW_H) {
            
            if (self.viewH == KVIEW_H) {
                
                self.chatViewController.tableView.frame = CGRectMake(0,self.changeH + KSCALE_WIDTH(35.5), KSCREEN_WIDTH, KVIEW_H);
            }else{
                self.chatViewController.tableView.frame = CGRectMake(0, - self.chatViewController.contentH  + ( self.viewH - self.changeH), KSCREEN_WIDTH, KVIEW_H);
            }
            
        }else{
            self.chatViewController.tableView.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5) - KVIEW_H, KSCREEN_WIDTH, KVIEW_H);
            
        }
        
        
        
        self.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5), KSCREEN_WIDTH, KSCALE_WIDTH(408) + self.changeH - KSCALE_WIDTH(35.5));
        
        
        
        
        
        self.contentTextView.frame = CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(11.25), KSCALE_WIDTH(213), self.changeH);
        
        self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(12), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
        
        self.expressionButton.frame = CGRectMake(KSCALE_WIDTH(283), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
        

        self.functionButton.frame = CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));

        
    }];
    
    
}




-(void)textViewDidChange:(UITextView *)textView {
    //获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    self.changeH = newSize.height;
    
    if (self.changeH > 73.5) {
        self.changeH = 73.5;
    }
    
    [self updataSize];
    
    
}

- (void)getTextViewH:(UITextView *)textView {
    

    CGFloat width = CGRectGetWidth(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    self.changeH = newSize.height;
    
    if (self.changeH > 73.5) {
        self.changeH = 73.5;
    }
    
    [self updataSize];
}



- (void)keyboardAction:(NSNotification*)sender{
    
    
    if ([self.keyboardStr isEqualToString:@"1"]) {
        if ([self isKindOfClass:[QCChatFooterView class]]) {
            self.voiceButton.selected = NO;
            self.expressionButton.selected = NO;
            self.functionButton.selected = NO;
            

            self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), KVIEW_H + KSCALE_WIDTH(58), KSCALE_WIDTH(375), KSCALE_WIDTH(260));
            self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), KVIEW_H + KSCALE_WIDTH(58), KSCALE_WIDTH(375), KSCALE_WIDTH(220));
            
            self.viewH = KVIEW_H;
            [self getTextViewH:self.contentTextView];
            
            CGFloat duration = [sender.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
            CGRect keyboardFrame = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            [UIView animateWithDuration:duration animations:^{
                
                self.viewH = self.viewH - keyboardFrame.size.height;
                self.frame = CGRectMake(0, self.viewH, KSCREEN_WIDTH, KSCALE_WIDTH(408) + self.changeH - KSCALE_WIDTH(35.5));
                [self updataSize];
                
            }];
            
        }
        
        
    }
    
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *emotions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ChatEmotions" ofType:@"plist"]];
    NSArray *allValues = [emotions allValues];
    return allValues.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *emotions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ChatEmotions" ofType:@"plist"]];
    NSArray *allValues = [emotions allValues];
    QCExpressionItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.expressionImageView.image = [UIImage imageNamed:allValues[indexPath.row]];
    item.expressionImageView.contentMode = UIViewContentModeCenter;
    item.expressionImageView.clipsToBounds = YES;
    item.expressionButton.tag = indexPath.row + 1;
    [item.expressionButton addTarget:self action:@selector(expressionImageAction:) forControlEvents:UIControlEventTouchUpInside];
    return item;
}

//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        
        NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
        [dataDic setValue:@"0" forKey:@"ctype"];
        [dataDic setValue:self.contentTextView.text forKey:@"message"];
        [dataDic setValue:self.contentTextView.text forKey:@"selfMessage"];
        [dataDic setValue:@"0" forKey:@"mtype"];
        [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
        [dataDic setValue:@"0" forKey:@"gid"];
        [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
        [dataDic setValue:K_UID forKey:@"uid"];
        [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
        [dataDic setValue:@"0" forKey:@"isSend"];
        [dataDic setValue:@"0" forKey:@"disturb"];
        
        [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
        [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
        [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
        [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
        [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
        [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
        
        
        
        NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
        [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
            
            //  获取发送状态 1
            
            [dataDic setValue:@"1" forKey:@"canSend"];
            [dataDic setValue:@"" forKey:@"canMessage"];
            
            NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
            
            
            if (dataArr.count > 0) {
                QCChatModel * model = [dataArr lastObject];
                
                
                
                if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                    [self sendTime];
                    
                }else{
                    
                    
                }
                
            }else{
                [self sendTime];
                
            }
            [self storeMessageWithModel:dataDic];
            
            self.contentTextView.text = nil;
            CGFloat width = CGRectGetWidth(textView.frame);
            CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
            self.changeH = newSize.height;
            
            if (self.changeH > 73.5) {
                self.changeH = 73.5;
            }
            
            [self updataSize];
            
        } failure:^(NSString *error) {
            //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
            [dataDic setValue:@"0" forKey:@"canSend"];
            [dataDic setValue:error forKey:@"canMessage"];
            
            NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
            
            
            if (dataArr.count > 0) {
                QCChatModel * model = [dataArr lastObject];
                if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                    [self sendTime];
                    
                }
            }else{
                [self sendTime];
                
            }
            [self storeMessageWithModel:dataDic];
            
            self.contentTextView.text = nil;
            CGFloat width = CGRectGetWidth(textView.frame);
            CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
            self.changeH = newSize.height;
            
            if (self.changeH > 73.5) {
                self.changeH = 73.5;
            }
            
            [self updataSize];
            
            
        }];
        
        
        
        return NO;
        
    }
    return YES;
}



#pragma mark - UIImagePickerController
-(void)takePhoto {
    // 从相册选择相片
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:@"1" delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = YES;
    
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = YES;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingMultipleVideo = YES; // 是否可以多选视频
    
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.scaleAspectFillCrop = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
    
    
#pragma mark - 到这里为止
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[QCClassFunction parentController:self] presentViewController:imagePickerVc animated:YES completion:nil];
    
}




- (void)takeCamera {
    // 判断是否可以打开相机，模拟器无法使用此功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picker1 = [[UIImagePickerController alloc]init];
        self.picker1.allowsEditing = YES;
        self.picker1.delegate = self;
        self.picker1.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker1.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [[QCClassFunction parentController:self] presentViewController:self.picker1 animated:YES completion:nil];
    }
}


//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [[UIImage alloc] init];
    image = info[UIImagePickerControllerEditedImage];
    if (picker == _picker1) {
        // 1. 拍照，要把拍下来的照片保存到相册里面
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    [self sendImageViewWithImage:image withMtype:@"1"];

    
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
    [[QCClassFunction parentController:self] dismissViewControllerAnimated:YES completion:nil];
    
}











#pragma mark - 发语音
//摁住说话
- (void)recordButtonTouchDown {
    //info.plist配置权限
    if (![self canRecord]) {
        NSLog(@"请启用麦克风-设置/隐私/麦克风");
    }
    
    //禁止其它按钮交互
    [self setupUserEnabled:NO];
    
    
    //开始录音
    self.countDown = 60;
    //添加定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLabelText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (self.session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
    } else {
        [self.session setActive:YES error:nil];
    }
    
    //获取文件沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.recordFilePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.wav",[QCClassFunction getNowTimeTimestamp]]];
    
    //设置参数
    NSDictionary *recordSetting = @{AVFormatIDKey: @(kAudioFormatLinearPCM),
                                    AVSampleRateKey: @8000.00f,
                                    AVNumberOfChannelsKey: @1,
                                    AVLinearPCMBitDepthKey: @16,
                                    AVLinearPCMIsNonInterleaved: @NO,
                                    AVLinearPCMIsFloatKey: @NO,
                                    AVLinearPCMIsBigEndianKey: @NO};
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:_recordFilePath] settings:recordSetting error:nil];
    if (_recorder) {
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self recordButtonTouchUpInside];
        });
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}


//检查是否拥有麦克风权限
- (BOOL)canRecord {
    __block BOOL bCanRecord = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            } else {
                bCanRecord = NO;
            }
        }];
    }
    return bCanRecord;
}

//  禁止其他按钮交互
- (void)setupUserEnabled:(BOOL)enable {
    
}

//  倒计时
- (void)refreshLabelText {
    
    [_recorder updateMeters];
    
    float   level;
    float   minDecibels = -80.0f;
    float   decibels    = [_recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels) {
        level = 0.0f;
    } else if (decibels >= 0.0f) {
        level = 1.0f;
    } else {
        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * decibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }
    
    NSInteger voice = level*10 + 1;
    voice = voice > 8 ? 8 : voice;
    
    NSString *imageIndex = [NSString stringWithFormat:@"voice_%ld", voice];
    //    if (_isLeaveSpeakBtn) {
    //        _volumeImageView.image = [UIImage imageNamed:@"rc_ic_volume_cancel"];
    //    } else {
    //        _volumeImageView.image = [UIImage imageNamed:imageIndex];
    //    }
    
    _countDown --;
    
    if (_countDown < 10 && _countDown > 0) {
        //        _volumeLabel.text = [NSString stringWithFormat:@"还剩 %ld 秒",(long)_countDown];
    }
    //超时自动发送
    if (_countDown < 1) {
        [self recordButtonTouchUpInside];
    }
}


//松开发送
- (void)recordButtonTouchUpInside {
    NSLog(@"recordButtonTouchUpInside");
    
    _isLeaveSpeakBtn = NO;
    
    if (!_timer) { //松开之后为何还会触发
        return;
    }
    
    //停止录音 移除定时器
    [_timer invalidate];
    _timer = nil;
    
    if ([_recorder isRecording]) {
        [_recorder stop];
    }
    
    //允许其它按钮交互
    [self setupUserEnabled:YES];
    
    if (_countDown > 59) {
        //        _volumeImageView.image = [UIImage imageNamed:@"rc_ic_volume_wraning"];
        //        _volumeLabel.text = @"说话时间太短";
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            if (_volumeBgView) {
            //                [_volumeBgView removeFromSuperview];
            //                _volumeBgView = nil;
            //            }
        });
        return;
    }
    
    //    if (_volumeBgView) {
    //        [_volumeBgView removeFromSuperview];
    //        _volumeBgView = nil;
    //    }
    
    //音频数据
    //    [NSData dataWithContentsOfFile:_recordFilePath];
    
    
    [self sendVoice:self.recordFilePath];
    
    
}

//上滑离开按钮区域松开 取消
- (void)recordButtonTouchUpOutside {
    NSLog(@"recordButtonTouchUpOutside");
    
    _isLeaveSpeakBtn = NO;
    
    //停止录音 移除定时器
    [_timer invalidate];
    _timer = nil;
    
    if ([_recorder isRecording]) {
        [_recorder stop];
    }
    
    //允许其它按钮交互
    [self setupUserEnabled:YES];
    //
    //    if (_volumeBgView) {
    //        [_volumeBgView removeFromSuperview];
    //        _volumeBgView = nil;
    //    }
}


- (void)recordButtonTouchUpDragExit {
    NSLog(@"recordButtonTouchUpDragExit");
    _isLeaveSpeakBtn = YES;
    //
    //    _volumeLabel.text = @"松开手指，取消发送";
    //    _volumeLabel.backgroundColor =  [UIColor redColor];
    //    _volumeImageView.image = [UIImage imageNamed:@"rc_ic_volume_cancel"];
}

- (void)recordButtonTouchUpDragEnter {
    NSLog(@"recordButtonTouchUpDragEnter");
    _isLeaveSpeakBtn = NO;
    //    _volumeLabel.text = @"手指上滑，取消发送";
    //    _volumeLabel.backgroundColor =  [UIColor clearColor];
}



#pragma mark - TZImagePickerControllerDelegate
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    [self sendImageViewWithImage:[photos firstObject] withMtype:@"1"];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    PHVideoRequestOptions *requestOptions = [[PHVideoRequestOptions alloc] init];
    requestOptions.version = PHImageRequestOptionsVersionCurrent;
    requestOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    [[PHImageManager defaultManager] requestPlayerItemForVideo:asset options:requestOptions resultHandler:^(AVPlayerItem * _Nullable playerItem, NSDictionary * _Nullable info) {
        NSURL * fileURL = [(AVURLAsset *)playerItem.asset URL];
        NSMutableDictionary * videoDic = [NSMutableDictionary new];
        [videoDic setValue:fileURL forKey:@"fileURL"];
        [videoDic setValue:[NSString stringWithFormat:@"%ld",asset.pixelHeight] forKey:@"videoH"];
        [videoDic setValue:[NSString stringWithFormat:@"%ld",asset.pixelWidth] forKey:@"videoW"];
        [videoDic setValue:coverImage forKey:@"img"];
        
        [self sendVideoWithDic:videoDic withUrlStr:@""];
    }];
    
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    
    return YES;
}



- (void)UploadVideo:(NSMutableDictionary *)videoDic{
    
}


-(NSString *)UIImageToBase64Str:(UIImage *)image

{
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encodedImageStr;
    
}

-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr {
    
    NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *_decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
    
}


#pragma mark - loadImaeg
- (void)sendImageViewWithImage:(UIImage *)image withMtype:(NSString *)mtype{
    
    NSString * imageStr = [NSString stringWithFormat:@"%@|%f|%f",[self UIImageToBase64Str:image],image.size.height,image.size.width];
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"0" forKey:@"ctype"];
    [dataDic setValue:imageStr forKey:@"selfMessage"];
    [dataDic setValue:mtype forKey:@"mtype"];
    [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
    [dataDic setValue:@"0" forKey:@"gid"];
    [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
    [dataDic setValue:K_UID forKey:@"uid"];
    [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
    [dataDic setValue:@"0" forKey:@"isSend"];
    [dataDic setValue:@"0" forKey:@"disturb"];
    
    [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
    [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
    [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
    [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
    [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
    [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
    
    NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
    [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
        
        //  获取发送状态 1
        [dataDic setValue:@"1" forKey:@"canSend"];
        [dataDic setValue:@"" forKey:@"canMessage"];
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
        if (dataArr.count > 0) {
            QCChatModel * model = [dataArr lastObject];
            if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                [self sendTime];
                
            }
        }else{
            [self sendTime];
            
        }
        [self storeMessageWithModel:dataDic];
        [self upDataWithData:dataDic withImage:image];
        
    } failure:^(NSString *error) {
        //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
        [dataDic setValue:@"0" forKey:@"canSend"];
        [dataDic setValue:error forKey:@"canMessage"];
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
        if (dataArr.count > 0) {
            QCChatModel * model = [dataArr lastObject];
            if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                [self sendTime];
                
            }
        }else{
            [self sendTime];
            
        }
        [self storeMessageWithModel:dataDic];
        [self upDataWithData:dataDic withImage:image];
        
        
        
    }];
    
    
}



- (void)sendVoice:(NSString *)urlStr {
    
    
    NSString * imageStr = self.recordFilePath;
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"0" forKey:@"ctype"];
    [dataDic setValue:imageStr forKey:@"selfMessage"];
    [dataDic setValue:@"2" forKey:@"mtype"];
    [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
    [dataDic setValue:@"0" forKey:@"gid"];
    [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
    [dataDic setValue:K_UID forKey:@"uid"];
    [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
    [dataDic setValue:@"0" forKey:@"isSend"];
    [dataDic setValue:@"0" forKey:@"disturb"];
    
    [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
    [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
    [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
    [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
    [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
    [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
    
    NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
    [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
        
        //  获取发送状态 1
        [dataDic setValue:@"1" forKey:@"canSend"];
        [dataDic setValue:@"" forKey:@"canMessage"];
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
        if (dataArr.count > 0) {
            QCChatModel * model = [dataArr lastObject];
            if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                [self sendTime];
                
            }
        }else{
            [self sendTime];
            
        }
        
        [self storeMessageWithModel:dataDic];
        [self upDataWithData:dataDic withImage:imageStr];
        
        
        
    } failure:^(NSString *error) {
        //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
        [dataDic setValue:@"0" forKey:@"canSend"];
        [dataDic setValue:error forKey:@"canMessage"];
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
        if (dataArr.count > 0) {
            QCChatModel * model = [dataArr lastObject];
            if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                [self sendTime];
                
            }
        }else{
            [self sendTime];
            
        }
        
        
        
        [self storeMessageWithModel:dataDic];
        [self upDataWithData:dataDic withImage:imageStr];
        
        
        
    }];
    
    
}


#pragma mark - loadVideo
- (void)sendVideoWithDic:(NSMutableDictionary *)videoDic withUrlStr:(NSString *)urlStr{
    
    NSString * imageStr = [NSString stringWithFormat:@"%@|%@|%@|%@",videoDic[@"fileURL"],videoDic[@"videoH"],videoDic[@"videoW"],[self UIImageToBase64Str:videoDic[@"img"]]];
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"0" forKey:@"ctype"];
    [dataDic setValue:imageStr forKey:@"selfMessage"];
    [dataDic setValue:@"4" forKey:@"mtype"];
    [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
    [dataDic setValue:@"0" forKey:@"gid"];
    [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
    [dataDic setValue:K_UID forKey:@"uid"];
    [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
    [dataDic setValue:@"0" forKey:@"isSend"];
    [dataDic setValue:@"0" forKey:@"disturb"];
    
    [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
    [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
    [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
    [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
    [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
    [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
    
    
    
    NSDictionary * info = @{@"fuid":self.chatViewController.model.uid,@"type":@"1"};
    [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
        
        //  获取发送状态 1
        [dataDic setValue:@"1" forKey:@"canSend"];
        [dataDic setValue:@"" forKey:@"canMessage"];
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
        if (dataArr.count > 0) {
            QCChatModel * model = [dataArr lastObject];
            if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                [self sendTime];
                
            }
        }else{
            [self sendTime];
            
        }
        
        
        
        [self storeMessageWithModel:dataDic];
        [self upDataWithData:dataDic withImage:videoDic[@"fileURL"]];
        
        
        
    } failure:^(NSString *error) {
        //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
        [dataDic setValue:@"0" forKey:@"canSend"];
        [dataDic setValue:error forKey:@"canMessage"];
        
        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
        if (dataArr.count > 0) {
            QCChatModel * model = [dataArr lastObject];
            if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 300000) {
                [self sendTime];
                
            }
        }else{
            [self sendTime];
            
        }
        
        
        [self storeMessageWithModel:dataDic];
        [self upDataWithData:dataDic withImage:videoDic[@"fileURL"]];
        
        
        
    }];
    
    
    
}






/*
 *  发送时间
 */
- (void)sendTime {
    
    
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"0" forKey:@"ctype"];
    [dataDic setValue:[QCClassFunction getNowTimeTimestamp] forKey:@"selfMessage"];
    [dataDic setValue:[QCClassFunction getNowTimeTimestamp] forKey:@"message"];
    
    [dataDic setValue:@"10" forKey:@"mtype"];
    [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.chatViewController.model.uid] forKey:@"msgid"];
    [dataDic setValue:@"0" forKey:@"gid"];
    [dataDic setValue:self.chatViewController.model.uid forKey:@"touid"];
    [dataDic setValue:K_UID forKey:@"uid"];
    [dataDic setValue:self.chatViewController.model.listId forKey:@"listId"];
    [dataDic setValue:[QCClassFunction getNowTimeTimestamp3] forKey:@"time"];
    [dataDic setValue:@"0" forKey:@"isSend"];
    [dataDic setValue:@"1" forKey:@"canSend"];
    [dataDic setValue:@"" forKey:@"canMessage"];
    [dataDic setValue:@"0" forKey:@"disturb"];
    
    [dataDic setValue:self.chatViewController.model.gname forKey:@"gname"];
    [dataDic setValue:self.chatViewController.model.ghead forKey:@"ghead"];
    [dataDic setValue:self.chatViewController.model.tonick forKey:@"tnick"];
    [dataDic setValue:self.chatViewController.model.tohead forKey:@"thead"];
    [dataDic setValue:self.chatViewController.model.unick forKey:@"unick"];
    [dataDic setValue:self.chatViewController.model.uhead forKey:@"uhead"];
    
    
    
    
    
    [self storeMessageWithModel:dataDic];
    
}

/*
 *  存入本地数据库
 */
- (void)storeMessageWithModel:(NSMutableDictionary *)dataDic {
    
    NSString * ctype = dataDic[@"ctype"];    //  0 为单聊  传入touid  1为群聊 传入gid
    
    NSString * selfMessage = dataDic[@"selfMessage"];
    NSString * message = dataDic[@"message"];

    NSString * mtype = dataDic[@"mtype"];    //  消息类别
    NSString * msgid = dataDic[@"msgid"];
    NSString * gid = dataDic[@"gid"];
    NSString * touid = dataDic[@"touid"];
    NSString * uid = dataDic[@"uid"];
    NSString * listId = dataDic[@"listId"];
    NSString * time = [QCClassFunction getNowTimeTimestamp3];
    NSString * isSend = dataDic[@"isSend"];
    NSString * canSend = dataDic[@"canSend"];
    NSString * canMessage = dataDic[@"canMessage"];
    NSString * disturb = dataDic[@"disturb"];
    
    NSString * type = @"chat";
    NSString * smsid = @"0";
    NSString * count = @"0";
    NSString * isTop = @"0";
    NSString * isRead = @"0";
    NSString * isChat = @"0";
    
    NSString * gname = dataDic[@"gname"]?dataDic[@"gname"]:@"0";
    NSString * ghead = dataDic[@"ghead"]?dataDic[@"ghead"]:@"0";
    NSString * tnick = dataDic[@"tnick"];
    NSString * thead = dataDic[@"thead"];
    NSString * unick = dataDic[@"unick"];
    NSString * uhead = dataDic[@"uhead"];
    
    
    if ([mtype isEqualToString:@"0"]) {
        NSDictionary * messageDic = @{@"message":selfMessage};
        selfMessage = [QCClassFunction jsonStringWithDictionary:messageDic];
    }
    
    [dataDic setValue:mtype forKey:@"mtype"];
    [dataDic setValue:msgid forKey:@"msgid"];
    [dataDic setValue:message forKey:@"message"];
    [dataDic setValue:selfMessage forKey:@"selfMessage"];

    
    //  先存消息
    NSDictionary * chatDic = @{@"chatId":msgid,@"listId":listId,@"type":type,@"uid":uid,@"rid":touid,@"msgid":msgid,@"message":selfMessage,@"time":time,@"ctype":ctype,@"smsid":smsid,@"gid":gid,@"mtype":mtype,@"isSend":isSend,@"canSend":canSend,@"canMessage":canMessage,@"gname":gname,@"ghead":ghead,@"tnick":tnick,@"thead":thead,@"unick":unick,@"uhead":uhead};
    
    QCChatModel * chatModel = [[QCChatModel alloc] initWithDictionary:chatDic error:nil];
    [[QCDataBase shared] insertChatModel:chatModel];
    
    
    if ([canSend isEqualToString:@"0"]) {
        NSDictionary * chatDic = @{@"chatId":[NSString stringWithFormat:@"%@|",msgid],@"listId":listId,@"type":type,@"uid":uid,@"rid":touid,@"msgid":msgid,@"message":selfMessage,@"time":time,@"ctype":ctype,@"smsid":smsid,@"gid":gid,@"mtype":@"11",@"isSend":isSend,@"canSend":canSend,@"canMessage":canMessage,@"gname":gname,@"ghead":ghead,@"tnick":tnick,@"thead":thead,@"unick":unick,@"uhead":uhead};
        QCChatModel * chatModel = [[QCChatModel alloc] initWithDictionary:chatDic error:nil];
        [[QCDataBase shared] insertChatModel:chatModel];
        [self.chatViewController GETDATA];
        
        return;
    }
    [self.chatViewController GETDATA];
    
    //  在更新消息表格
    NSDictionary * listDic = @{@"listId":listId,@"type":type,@"uid":touid,@"rid":uid,@"msgid":msgid,@"message":selfMessage,@"time":time,@"count":count,@"isTop":isTop,@"isRead":isRead,@"isChat":isChat,@"cType":ctype,@"mtype":mtype,@"disturb":disturb,@"gname":gname,@"ghead":ghead,@"tnick":tnick,@"thead":thead,@"unick":unick,@"uhead":uhead};
    QCListModel * model = [[QCListModel alloc] initWithDictionary:listDic error:nil];
    [[QCDataBase shared] queryByListId:model];
    
    if ([mtype isEqualToString:@"0"] || [mtype isEqualToString:@"3"] || [mtype isEqualToString:@"6"] || [mtype isEqualToString:@"5"] || [mtype isEqualToString:@"13"] || [mtype isEqualToString:@"14"] || [mtype isEqualToString:@"18"]) {
        [self sendTextMessageWithDic:dataDic];
    }
    
}

/*
 *  上传数据
 */

- (void)upDataWithData:(NSMutableDictionary *)webDic withImage:(id)dataMessage{
    
    NSString * typeStr;
    if ([webDic[@"mtype"] isEqualToString:@"1"]) {
        typeStr = @"pic";
    }
    if ([webDic[@"mtype"] isEqualToString:@"2"]) {
        typeStr = @"voice";
    }
    
    if ([webDic[@"mtype"] isEqualToString:@"4"]) {
        typeStr = @"video";
    }
    
    
    
    
    NSString * str = [NSString stringWithFormat:@"token=%@&type=%@&uid=%@",K_TOKEN,typeStr,K_UID?K_UID:@""];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"token":K_TOKEN,@"type":typeStr,@"uid":K_UID?K_UID:@""};
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    [QCAFNetWorking QCUpload:@"/api/chat/upload" parameters:dataDic formData:^(id<AFMultipartFormData> formData) {
        
        if ([webDic[@"mtype"] isEqualToString:@"1"] || [webDic[@"mtype"] isEqualToString:@"5"]) {
            NSData * imageData = UIImageJPEGRepresentation((UIImage *)dataMessage,0.1);
            [formData appendPartWithFileData:imageData name:@"file" fileName:@".png" mimeType:@"image/jpg/png/jpeg"];
        }
        
        if ([webDic[@"mtype"] isEqualToString:@"2"]) {
            NSData * voiceData = [NSData dataWithContentsOfFile:(NSString *)dataMessage];
            [formData appendPartWithFileData:voiceData name:@"file" fileName:@".amr" mimeType:@"amr/mp3/wmr"];
            
            
        }
        
        if ([webDic[@"mtype"] isEqualToString:@"4"]) {
            NSData * videoData = [NSData dataWithContentsOfURL:(NSURL *)dataMessage];
            [formData appendPartWithFileData:videoData name:@"file" fileName:@".mp4" mimeType:@"video/quicktime"];
            
            
        }
        
        
        
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            
            
            
            if ([webDic[@"mtype"] isEqualToString:@"1"]) {
                UIImage * image = (UIImage *)dataMessage;
                NSString * message = [NSString stringWithFormat:@"%@|%f|%f",responseObject[@"data"][@"url"],image.size.height,image.size.width];
                [webDic setValue:message forKey:@"message"];
                
            }
            
            if ([webDic[@"mtype"] isEqualToString:@"2"]) {
                
                NSString * message = responseObject[@"data"][@"url"];
                [webDic setValue:message forKey:@"message"];
                
            }
            
            if ([webDic[@"mtype"] isEqualToString:@"4"]) {
                
                NSArray * messageArr = [webDic[@"selfMessage"] componentsSeparatedByString:@"|"];
                NSString * message = [NSString stringWithFormat:@"%@|%@|%@|%@",responseObject[@"data"][@"url"],messageArr[1],messageArr[2],@"imageUrl"];
                [webDic setValue:message forKey:@"message"];
                
                
            }
            
            
            [self sendTextMessageWithDic:webDic];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        
    }];
    
    
}

/*
 *  发送消息
 */

- (void)sendTextMessageWithDic:(NSMutableDictionary *)messageDic {
    self.messageArr = [NSMutableArray new];
    NSString * ctype = messageDic[@"ctype"];    //  0 为单聊  传入touid  1为群聊 传入gid
    NSString * message = messageDic[@"message"];
    NSString * mtype = messageDic[@"mtype"];    //  消息类别
    NSString * msgid = messageDic[@"msgid"];
    NSString * gid = messageDic[@"gid"];
    NSString * touid = messageDic[@"touid"];
    NSString * uid = messageDic[@"uid"];
    
    NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:messageDic[@"listId"]];
    if (dataArr.count > 0) {
        QCChatModel * model = [dataArr lastObject];
        if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
            
            if ([mtype isEqualToString:@"0"]) {
                NSDictionary * dic = @{@"message":message,@"isfive":@"1"};
                message = [QCClassFunction jsonStringWithDictionary:dic];

            }else{
                message = [NSString stringWithFormat:@"%@|1",message];

            }
        }else{
            if ([mtype isEqualToString:@"0"]) {
                NSDictionary * dic = @{@"message":message,@"isfive":@"0"};
                message = [QCClassFunction jsonStringWithDictionary:dic];

            }else{
                message = [NSString stringWithFormat:@"%@|0",message];

            }
            
        }
    }else{
        if ([mtype isEqualToString:@"0"]) {
            NSDictionary * dic = @{@"message":message,@"isfive":@"1"};
            message = [QCClassFunction jsonStringWithDictionary:dic];


        }else{
            message = [NSString stringWithFormat:@"%@|1",message];

        }
        
    }
    
    
    NSString * type = @"chat";
    NSString * str = [NSString stringWithFormat:@"ctype=%@&gid=%@&message=%@&msgid=%@&mtype=%@&token=%@&touid=%@&type=%@&uid=%@",ctype,gid,message,msgid,mtype,K_TOKEN,touid,type,uid];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"ctype":ctype,@"gid":gid,@"message":message,@"mtype":mtype,@"msgid":msgid ,@"token":K_TOKEN,@"touid":touid,@"type":type,@"uid":uid};
    
    
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
