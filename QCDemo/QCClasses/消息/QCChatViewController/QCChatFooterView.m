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

#define KVIEW_H (KSCREEN_HEIGHT - KSCALE_WIDTH(58) -KNavHight)

@interface QCChatFooterView ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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




@end
@implementation QCChatFooterView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        [self createCollectionView];
    }
    return self;;
}



- (void)initUI {

    
    self.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.voiceButton = [[UIButton alloc] init];
    [self.voiceButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.voiceButton addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.voiceButton];
    
    self.expressionButton = [[UIButton alloc] init];
    [self.expressionButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.expressionButton addTarget:self action:@selector(expressionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.expressionButton];
    
    self.functionButton = [[UIButton alloc] init];
    [self.functionButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.functionButton addTarget:self action:@selector(functionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.functionButton];
    
    self.functionView = [[UIView alloc] init];
    self.functionView.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.functionView];
    
    self.expressionView = [[UIView alloc] init];
    self.expressionView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.expressionView];
    
    
    
    self.contentTextView = [[UITextView alloc] init];
    self.contentTextView.font = K_16_FONT;
    self.contentTextView.backgroundColor = KBACK_COLOR;
    self.contentTextView.delegate = self;
    self.contentTextView.returnKeyType = UIReturnKeySend;
    self.contentTextView.userInteractionEnabled = YES; [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [self addSubview:self.contentTextView];
    
    self.changeH = KSCALE_WIDTH(35.5);
    self.viewH = KVIEW_H;
    
    self.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5), KSCREEN_WIDTH, KSCALE_WIDTH(408) + self.changeH - KSCALE_WIDTH(35.5));
    
    self.contentTextView.frame = CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(11.25), KSCALE_WIDTH(213), self.changeH);
    
    self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(12), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
    
    self.expressionButton.frame = CGRectMake(KSCALE_WIDTH(283), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
    
    self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), self.viewH + KSCALE_WIDTH(58), KSCALE_WIDTH(375), KSCALE_WIDTH(260));
    
    
    self.functionButton.frame = CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
    
    self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), self.viewH + KSCALE_WIDTH(58), KSCALE_WIDTH(375), KSCALE_WIDTH(100));
    
    
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
    //    self.collectionView.scrollEnabled = NO;
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
        self.changeH = KSCALE_WIDTH(35.5);
        self.viewH = KVIEW_H;
        [self updataSize];
        
    }else{
        
        sender.selected = NO;
        self.viewH = KVIEW_H;
        [self.contentTextView becomeFirstResponder];
        [self getTextViewH:self.contentTextView];
    }
    
}

- (void)expressionAction:(UIButton *)sender {
    [self.contentTextView resignFirstResponder];
    self.voiceButton.selected = NO;
    self.functionButton.selected = NO;
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        self.viewH = KVIEW_H - KSCALE_WIDTH(260);
        [self getTextViewH:self.contentTextView];
        [UIView animateWithDuration:0.25 animations:^{
            self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(22.5) + self.changeH, KSCALE_WIDTH(375), KSCALE_WIDTH(260));
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
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        self.viewH = KVIEW_H - KSCALE_WIDTH(100);
        [self getTextViewH:self.contentTextView];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(22.5) + self.changeH, KSCALE_WIDTH(375), KSCALE_WIDTH(100));
        }];
        
    }else{
        sender.selected = NO;
        self.viewH = KVIEW_H;
        [self.contentTextView becomeFirstResponder];
        [self getTextViewH:self.contentTextView];
    }
}

- (void)expressionImageAction:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    NSDictionary *emotions = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ChatEmotions" ofType:@"plist"]];
    NSArray *allValues = [emotions allValues];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentTextView.attributedText];
    textAttachment.image = [UIImage imageNamed:allValues[sender.tag]]; //要添加的图片
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [string insertAttributedString:textAttachmentString atIndex:string.length];//index为用户指定要插入图片的位置
    
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)];
    self.contentTextView.attributedText = string;
    
    CGFloat width = CGRectGetWidth(self.contentTextView.frame);
    CGSize newSize = [self.contentTextView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    self.changeH = newSize.height;
    
    if (self.changeH > 73.5) {
        self.changeH = 73.5;
    }
    
    [self updataSize];
    
    
    //    self.contentTextView.text = [NSString stringWithFormat: @"%@%@",self.contentTextView.text,allValues[sender.tag]];
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
    
//    (origin = (x = 0, y = 545), size = (width = 375, height = 408))
//    (origin = (x = 0, y = 253), size = (width = 375, height = 408))

    
    [UIView animateWithDuration:0.25 animations:^{
        
        
        
        self.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5), KSCREEN_WIDTH, KSCALE_WIDTH(408) + self.changeH - KSCALE_WIDTH(35.5));
        
        
        
//        if (self.chatViewController.tableViewH <= (KSCREEN_HEIGHT - KNavHight - self.viewH + self.changeH - KSCALE_WIDTH(35.5))) {
//            self.chatViewController.tableView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KVIEW_H);
//
//        }else{
//            self.chatViewController.tableView.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5) - KVIEW_H, KSCREEN_WIDTH, KVIEW_H);
//
//        }
        
        self.chatViewController.tableView.frame = CGRectMake(0, self.viewH - self.changeH + KSCALE_WIDTH(35.5) - KVIEW_H, KSCREEN_WIDTH, KVIEW_H);


        
        self.contentTextView.frame = CGRectMake(KSCALE_WIDTH(58), KSCALE_WIDTH(11.25), KSCALE_WIDTH(213), self.changeH);
        
        self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(12), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
        
        self.expressionButton.frame = CGRectMake(KSCALE_WIDTH(283), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
        
        self.expressionView.frame = CGRectMake(KSCALE_WIDTH(0), self.changeH + KSCALE_WIDTH(22.5), KSCALE_WIDTH(375), KSCALE_WIDTH(260));
        
        
        self.functionButton.frame = CGRectMake(KSCALE_WIDTH(329), KSCALE_WIDTH(12) + self.changeH - KSCALE_WIDTH(35.5), KSCALE_WIDTH(34), KSCALE_WIDTH(34));
        
        self.functionView.frame = CGRectMake(KSCALE_WIDTH(0), self.changeH + KSCALE_WIDTH(22.5), KSCALE_WIDTH(375), KSCALE_WIDTH(100));
        
        
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
    
    self.voiceButton.selected = NO;
    self.expressionButton.selected = NO;
    self.functionButton.selected = NO;
    
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
        //在这里做你响应return键的代码
        //  发送消息哟
        NSLog(@"%@",self.contentTextView.text);
        
 

        
        
        
        //  发送文本消息
        //        {sign:'xx','data':''}主数据  data 数据格式  {‘type’:'chat','uid':'10','touid':'20','mtype':0,'message':''，,ctype:0,gid:12,msgid:'xx12121212121'}      发送数据的格式 ，mtype  0为文本，1图片，2为语音，3为红包，4视频，5转账，6名片，7抖动，8商品，9群信息 ctype = 0 / 单聊
        
        

        NSString * ctype = @"0";    //  0 为单聊  传入touid  1为群聊 传入gid
        NSString * message = self.contentTextView.text;
        NSString * mtype = @"0";    //  消息类别
        NSString * msgid = [NSString stringWithFormat:@"%@｜%@｜%@",K_UID,[QCClassFunction getNowTimeTimestamp],K_UID];
        NSString * gid = @"0";
        NSString * token = K_TOKEN;
        NSString * touid = K_UID;
        NSString * type = @"chat";
        NSString * uid = K_UID;


        NSString * str = [NSString stringWithFormat:@"ctype=%@&gid=%@&message=%@&msgid=%@&mtype=%@&token=%@&touid=%@&type=%@&uid=%@",ctype,gid,message,msgid,mtype,token,touid,type,uid];
        NSString * signStr = [QCClassFunction MD5:str];
        NSDictionary * dic = @{@"ctype":ctype,@"gid":gid,@"message":self.contentTextView.text,@"mtype":mtype,@"msgid":msgid ,@"token":token,@"touid":touid,@"type":type,@"uid":uid};
        
        
        
        NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
        NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[QCWebSocket shared] sendDataToServer:jsonString];
        
        
        

//        NSDictionary * chatDic2 = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":type,@"uid":uid,@"rid":touid,@"msgid":msgid,@"message":message,@"time":@"9999",@"ctype":ctype,@"smsid":@"999999999999"};
//
//        QCChatModel * chatModel2 = [[QCChatModel alloc] initWithDictionary:chatDic2 error:nil];
//        [[QCDataBase shared] insertChatModel:chatModel2];
//
//        [self.chatViewController GETDATA];
        
        self.contentTextView.text = nil;
        CGFloat width = CGRectGetWidth(textView.frame);
        CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
        self.changeH = newSize.height;
        
        if (self.changeH > 73.5) {
            self.changeH = 73.5;
        }
        
        [self updataSize];
        
        
        return NO;
    }
    
    
    return YES;
}



@end
