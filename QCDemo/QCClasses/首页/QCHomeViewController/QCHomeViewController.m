//
//  QCHomeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHomeViewController.h"
#import "QCLoginViewController.h"
#import "QCWebSocket.h"
#import <CommonCrypto/CommonDigest.h>

@interface QCHomeViewController ()


@end

@implementation QCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBACK_COLOR;
//    [[QCWebSocket shared] connectServer];


    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [[QCMapInstance shared] startLocationIsNeedCity:YES WithCompletion:^(CLLocationCoordinate2D coor, NSString *city, NSString *cityCode) {
        NSLog(@"%@",city);
    }];


}
- (void)buttonAction:(UIButton *)sender {
    
    NSLog(@"%@",[QCClassFunction AES128_Decrypt:@"6961260090843016" withStr:@"zzpxqtroKtr93EF6Wq+n8tdb9ZdRDAdYmQcyJabGev+ee10Dew5cED36rriFgCRSN2c5MqljlQk/ycfnaazvsqryLOEHN9cbCXo96LuFkkdVJo0aigxu/sgeLRoEUdzFQqbliVctUix/fzBD2o330a/wSos8Ri01WoR+JxVQzgKvATM8b6FQzk6r9W/5FVz8"]);
    
//    [[QCAsyncSocket shared] initSocketWithHost:@"app-test.xianduoduo123.com" andPart:[@"7272" intValue]];


//
    
    NSString * str = @"o=1&v=123";
    NSString * signStr = [self md5:str];
    
    NSDictionary * dataDic = @{@"sign":signStr,@"data":str};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *output = [[QCClassFunction AES128_Encrypt:@"5961260030843025" encryptData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    

    NSData * data = [[NSString stringWithFormat:@"%@\n",output] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [[QCWebSocket shared] sendDataToServer:data];
    


}






- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://mobile.umeng.com/social";

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);

            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}


- (NSString *) md5 : (NSString *) str {
    // 判断传入的字符串是否为空
    if (! str) return nil;
    // 转成utf-8字符串
    const char *cStr = str.UTF8String;
    // 设置一个接收数组
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    // 对密码进行加密
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *md5Str = [NSMutableString string];
    // 转成32字节的16进制
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}


-(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

@end
