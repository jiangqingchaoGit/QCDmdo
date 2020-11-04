//
//  QCWebSocket.m
//  QCDemo
//
//  Created by JQC on 2020/10/21.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCWebSocket.h"
#import "QCChatModel.h"

@interface QCWebSocket ()<SRWebSocketDelegate>
@property (nonatomic, strong) NSTimer *heartBeatTimer; //心跳定时器
@property (nonatomic, strong) NSTimer *dataBeatTimer; //心跳定时器

@property (nonatomic, strong) NSTimer *netWorkTestingTimer; //没有网络的时候检测网络定时器
@property (nonatomic, assign) NSTimeInterval reConnectTime; //重连时间
@property (nonatomic, strong) NSMutableArray *sendDataArray; //存储要发送给服务端的数据
@property (nonatomic, assign) BOOL isActivelyClose;    //用于判断是否主动关闭长连接，如果是主动断开连接，连接失败的代理中，就不用执行 重新连接方法

@end

@implementation QCWebSocket

+ (instancetype)shared{
    static QCWebSocket *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        self.reConnectTime = 0;
        self.isActivelyClose = NO;
        
        self.sendDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

//建立长连接
- (void)connectServer{
    self.isActivelyClose = NO;
    
    self.webSocket.delegate = nil;
    [self.webSocket close];
    _webSocket = nil;
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:K_WBURL]];
    self.webSocket.delegate = self;
    [self.webSocket open];
}

- (void)sendPing:(id)sender{
    [self.webSocket sendPing:nil];
}

#pragma mark --------------------------------------------------
#pragma mark - socket delegate
///开始连接
-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    
    NSLog(@"socket 开始连接");
    self.isConnect = YES;
    self.connectType = WebSocketConnect;
    [self initHeartBeat];///开始心跳
    
}

///连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"连接失败");
    self.isConnect = NO;
    self.connectType = WebSocketDisconnect;
    
    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了");
    
    //判断网络环境
    if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){ //没有网络
        
        [self noNetWorkStartTestingTimer];//开启网络检测定时器
    }else{ //有网络
        
        [self reConnectServer];//连接失败就重连
    }
}

///接收消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string{
    
    NSLog(@"接收消息----  %@",string);
    if ([self.delegate respondsToSelector:@selector(webSocketManagerDidReceiveMessageWithString:)]) {
        [self.delegate webSocketManagerDidReceiveMessageWithString:string];
    }
}


///关闭连接
-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    
    self.isConnect = NO;
    
    if(self.isActivelyClose){
        self.connectType = WebSocketDefault;
        return;
    }else{
        self.connectType = WebSocketDisconnect;
    }
    
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    
    [self destoryHeartBeat]; //断开连接时销毁心跳
    
    //判断网络环境
    if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){ //没有网络
        [self noNetWorkStartTestingTimer];//开启网络检测
    }else{ //有网络
        NSLog(@"关闭连接");
        _webSocket = nil;
        [self reConnectServer];//连接失败就重连
    }
}

///ping
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)pongData{
    
    
    
    
    NSDictionary * jsonDic = [QCClassFunction dictionaryWithJsonString:pongData];
    
    if ([jsonDic[@"code"] intValue] == 200) {
        id result = [QCClassFunction dictionaryWithJsonString:[QCClassFunction AES128_Decrypt:K_AESKEY withStr:jsonDic[@"data"]]];
        
        
        

        if ([result[@"type"] isEqualToString:@"chat"]) {
            //  存数据库操作
            NSLog(@"%@",result[@"msgid"]);
            [QCClassFunction  noticeWithmsgId:result[@"smsid"]];
            
            
            NSDictionary * chatDic = @{@"chatId":result[@"msgid"],@"type":result[@"type"],@"uid":result[@"uid"],@"rid":result[@"touid"],@"msgid":result[@"msgid"],@"message":result[@"message"],@"time":result[@"time"],@"ctype":result[@"ctype"],@"smsid":result[@"smsid"],@"gid":result[@"gid"]};
            
            
            
            
            QCChatModel * chatModel = [[QCChatModel alloc] initWithDictionary:chatDic error:nil];
            [[QCDataBase shared] insertChatModel:chatModel];


//            NSDictionary * listDic = @{@"listId":@"0000001",@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"聊天信息",@"time":@"2020-10-10",@"count":@"1",@"headImage":@"headImageUrl"};
//            QCListModel * listModel = [[QCListModel alloc] initWithDictionary:listDic error:nil];
//            [[QCDataBase shared] insertListModel:listModel];



        }
        
        if ([result[@"type"] isEqualToString:@"notice"]) {
            //  存数据库操作
            NSLog(@"%@",result);
//
//            NSDictionary * dic = result[@"data"];
//            NSDictionary * associatedDic = @{@"associatedId":@"",@"type":@"",@"uid":@"",@"rid":@"",@"msgid":@"",@"message":@"",@"time":@"",@"status":@""};
//
//            QCAssociatedModel * associatedModel = [[QCAssociatedModel alloc] initWithDictionary:associatedDic error:nil];
//            [[QCDataBase shared] insertAssociatedModel:associatedModel];
//
//

        }
        
        

        if ([result[@"type"] isEqualToString:@"repply"]) {
            //  存数据库操作
            NSLog(@"%@",result);

            NSDictionary * dic = result[@"data"];
            NSDictionary * associatedDic = @{@"associatedId":@"",@"type":@"",@"uid":@"",@"rid":@"",@"msgid":@"",@"message":@"",@"time":@"",@"status":@""};

            QCAssociatedModel * associatedModel = [[QCAssociatedModel alloc] initWithDictionary:associatedDic error:nil];
            [[QCDataBase shared] insertAssociatedModel:associatedModel];



        }
        

    }else{
        return;;
    }
    
    
//    NSDictionary * listDic = @{@"listId":@"0000001",@"type":@"chat",@"uid":@"001",@"rid":@"002",@"msgid":@"999999",@"message":@"聊天信息",@"time":@"2020-10-10",@"count":@"1",@"headImage":@"headImageUrl"};
//    QCListModel * listModel = [[QCListModel alloc] initWithDictionary:listDic error:nil];
//    [[QCDataBase shared] insertListModel:listModel];
    
    

    

    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    
}


#pragma mark - NSTimer

//初始化心跳
- (void)initHeartBeat{
    //心跳没有被关闭
    if(self.heartBeatTimer) {
        return;
    }
    [self destoryHeartBeat];
    dispatch_main_async_safe(^{
        self.heartBeatTimer  = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(senderheartBeat) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:self.heartBeatTimer forMode:NSRunLoopCommonModes];
    })
    
    
    dispatch_main_async_safe(^{
        self.dataBeatTimer  = [NSTimer timerWithTimeInterval:6 target:self selector:@selector(senderDataBeat) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:self.dataBeatTimer forMode:NSRunLoopCommonModes];
    })
    
    
    
    
}
//重新连接
- (void)reConnectServer{
    if(self.webSocket.readyState == SR_OPEN){
        return;
    }
    
    if(self.reConnectTime > 1024){  //重连10次 2^10 = 1024
        self.reConnectTime = 0;
        return;
    }
    
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.reConnectTime *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(weakself.webSocket.readyState == SR_OPEN && weakself.webSocket.readyState == SR_CONNECTING) {
            return;
        }
        
        [weakself connectServer];
        //        CTHLog(@"正在重连......");
        
        if(weakself.reConnectTime == 0){  //重连时间2的指数级增长
            weakself.reConnectTime = 2;
        }else{
            weakself.reConnectTime *= 2;
        }
    });
    
}

//发送心跳
- (void)senderheartBeat{
    //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
    kWeakSelf(self);
    dispatch_main_async_safe(^{
        if(weakself.webSocket.readyState == SR_OPEN){

            [weakself sendPing:nil];
            

        }
    });
}


- (void)senderDataBeat{
    kWeakSelf(self);
    dispatch_main_async_safe(^{
        if(weakself.webSocket.readyState == SR_OPEN){

            [weakself sendDataToServer:[weakself getJsonData]];
            

        }
    });
}

//没有网络的时候开始定时 -- 用于网络检测
- (void)noNetWorkStartTestingTimer{
    kWeakSelf(self);
    dispatch_main_async_safe(^{
        weakself.netWorkTestingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakself selector:@selector(noNetWorkStartTesting) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakself.netWorkTestingTimer forMode:NSDefaultRunLoopMode];
    });
}
//定时检测网络
- (void)noNetWorkStartTesting{
    //有网络
    if(AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable)
    {
        //关闭网络检测定时器
        [self destoryNetWorkStartTesting];
        //开始重连
        [self reConnectServer];
    }
}

//取消网络检测
- (void)destoryNetWorkStartTesting{
    kWeakSelf(self);
    dispatch_main_async_safe(^{
        if(weakself.netWorkTestingTimer)
        {
            [weakself.netWorkTestingTimer invalidate];
            weakself.netWorkTestingTimer = nil;
        }
    });
}


//取消心跳
- (void)destoryHeartBeat{
    kWeakSelf(self);
    dispatch_main_async_safe(^{
        if(weakself.heartBeatTimer)
        {
            [weakself.heartBeatTimer invalidate];
            weakself.heartBeatTimer = nil;
            
            [weakself.dataBeatTimer invalidate];
            weakself.dataBeatTimer = nil;
            
        }
    });
}


//关闭长连接
- (void)RMWebSocketClose{
    self.isActivelyClose = YES;
    self.isConnect = NO;
    self.connectType = WebSocketDefault;
    if(self.webSocket)
    {
        [self.webSocket close];
        _webSocket = nil;
    }
    
    //关闭心跳定时器
    [self destoryHeartBeat];
    
    //关闭网络检测定时器
    [self destoryNetWorkStartTesting];
}


//发送数据给服务器
- (void)sendDataToServer:(id)data{
    [self.sendDataArray addObject:data];
    
    //[_webSocket sendString:data error:NULL];
    
    //没有网络
    if (AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        //开启网络检测定时器
        [self noNetWorkStartTestingTimer];
    }
    else //有网络
    {
        if(self.webSocket != nil)
        {
            // 只有长连接OPEN开启状态才能调 send 方法，不然会Crash
            if(self.webSocket.readyState == SR_OPEN)
            {
                //                if (self.sendDataArray.count > 0)
                //                {
                //                    NSString *data = self.sendDataArray[0];
                //                    [_webSocket sendString:data error:NULL]; //发送数据
                
                [self.webSocket send:data];
                //                    [self.sendDataArray removeObjectAtIndex:0];
                //
                //                }
            }
            else if (self.webSocket.readyState == SR_CONNECTING) //正在连接
            {
                NSLog(@"正在连接中，重连后会去自动同步数据");
            }
            else if (self.webSocket.readyState == SR_CLOSING || self.webSocket.readyState == SR_CLOSED) //断开连接
            {
                //调用 reConnectServer 方法重连,连接成功后 继续发送数据
                [self reConnectServer];
            }
        }
        else
        {
            [self connectServer]; //连接服务器
        }
    }
}




- (NSString *)getJsonData{
    
    NSString * str = @"type=pong&uid=iOS";
    NSString * signStr = [QCClassFunction MD5:str];
    NSDictionary * dic = @{@"type":@"pong",@"uid":@"iOS"};
    NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];

    NSString *output = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSDictionary * dataDic = @{@"sign":signStr,@"data":output};

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];

    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    

    return jsonString;
}



/*
 *
 NSString * msgid = [NSString stringWithFormat:@"%@%@",K_UID,[QCClassFunction getNowTimeTimestamp]];
 NSString * str = [NSString stringWithFormat:@"ctype=0&gid=0message=123&mtype=0&msgid=%@&touid=%@&type=chat&uid=%@",msgid,K_TUID,K_UID];
 NSDictionary * dic = @{@"ctype":@"0",@"gid":@"0",@"message":@"123",@"mtype":@"0",@"msgid":msgid ,@"touid":K_UID,@"type":@"chat",@"uid":K_UID};


 NSString * signStr = [QCClassFunction MD5:str];
//    NSDictionary * dic = @{@"token":K_TOKEN,@"type":@"login",@"uid":K_UID};
 
 
 NSString * jsonDic = [QCClassFunction jsonStringWithDictionary:dic];
 NSString * outPut = [[QCClassFunction AES128_Encrypt:K_AESKEY encryptData:[jsonDic dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
 NSDictionary * dataDic = @{@"sign":signStr,@"data":outPut};
 NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
 NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 NSLog(@"%@",K_AESKEY);
 
//
 
 
 [[QCWebSocket shared] sendDataToServer:jsonString];
 */
@end
