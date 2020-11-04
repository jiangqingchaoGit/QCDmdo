//
//  QCHomeReusableView.m
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHomeReusableView.h"
#import "QCClassItem.h"
#import "QCHtmlUrlViewController.h"
@implementation QCHomeReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createRollView];
        [self createCollectionView];
        [self createButton];
    }
    return self;
}
#pragma mark - tapAction
- (void)advertisingAction:(UIButton *)sender {
    //  广告图的点击事件
    //    QCHtmlUrlViewController * htmlUrlViewController = [[QCHtmlUrlViewController alloc] init];
    //    htmlUrlViewController.hidesBottomBarWhenPushed = YES;
    //    [[QCClassFunction parentController:self].navigationController pushViewController:htmlUrlViewController animated:YES];
    
}

- (void)recommendedAction:(UIButton *)sender {
    
    //    NSString * str = [NSString stringWithFormat:@"token=%@&type=login&uid=%@",K_TOKEN,K_UID];
    //    NSDictionary * dic = @{@"token":K_TOKEN,@"type":@"login",@"uid":K_UID};
    //
    //    NSString * signStr = [QCClassFunction MD5:str];
    //    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    //    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",K_AESKEY);
    //
    //   //
    //
    //
    //    [[QCWebSocket shared] sendDataToServer:jsonString];
    
    
    //    [[QCDataBase shared] removeAllListModel:nil];
    
    NSDictionary * dic = @{@"listId":@"10002",@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"邹单大帅哥",@"time":@"2020-10-12",@"count":@"1",@"headImage":@"headImageUrl"};
    
    QCListModel * model = [[QCListModel alloc] initWithDictionary:dic error:nil];
    [[QCDataBase shared] queryByListId:model];
    
    
    
    
    
}



- (void)limitAction:(UIButton *)sender {
    
    
    [[QCDataBase shared] removeAllListModel:nil];
    
    [[QCDataBase shared] removeAllChatModel:nil];

    NSDictionary * listDic = @{@"listId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"888888",@"message":@"置顶2",@"time":@"33",@"count":@"1",@"headImage":@"headImageUrl",@"isTop":@"2",@"isRead":@"0"};
    QCListModel * listModel = [[QCListModel alloc] initWithDictionary:listDic error:nil];
    [[QCDataBase shared] insertListModel:listModel];
    
    NSDictionary * chatDic = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"888888",@"message":@"聊天信息2",@"time":@"33",@"ctype":@"2",@"smsid":@"999999999999",@"gid":@"0"};
    
    QCChatModel * chatModel = [[QCChatModel alloc] initWithDictionary:chatDic error:nil];
    [[QCDataBase shared] insertChatModel:chatModel];
    
    
    NSDictionary * listDic1 = @{@"listId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"置顶1",@"time":@"55",@"count":@"1",@"headImage":@"headImageUrl",@"isTop":@"2",@"isRead":@"0"};
    QCListModel * listModel1 = [[QCListModel alloc] initWithDictionary:listDic1 error:nil];
    [[QCDataBase shared] insertListModel:listModel1];
    
    NSDictionary * chatDic1 = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"聊天信息1",@"time":@"55",@"ctype":@"2",@"smsid":@"999999999999",@"gid":@"0"};
    
    QCChatModel * chatModel1 = [[QCChatModel alloc] initWithDictionary:chatDic1 error:nil];
    [[QCDataBase shared] insertChatModel:chatModel1];
    
    
    
    NSDictionary * listDic2 = @{@"listId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"888888",@"message":@"置顶3",@"time":@"22",@"count":@"1",@"headImage":@"headImageUrl",@"isTop":@"2",@"isRead":@"0"};
    QCListModel * listModel2 = [[QCListModel alloc] initWithDictionary:listDic2 error:nil];
    [[QCDataBase shared] insertListModel:listModel2];
    
    NSDictionary * chatDic2 = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"888888",@"message":@"聊天信息3",@"time":@"22",@"ctype":@"2",@"smsid":@"999999999999",@"gid":@"0"};
    
    QCChatModel * chatModel2 = [[QCChatModel alloc] initWithDictionary:chatDic2 error:nil];
    [[QCDataBase shared] insertChatModel:chatModel2];
    
    
    
    
    NSDictionary * listDic3 = @{@"listId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"不置顶3",@"time":@"44",@"count":@"1",@"headImage":@"headImageUrl",@"isTop":@"1",@"isRead":@"0"};
    QCListModel * listModel3 = [[QCListModel alloc] initWithDictionary:listDic3 error:nil];
    [[QCDataBase shared] insertListModel:listModel3];
    
    NSDictionary * chatDic3 = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"其他信息3",@"time":@"44",@"ctype":@"2",@"smsid":@"999999999999",@"gid":@"0"};
    
    QCChatModel * chatModel3 = [[QCChatModel alloc] initWithDictionary:chatDic3 error:nil];
    [[QCDataBase shared] insertChatModel:chatModel3];
    
    NSDictionary * listDic4 = @{@"listId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"888888",@"message":@"不置顶1",@"time":@"88",@"count":@"1",@"headImage":@"headImageUrl",@"isTop":@"1",@"isRead":@"0"};
    QCListModel * listModel4 = [[QCListModel alloc] initWithDictionary:listDic4 error:nil];
    [[QCDataBase shared] insertListModel:listModel4];
    
    NSDictionary * chatDic4 = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"888888",@"message":@"其他信息1",@"time":@"88",@"ctype":@"2",@"smsid":@"999999999999",@"gid":@"0"};
    
    QCChatModel * chatModel4 = [[QCChatModel alloc] initWithDictionary:chatDic4 error:nil];
    [[QCDataBase shared] insertChatModel:chatModel4];
    
    NSDictionary * listDic5 = @{@"listId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"不置顶2",@"time":@"77",@"count":@"1",@"headImage":@"headImageUrl",@"isTop":@"1",@"isRead":@"0"};
    QCListModel * listModel5 = [[QCListModel alloc] initWithDictionary:listDic5 error:nil];
    [[QCDataBase shared] insertListModel:listModel5];
    
    NSDictionary * chatDic5 = @{@"chatId":[QCClassFunction getNowTimeTimestamp3],@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"其他信息2",@"time":@"77",@"ctype":@"2",@"smsid":@"999999999999",@"gid":@"0"};
    
    QCChatModel * chatModel5 = [[QCChatModel alloc] initWithDictionary:chatDic5 error:nil];
    [[QCDataBase shared] insertChatModel:chatModel5];
    
    
    
    
    
    //    NSString * msgid = [NSString stringWithFormat:@"%@%@",K_UID,[QCClassFunction getNowTimeTimestamp]];
    //    NSString * str = [NSString stringWithFormat:@"ctype=0&gid=0message=123&mtype=0&msgid=%@&touid=%@&type=chat&uid=%@",msgid,K_TUID,K_UID];
    //    NSDictionary * dic = @{@"ctype":@"0",@"gid":@"0",@"message":@"123",@"mtype":@"0",@"msgid":msgid ,@"touid":K_UID,@"type":@"chat",@"uid":K_UID};
    //
    //
    //    NSString * signStr = [QCClassFunction MD5:str];
    //
    
    //    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
    //    NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //    NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
    //    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",K_AESKEY);
    
    //
    
    
    //    [[QCWebSocket shared] sendDataToServer:jsonString];
    
    
}

#pragma mark - initUI
- (void)createRollView {
    self.cycleScrollView = [[GKCycleScrollView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(16), KSCREEN_WIDTH , KSCALE_WIDTH(130))];
    self.cycleScrollView.backgroundColor = [UIColor clearColor];
    self.cycleScrollView.dataSource = (id)self;
    self.cycleScrollView.delegate = (id)self;
    self.cycleScrollView.isChangeAlpha = NO;
    self.cycleScrollView.isAutoScroll = YES;
    self.cycleScrollView.isInfiniteLoop = YES;
    self.cycleScrollView.leftRightMargin = KSCALE_WIDTH(32);
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView reloadData];
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(KSCALE_WIDTH(55),KSCALE_WIDTH(65));
    layout.minimumInteritemSpacing = KSCALE_WIDTH(10);
    layout.minimumLineSpacing =  KSCALE_WIDTH(15);
    layout.sectionInset = UIEdgeInsetsMake(0, KSCALE_WIDTH(30), 0, KSCALE_WIDTH(30));
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,KSCALE_WIDTH(166),KSCALE_WIDTH(375),KSCALE_WIDTH(145)) collectionViewLayout:layout];
    self.collectionView.backgroundColor = KBACK_COLOR;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    
    [self.collectionView registerClass:[QCClassItem class] forCellWithReuseIdentifier:@"item"];
    
    [self addSubview:self.collectionView];
}

- (void)createButton {
    self.advertisingButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(330), KSCALE_WIDTH(345), KSCALE_WIDTH(125))];
    [self.advertisingButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.advertisingButton addTarget:self action:@selector(advertisingAction:) forControlEvents:UIControlEventTouchUpInside];
    [QCClassFunction filletImageView:self.advertisingButton withRadius:KSCALE_WIDTH(20)];
    [self addSubview:self.advertisingButton];
    
    self.recommendedButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(485), KSCALE_WIDTH(90), KSCALE_WIDTH(30))];
    [self.recommendedButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.recommendedButton setImage:KHeaderImage forState:UIControlStateSelected];
    [self.recommendedButton setTitle:@"多多推荐" forState:UIControlStateNormal];
    [self.recommendedButton addTarget:self action:@selector(recommendedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.recommendedButton];
    
    self.limitButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(485), KSCALE_WIDTH(90), KSCALE_WIDTH(30))];
    [self.limitButton setImage:KHeaderImage forState:UIControlStateNormal];
    [self.limitButton setImage:KHeaderImage forState:UIControlStateSelected];
    [self.limitButton setTitle:@"限时秒杀" forState:UIControlStateNormal];
    [self.limitButton addTarget:self action:@selector(limitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.limitButton];
    
    //    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(330), KSCALE_WIDTH(90), KSCALE_WIDTH(5))];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(515), KSCALE_WIDTH(90), KSCALE_WIDTH(5))];
    
    self.lineView.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
    [self addSubview:self.lineView];
    
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCClassItem * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    return item;
}
//指定的这个item是否可以点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//这个item点击之后做的事情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}




#pragma mark - GKCycleScrollViewDataSource

- (NSInteger)numberOfCellsInCycleScrollView:(GKCycleScrollView *)cycleScrollView {
    return 10;
}

- (void)cycleScrollView:(GKCycleScrollView *)cycleScrollView didSelectCellAtIndex:(NSInteger)index {
    
    
    
    
}
- (GKCycleScrollViewCell *)cycleScrollView:(GKCycleScrollView *)cycleScrollView cellForViewAtIndex:(NSInteger)index {
    GKCycleScrollViewCell *cell = [cycleScrollView dequeueReusableCell];
    if (!cell) {
        cell = [GKCycleScrollViewCell new];
        cell.layer.cornerRadius = KSCALE_WIDTH(10.0f);
        cell.layer.masksToBounds = YES;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
    }
    
    //    QCBannerModel * model = self.bannerData[index];
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    cell.imageView.image = KHeaderImage;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.layer.cornerRadius = KSCALE_WIDTH(10.0f);
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

@end


