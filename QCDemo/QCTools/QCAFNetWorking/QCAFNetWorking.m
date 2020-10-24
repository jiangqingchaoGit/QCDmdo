//
//  QCAFNetWorking.m
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/30.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import "QCAFNetWorking.h"

@implementation QCAFNetWorking
//https://www.jianshu.com/p/5e187c9d389b


/*
 *  GET数据请求
 */
+(void)QCGET:(NSString *)urlStr parameters:(NSDictionary *)dict success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:dict headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id result = [QCClassFunction dictionaryWithJsonString:[QCClassFunction AES128_Decrypt:@"6961260090843016" withStr:jsonStr]];
        successBlock(task,result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
    
    
}

/*
 *  POST数据请求
 */

+(void)QCPOST:(NSString *)urlStr parameters:(NSDictionary *)dict success:(successBlock)successBlock failure:(failureBlock)failureBlock {
    urlStr = [NSString stringWithFormat:@"%@%@",K_HTTPURL,urlStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //开启系统菊花
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [manager POST:urlStr parameters:dict headers:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {


        NSString * jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id result = [QCClassFunction dictionaryWithJsonString:[QCClassFunction AES128_Decrypt:K_AESKEY withStr:jsonStr]];
        successBlock(task,result);


        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    }];
    
    

    
    
}

/*
 *  下载请求
 */
+ (void)QCDownload:(NSString *)urlStr downloadProgress:(downloadProgressBlock)downloadProgressBlock downloadPath:(downloadPathBlock)downloadPathBlock downloadSuccess:(downloadSuccessBlock)downloadSuccessBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 下载进度
        downloadProgressBlock(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //   设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        downloadPathBlock(targetPath,[NSURL URLWithString:filePath]);
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法 WKNSLog(@"下载完成：");
        downloadSuccessBlock(response,filePath,error);
        
    }];
    [task resume];
    
    
}


/*
 *  上传请求
 */

+(void)QCUpload:(NSString *)urlStr parameters:(NSDictionary *)dict
       formData:(formDataBlock)formDataBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //
    //    [manager POST:[NSString stringWithFormat:@"%@%@",HOST,urlStr] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //        formDataBlock(formData);
    //    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    //        successBlock(task,result);
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        failureBlock(task,error);
    //
    //    }];
}


/*
 *  判断网路
 */
+(void)QCNetworkKindWithStatus:(statusBlock)statusBlock{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        statusBlock(status);
    }];
    
}






@end
