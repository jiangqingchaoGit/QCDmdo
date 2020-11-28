//
//  QCGroupChatViewController.m
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupChatViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <UIImage+GIF.h>
#import <AudioToolbox/AudioToolbox.h>

//  聊天详情
#import "QCChatDetailsViewController.h"

//  红包详情页
#import "QCGetEnvelopeViewController.h"
//  转账
#import "QCTransferDetailsViewController.h"

//  聊天时间
#import "QCTimeCell.h"
//  邀请信息
#import "QCInvitationCell.h"
//  安全信息
#import "QCSaveCell.h"
//  文本聊天
#import "QCSelfTextCell.h"
#import "QCOtherTextCell.h"

//  图片信息
#import "QCSelfPictureCell.h"
#import "QCOtherPictureCell.h"

#import "QCSelfVoiceCell.h"
#import "QCOtherVoiceCell.h"

//  视频
#import "QCSelfVedioCell.h"
#import "QCOtherVedioCell.h"


//  红包信息
#import "QCSelfEnvelopeCell.h"
#import "QCOtherEnvelopeCell.h"

//  名片信息
#import "QCSelfCardCell.h"
#import "QCOtherCardCell.h"

//  转账
#import "QCSelfTransferCell.h"
#import "QCOtherTransferCell.h"

//  戳一戳
#import "QCSelfPokeCell.h"
#import "QCOtherPokeCell.h"



//  底部视图

#import "QCSearchViewController.h"



//  底部界面
#import "QCEnvelopeView.h"

//  群资料界面
#import "QCGroupDataViewController.h"

#import "QCGroupDataModel.h"
#import "QCGroupSetModel.h"
#import "QCGroupPersonModel.h"

#import "WQLPaoMaView.h"



@interface QCGroupChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) NSMutableArray * mumberDataArr;
@property (nonatomic, strong) NSMutableArray * groupDataArr;
@property (nonatomic, strong) NSMutableArray * personDataArr;




@property (nonatomic, strong) AVAudioPlayer * player;      //音频播放器
@property (nonatomic, strong) AVAudioPlayer * audioPlayer;      //音频播放器

//@property (nonatomic, strong) UIView * backView;
//@property (nonatomic, strong) QCGroupChatFooterView * footerView;
@property (nonatomic, strong) UIView * hiddenView;
@property (nonatomic, strong) UIView * tipView;
@property (nonatomic, strong) WQLPaoMaView * paoma;



@property (nonatomic, strong) QCEnvelopeView * envelopeView;


@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) AVPlayerItem * playerItem;
@property (nonatomic, strong) AVPlayer * players;
@property (nonatomic, strong) UIView * videoBackView;
@property (nonatomic, strong) UIImageView * cuoImageView;


@end

@implementation QCGroupChatViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] init];
    
    self.mumberDataArr = [[NSMutableArray alloc] init];
    self.groupDataArr = [[NSMutableArray alloc] init];
    self.personDataArr = [[NSMutableArray alloc] init];

    
    [self initUI];
    [self createTableView];
    [self createFooterView];
    [self createEnvelopeView];

    
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
    //  操作数据库 count设置为0
    //  先查询 然后修改
    self.currentIndex = -1;
    self.model.isRead = @"1";
    self.model.isChat = @"1";

    
    QCChatModel * chatModel = [self.dataArr lastObject];
    self.model.type = chatModel.type;
    self.model.cType = chatModel.ctype;
    self.model.mtype = chatModel.mtype;
    self.model.message = chatModel.message;
    self.model.time = chatModel.time;
    
    [[QCDataBase shared] queryByListId:self.model];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.model.isChat = @"2";
    [[QCDataBase shared] queryByListId:self.model];
    [self GETDATA];
    [self GETGroupData];
    


}

- (void)GETTab {
    
    [self.dataArr removeAllObjects];
    self.dataArr = [[QCDataBase shared] queryChatModel:self.model.listId];
    self.contentH = 0;
    for (QCChatModel * model in self.dataArr) {
        self.contentH = self.contentH + [model.cellH floatValue];
    }
    
    
    self.tableView.hidden = YES;
    [self.footerView updataSize];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    
}


#pragma mark - GETDATA
- (void)GETDATA {
    
    [self.dataArr removeAllObjects];
    
    self.dataArr = [[QCDataBase shared] queryChatModel:self.model.listId];
    self.contentH = 0;
    for (QCChatModel * model in self.dataArr) {
        self.contentH = self.contentH + [model.cellH floatValue];
    }
    
    
    
    if (self.dataArr.count == 0) {
        [self.tableView reloadData];
        return;
    }
    
    for (QCChatModel * chatModel in self.dataArr) {
        if ([chatModel.message isEqualToString:@"全员禁言"]) {
            //  全员禁言
            self.hiddenView.hidden = NO;
            
        }else {
            //  全员禁言已解除
            self.hiddenView.hidden = YES;

        }
        
        if ([chatModel.mtype isEqualToString:@"22"]) {
            self.tipView.hidden = NO;
            [self.paoma removeFromSuperview];
            self.paoma = [[WQLPaoMaView alloc]initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(58)) withTitle:[NSString stringWithFormat:@"公告:%@",chatModel.message]];
            self.paoma.backgroundColor = [UIColor clearColor];
            [self.tipView addSubview:self.paoma];

        }else{
            self.tipView.hidden = YES;
            [self.paoma removeFromSuperview];

        }
    }

    
    // 解决刷新tableView  reloadData时闪屏的bug
    self.tableView.hidden = YES;
    
    [self.tableView reloadData];
    
    if (self.currentIndex) {
        
        
        if (self.currentIndex >= 0) {
            
        
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            self.tableView.hidden = NO;
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];

            return;

        }
    }

    
    if ([self.dataArr count] > 1){
        // 动画之前先滚动到倒数第二个消息
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    
    self.tableView.hidden = NO;
    // 添加向上顶出最后一个消息的动画
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArr count] inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    
}

- (void)GETGroupData {

    NSString * str = [NSString stringWithFormat:@"id=%@&token=%@&uid=%@",self.groupId,K_TOKEN,K_UID];
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"id":self.groupId,@"token":K_TOKEN,@"uid":K_UID};
    
    NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    
    
    
    [QCAFNetWorking QCPOST:@"/api/chat/group" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        if ([responseObject[@"status"] intValue] == 1) {
            [self.mumberDataArr removeAllObjects];
            [self.personDataArr removeAllObjects];
            [self.groupDataArr removeAllObjects];
            
            
            for (NSDictionary * dic in responseObject[@"data"][@"list"]) {
                QCGroupDataModel * model = [[QCGroupDataModel alloc] initWithDictionary:dic error:nil];
                [self.mumberDataArr addObject:model];
            }
            
            QCGroupSetModel * model = [[QCGroupSetModel alloc] initWithDictionary:responseObject[@"data"][@"group"] error:nil];
            [self.groupDataArr addObject:model];
            
            
            QCGroupPersonModel * personModel = [[QCGroupPersonModel alloc] initWithDictionary:responseObject[@"data"][@"user"] error:nil];
            [self.personDataArr addObject:personModel];
        
            [self fillView];
            

        }else{
            [QCClassFunction showMessage:responseObject[@"msg"] toView:self.view];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [QCClassFunction showMessage:@"网络请求失败，请重新连接" toView:self.view];
    }];
    
}


- (void)fillView {
    
    if (self.groupDataArr.count != 0) {
        QCGroupSetModel * model = [self.groupDataArr firstObject];
        self.title = model.name;
    }

}
#pragma mark - tapAction
- (void)rightAction:(UITapGestureRecognizer *)sender {
    QCGroupDataViewController * groupDataViewController = [[QCGroupDataViewController alloc] init];
    groupDataViewController.hidesBottomBarWhenPushed = YES;
    groupDataViewController.dataArr = self.mumberDataArr;
    groupDataViewController.groupDataArr = self.groupDataArr;
    groupDataViewController.personDataArr = self.personDataArr;
    groupDataViewController.groupId = self.groupId;

    [self.navigationController pushViewController:groupDataViewController animated:YES];
}

- (void)resignAction {
    [self.footerView packUp];
}


- (void)selfVoiceAction:(UIButton *)sender {
    //  播放语音
    
    //  播放语音
    QCSelfVoiceCell * cell = (QCSelfVoiceCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCChatModel * model = self.dataArr[indexPath.row - 1];
    
    self.player = nil;
    
    if (model.message) {
        
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:model.message] error:nil];
        AVAudioSession * session =[AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [self.player play];
    }
}

- (void)otherVoiceAction:(UIButton *)sender {
    //  播放语音
    QCOtherVoiceCell * cell = (QCOtherVoiceCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCChatModel * model = self.dataArr[indexPath.row - 1];
    
    self.player = nil;
    if (model.message) {
        NSArray * arr = [model.message componentsSeparatedByString:@"|"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arr firstObject]]] error:nil];
        AVAudioSession * session =[AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [self.audioPlayer play];
    }
}

- (void)videoAction:(UIButton *)sender {
    QCSelfVedioCell * cell = (QCSelfVedioCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCChatModel * model = self.dataArr[indexPath.row - 1];
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];
    
    if (self.playerLayer) {
        
    }else{
        self.playerLayer = [[AVPlayerLayer alloc] init];
        self.playerLayer.frame = KSCREEN_BOUNDS;
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:arr[0]]];
        self.players = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        [self.playerLayer setPlayer:self.players];
        [self.players play];
        
        self.videoBackView = [[UIView alloc] initWithFrame:KSCREEN_BOUNDS];
        self.videoBackView.backgroundColor = KBLACK_COLOR;
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBackView];
        [[UIApplication sharedApplication].keyWindow.layer addSublayer:self.playerLayer];
        
        
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
        [deleteButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:deleteButton];
        
    }
    
    
    
    
}

- (void)otherVideoAction:(UIButton *)sender {
    QCSelfVedioCell * cell = (QCSelfVedioCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCChatModel * model = self.dataArr[indexPath.row - 1];
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];
    
    
    
    
    if (self.playerLayer) {
        
    }else{
        
        NSString * urlStr = [arr[0] stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
        NSURL * sourceMovieURL = [NSURL URLWithString:urlStr];
        AVAsset * movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        
        self.playerLayer = [[AVPlayerLayer alloc] init];
        self.playerLayer.frame = KSCREEN_BOUNDS;
        
        
        
        self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        self.players = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        [self.playerLayer setPlayer:self.players];
        [self.players play];
        
        self.videoBackView = [[UIView alloc] initWithFrame:KSCREEN_BOUNDS];
        self.videoBackView.backgroundColor = KBLACK_COLOR;
        [[UIApplication sharedApplication].keyWindow addSubview:self.videoBackView];
        
        
        [[UIApplication sharedApplication].keyWindow.layer addSublayer:self.playerLayer];
        
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
        [deleteButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:deleteButton];
        
    }
    
    
    
    
}

- (void)deleteAction:(UIButton *)sendr {
    [UIView animateWithDuration:0.5 animations:^{
        [self.videoBackView removeFromSuperview];
        [self.playerLayer removeFromSuperlayer];
        [sendr removeFromSuperview];
        self.playerItem = nil;
        self.players = nil;
        self.playerLayer = nil;
        
    }];
}


#pragma mark - initUI
- (void)initUI {
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.backgroundColor = KBACK_COLOR;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    imageView.frame = CGRectMake(0, 0, 44, 44);
    imageView.contentMode = UIViewContentModeCenter;
    [view addSubview:imageView];
    UITapGestureRecognizer * rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction:)];
    [view addGestureRecognizer:rightTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}
- (void)createEnvelopeView{
    
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = KWHITE_COLOR;
    self.backView.alpha = 0.7;
    self.backView.hidden = YES;
    [self.view addSubview:self.backView];
    UIButton * shutButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(167.5), (KSCALE_WIDTH(315) / 529.0 * 877 ) + KSCALE_WIDTH(30), KSCALE_WIDTH(40), KSCALE_WIDTH(40))];
    [shutButton setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
    [shutButton addTarget:self action:@selector(shutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:shutButton];
    
    
    self.envelopeView = [[QCEnvelopeView alloc]initWithFrame:CGRectMake(KSCALE_WIDTH(30), 0, KSCALE_WIDTH(315), KSCALE_WIDTH(315) / 529.0 * 877 )];
    self.envelopeView.hidden = YES;
    [self.view addSubview:self.envelopeView];
}



- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,  KSCREEN_HEIGHT - KSCALE_WIDTH(58) - KNavHight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCSaveCell class] forCellReuseIdentifier:@"saveCell"];
    [self.tableView registerClass:[QCInvitationCell class] forCellReuseIdentifier:@"invitationCell"];
    [self.tableView registerClass:[QCTimeCell class] forCellReuseIdentifier:@"timeCell"];
    [self.tableView registerClass:[QCSelfTextCell class] forCellReuseIdentifier:@"selfTextCell"];
    [self.tableView registerClass:[QCOtherTextCell class] forCellReuseIdentifier:@"otherTextCell"];
    [self.tableView registerClass:[QCSelfPictureCell class] forCellReuseIdentifier:@"selfPictureCell"];
    [self.tableView registerClass:[QCOtherPictureCell class] forCellReuseIdentifier:@"otherPictureCell"];
    [self.tableView registerClass:[QCSelfEnvelopeCell class] forCellReuseIdentifier:@"selfEnvelopeCell"];
    [self.tableView registerClass:[QCSelfVoiceCell class] forCellReuseIdentifier:@"selfVoiceCell"];
    [self.tableView registerClass:[QCOtherVoiceCell class] forCellReuseIdentifier:@"otherVoiceCell"];
    [self.tableView registerClass:[QCSelfVedioCell class] forCellReuseIdentifier:@"selfVedioCell"];
    [self.tableView registerClass:[QCOtherVedioCell class] forCellReuseIdentifier:@"otherVedioCell"];
    
    
    
    
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)createFooterView {
    
    self.footerView = [[QCGroupChatFooterView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(58) -KNavHight, KSCREEN_WIDTH, KSCALE_WIDTH(58))];
    [self.view addSubview:self.footerView];
    [self.footerView getParent];
    
    self.hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(58) -KNavHight, KSCREEN_WIDTH, KSCALE_WIDTH(58))];
    self.hiddenView.backgroundColor = [UIColor purpleColor];
    self.hiddenView.hidden = YES;
    [self.view addSubview:self.hiddenView];
    
    self.tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(58))];
    self.tipView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.tipView.hidden = YES;
    [self.view addSubview:self.tipView];
        
    UIButton * delectButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(331), KSCALE_WIDTH(0), KSCALE_WIDTH(44), KSCALE_WIDTH(44))];
    [delectButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [delectButton addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tipView addSubview:delectButton];
    
}

- (void)delectAction:(UIButton *)sender {
    [[QCDataBase shared] deleteChatWithMtype:@"22" byListId:[NSString stringWithFormat:@"%@|000000|%@",K_UID,self.groupId]];
    [self GETDATA];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return KSCALE_WIDTH(30);
    }else {
        QCChatModel * model = self.dataArr[indexPath.row - 1];
        return [model.cellH floatValue];
    }
    
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        QCSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell"];
        cell.saveLabel.text = @"多多安全已为您开启聊天加密";
        return cell;
    }
    
    QCChatModel * chatModel = self.dataArr[indexPath.row - 1];
    if ([chatModel.uid intValue] == [K_UID intValue]) {
        
        if ([chatModel.mtype isEqualToString:@"0"]) {
            QCSelfTextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selfTextCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.labelView.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
            [cell fillCellWithModel:chatModel];
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"1"]) {
            QCSelfPictureCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selfPictureCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * arr = [chatModel.message componentsSeparatedByString:@"|"];
            cell.pictureImageView.image =  [self Base64StrToUIImage:arr[0]];
            [cell fillCellWithModel:chatModel];
            
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"2"]) {
            QCSelfVoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selfVoiceCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.voiceButton addTarget:self action:@selector(selfVoiceAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell fillCellWithModel:chatModel];

            return cell;
        }else if ([chatModel.mtype isEqualToString:@"10"]) {
            QCTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell fillCellWithModel:chatModel];

            
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"11"]) {
            QCSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.saveLabel.text = chatModel.canMessage;
            
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"20"]) {
            QCSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.saveLabel.text = chatModel.message;
            

            
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"22"]) {
            QCSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell"];
            cell.saveLabel.hidden = YES;

            return cell;
        }else{
            QCSelfVedioCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selfVedioCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * arr = [chatModel.message componentsSeparatedByString:@"|"];
            cell.pictureImageView.image =  [self Base64StrToUIImage:arr[3]];
            
            [cell.vedioButton addTarget:self action:@selector(videoAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell fillCellWithModel:chatModel];
            return cell;
        }
    }else{
        if ([chatModel.mtype isEqualToString:@"0"]) {
            QCOtherTextCell * cell = [tableView dequeueReusableCellWithIdentifier:@"otherTextCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.labelView.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
            [cell fillCellWithModel:chatModel];
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"1"]) {
            QCOtherPictureCell * cell = [tableView dequeueReusableCellWithIdentifier:@"otherPictureCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSArray * arr = [chatModel.message componentsSeparatedByString:@"|"];
            [QCClassFunction sd_imageView:cell.pictureImageView ImageURL:arr[0] AppendingString:nil placeholderImage:K_HEADIMAGE];
            [cell fillCellWithModel:chatModel];
            
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"2"]){
            QCOtherVoiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"otherVoiceCell"];
            [cell.voiceButton addTarget:self action:@selector(otherVoiceAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"10"]) {
            QCTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell fillCellWithModel:chatModel];

            return cell;
        }else if ([chatModel.mtype isEqualToString:@"20"]) {
            QCSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.saveLabel.text = chatModel.message;
            
            return cell;
        }else if ([chatModel.mtype isEqualToString:@"22"]) {
            QCSaveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell"];
            cell.saveLabel.hidden = YES;
            return cell;
        }else{
            QCOtherVedioCell * cell = [tableView dequeueReusableCellWithIdentifier:@"otherVedioCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * arr = [chatModel.message componentsSeparatedByString:@"|"];
            
            cell.pictureImageView.image = [self getVideoFirstViewImage:[NSURL URLWithString:arr[0]]];
            [cell.vedioButton addTarget:self action:@selector(otherVideoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell fillCellWithModel:chatModel];
            return cell;
        }
    }
    
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return KSCALE_WIDTH(30);
    }else{
        QCChatModel * model = self.dataArr[indexPath.row - 1];
        return [model.cellH floatValue];
        
    }
    
    
    
}


#pragma mark - tapAction
#pragma mark - tapAction(获取红包详情)
- (void)shutAction:(UIButton *)sender {
    self.backView.hidden = YES;
    self.envelopeView.hidden = YES;
}
- (void)envelopeAction:(UIButton *)sender {
    [self.footerView packUp];


    
    if (sender.tag == 1) {
        QCSelfEnvelopeCell * cell = (QCSelfEnvelopeCell *)[[sender superview]superview];
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        QCChatModel * chatModel = self.dataArr[indexPath.row - 1];
        
//    https://app-test.xianduoduo123.com/api/finance/verifyred
        
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[chatModel.message componentsSeparatedByString:@"|"]];
        NSString * str = [NSString stringWithFormat:@"red_id=%@&token=%@&uid=%@",arr[1],K_TOKEN,K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"red_id":arr[1],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
        
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        
        [QCAFNetWorking QCPOST:@"/api/finance/verifyred" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            

            
            switch ([responseObject[@"act"] intValue]) {
                case 0:
                    //  可以领
                    break;
                case 1:
                    //  未找到红包
                    break;
                case 2:
                    //  个人红包
                {
                    
                    if ([responseObject[@"data"][@"status"] intValue] == 1) {
                        [[QCDataBase shared] changeChatModel:chatModel];
                    }
                    
                    QCGetEnvelopeViewController * getEnvelopeViewController = [[QCGetEnvelopeViewController alloc] init];
                    getEnvelopeViewController.hidesBottomBarWhenPushed = YES;
                    getEnvelopeViewController.envelopeId = arr[1];
                    [self.navigationController pushViewController:getEnvelopeViewController animated:YES];
                }
                    break;
                case 3:
                    //  已领过
                    break;
                case 4:
                    //  已领完
                    break;
                case 5:
                    //  已过期
                    break;
                    
                default:
                    break;
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
        
    }else{
        QCOtherEnvelopeCell * cell = (QCOtherEnvelopeCell *)[[sender superview]superview];
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        QCChatModel * chatModel = self.dataArr[indexPath.row - 1];
        
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[chatModel.message componentsSeparatedByString:@"|"]];
        
        
        NSString * str = [NSString stringWithFormat:@"red_id=%@&token=%@&uid=%@",arr[1],K_TOKEN,K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"red_id":arr[1],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
        
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        
        [QCAFNetWorking QCPOST:@"/api/finance/verifyred" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            
            
            
            switch ([responseObject[@"act"] intValue]) {
                case 0:
                    //  可以领
                    self.backView.hidden = NO;
                    self.envelopeView.hidden = NO;
                    [self.envelopeView grabEnvelopeWithStatus:@"0" withModel:chatModel];
                    break;
                case 1:
                    //  未找到红包
                    break;
                case 2:
                    //  个人红包
                {

                    self.backView.hidden = YES;
                    self.envelopeView.hidden = YES;
                    [self.envelopeView grabEnvelopeWithStatus:@"4" withModel:chatModel];

                }
                    break;
                case 3:
                    //  已领过
                {
 
                    
                    self.backView.hidden = YES;
                    self.envelopeView.hidden = YES;
                    [self.envelopeView grabEnvelopeWithStatus:@"2" withModel:chatModel];

                }
                    break;
                case 4:
                    //  已领完
                {

                    [self.envelopeView grabEnvelopeWithStatus:@"1" withModel:chatModel];
                    
                    self.backView.hidden = NO;
                    self.envelopeView.hidden = NO;

                }
                    break;
                case 5:
                    //  已过期
                    self.backView.hidden = NO;
                    self.envelopeView.hidden = NO;
                    
                    [self.envelopeView grabEnvelopeWithStatus:@"3" withModel:chatModel];

                    break;
                    
                default:
                    break;
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
        
        
        
        
//          先http请求
       
        
        
        
        
    }
    
    
    
    
    

    
    
    
    
    
}

#pragma mark - 名片
- (void)cardAction:(UIButton *)sender {
    [self.footerView packUp];

    
    QCSelfEnvelopeCell * cell = (QCSelfEnvelopeCell *)[[sender superview]superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCChatModel * chatModel = self.dataArr[indexPath.row - 1];
    NSArray * arr = [chatModel.message componentsSeparatedByString:@"|"];
    QCSearchViewController * searchViewController = [[QCSearchViewController alloc] init];
    searchViewController.hidesBottomBarWhenPushed = YES;
    searchViewController.searchStr = arr[2];
    [self.navigationController pushViewController:searchViewController animated:YES];
}


- (void)cuoAction:(UIButton *)sender {
    [self.footerView packUp];

    
    [self.cuoImageView removeFromSuperview];
    self.cuoImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.cuoImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.cuoImageView];
    [self.view bringSubviewToFront:self.cuoImageView];
    NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"cuo_gif.gif" ofType:nil];
    NSData *imagedata = [NSData dataWithContentsOfFile:filepath];
    UIImage * image = [UIImage sd_imageWithGIFData:imagedata];
    self.cuoImageView.contentMode = UIViewContentModeCenter;
    self.cuoImageView.image = image;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1521);
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(laterExecute) userInfo:nil repeats:NO];
    
    
}

- (void)transAction:(UIButton *)sender {
    [self.footerView packUp];
    
    if (sender.tag == 1) {
        QCSelfTransferCell * cell = (QCSelfTransferCell *)[[sender superview]superview];
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        QCChatModel * chatModel = self.dataArr[indexPath.row - 1];
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[chatModel.message componentsSeparatedByString:@"|"]];
        NSString * str = [NSString stringWithFormat:@"token=%@&tran_id=%@&uid=%@",K_TOKEN,arr[1],K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"tran_id":arr[1],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
        
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        [QCAFNetWorking QCPOST:@"/api/finance/gettransfer" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            if ([responseObject[@"status"] intValue] == 1) {
                QCTransferDetailsViewController * transferDetailsViewController  = [[QCTransferDetailsViewController alloc] init];
                transferDetailsViewController.hidesBottomBarWhenPushed = YES;
                transferDetailsViewController.typeDic = responseObject[@"data"];
                transferDetailsViewController.type = @"0";

                [self.navigationController pushViewController:transferDetailsViewController animated:YES];
                
            }
                
            
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
        

        
    }else{
        QCOtherTransferCell * cell = (QCOtherTransferCell *)[[sender superview]superview];
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        QCChatModel * chatModel = self.dataArr[indexPath.row - 1];
        
        NSMutableArray * arr = [[NSMutableArray alloc] init];
        [arr addObjectsFromArray:[chatModel.message componentsSeparatedByString:@"|"]];
        NSString * str = [NSString stringWithFormat:@"token=%@&tran_id=%@&uid=%@",K_TOKEN,arr[1],K_UID?K_UID:@""];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"tran_id":arr[1],@"token":K_TOKEN,@"uid":K_UID?K_UID:@""};
        
        NSString * jsonString = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        [QCAFNetWorking QCPOST:@"/api/finance/gettransfer" parameters:dataDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            if ([responseObject[@"status"] intValue] == 1) {
                //  收到转账并且发送 收到的socket
                QCTransferDetailsViewController * transferDetailsViewController  = [[QCTransferDetailsViewController alloc] init];
                transferDetailsViewController.hidesBottomBarWhenPushed = YES;
                transferDetailsViewController.typeDic = responseObject[@"data"];
                transferDetailsViewController.type = @"1";

                
                transferDetailsViewController.sureBlock = ^(NSString * _Nonnull messageStr) {
                    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
                    
                    NSString *str= [arr componentsJoinedByString:@"|"];
                    [dataDic setValue:@"0" forKey:@"ctype"];
                    [dataDic setValue:str forKey:@"message"];
                    [dataDic setValue:str forKey:@"selfMessage"];
                    
                    [dataDic setValue:@"14" forKey:@"mtype"];
                    [dataDic setValue:[NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp3],self.model.uid] forKey:@"msgid"];
                    [dataDic setValue:@"0" forKey:@"gid"];
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
                    
                    NSDictionary * info = @{@"fuid":self.model.uid,@"type":@"1"};
                    [QCClassFunction chatPermissions:info success:^(NSString *responseObject) {
                        
                        //  获取发送状态 1
                        
                        [dataDic setValue:@"1" forKey:@"canSend"];
                        [dataDic setValue:@"" forKey:@"canMessage"];
                        
                        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                        
                        
                        if (dataArr.count > 0) {
                            QCChatModel * model = [dataArr lastObject];
                            
                            
                            
                            if ([[QCClassFunction getNowTimeTimestamp3] integerValue] - [model.time integerValue] > 300000) {
                                [self.footerView sendTime];
                                
                            }else{
                                
                                
                            }
                            
                        }else{
                            [self.footerView sendTime];
                            
                        }
                        [self.footerView storeMessageWithModel:dataDic];
                        
                    } failure:^(NSString *error) {
                        //  获取发送状态 保存错误信息 执行当前聊天的数据进行更改
                        [dataDic setValue:@"0" forKey:@"canSend"];
                        [dataDic setValue:error forKey:@"canMessage"];
                        
                        NSMutableArray * dataArr = [[QCDataBase shared] queryChatModel:dataDic[@"listId"]];
                        
                        
                        if (dataArr.count > 0) {
                            QCChatModel * model = [dataArr lastObject];
                            if ([[QCClassFunction getNowTimeTimestamp3] intValue] - [model.time intValue] > 0) {
                                [self.footerView sendTime];
                                
                            }
                        }else{
                            [self.footerView sendTime];
                            
                        }
                        [self.footerView storeMessageWithModel:dataDic];
                        
                        
                    }];
                    
                    
                };
                [self.navigationController pushViewController:transferDetailsViewController animated:YES];
                
                

                
            }
                
            
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}

- (void)pittureAction:(UIButton *)sender {

    QCSelfPictureCell * cell = (QCSelfPictureCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    QCChatModel * model = self.dataArr[indexPath.row - 1];
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:KSCREEN_BOUNDS];

    imageView.image =  [self Base64StrToUIImage:arr[0]];

    self.videoBackView = [[UIView alloc] initWithFrame:KSCREEN_BOUNDS];
    self.videoBackView.backgroundColor = KBLACK_COLOR;
    [[UIApplication sharedApplication].keyWindow addSubview:self.videoBackView];
    [self.videoBackView addSubview:imageView];
    
    
    UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNavHight - 44, 56, 44)];
    [deleteButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:deleteButton];
    
}


- (void)delete1Action:(UIButton *)sendr {
    [UIView animateWithDuration:0.5 animations:^{
        [sendr removeFromSuperview];
        [self.videoBackView removeFromSuperview];
        
    }];
}
- (void)laterExecute {
    [self.cuoImageView removeFromSuperview];
}
-(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr

{
    
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    
    return _decodedImage;
    
}


- (UIImage*)getVideoFirstViewImage:(NSURL *)path {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
    
}



@end
