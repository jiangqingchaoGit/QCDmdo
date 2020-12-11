//
//  QCAFNetWorking.h
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/30.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

//  数据请求成功的block的回调
typedef void(^successBlock)(NSURLSessionDataTask *operation, id responseObject);

//  数据请求失败的block的回调
typedef void(^failureBlock)(NSURLSessionDataTask *operation, NSError *error);

// post上传照片的回调
typedef void(^formDataBlock)(id<AFMultipartFormData> formData);

//  下载请求的回调
typedef void(^downloadProgressBlock)(CGFloat downloadProgress);

//  下载位置的回调
typedef void(^downloadPathBlock)(NSURL *downloadUrl, NSURL *filePath);

//  下载成功的回调
typedef void(^downloadSuccessBlock)(NSURLResponse *response, NSURL *filePath, NSError *error);

//  网络判断的回调
typedef void(^statusBlock)(AFNetworkReachabilityStatus status);


@interface QCAFNetWorking : NSObject

/*
 *  GET数据请求
 */
+(void)QCPOST:(NSString *)urlStr parameters:(NSDictionary *)dict success:(successBlock)successBlock failure:(failureBlock)failureBlock;
/*
 

 *  POST数据请求
 */

+(void)QCGETWeather:(NSString *)urlStr parameters:(NSDictionary *)dict success:(successBlock)successBlock failure:(failureBlock)failureBlock;

+(void)QCGET:(NSString *)urlStr parameters:(NSDictionary *)dict success:(successBlock)successBlock failure:(failureBlock)failureBlock;
/*
 *  下载请求
 */

+ (void)QCDownload:(NSString *)urlStr downloadProgress:(downloadProgressBlock)downloadProgressBlock downloadPath:(downloadPathBlock)downloadPathBlock downloadSuccess:(downloadSuccessBlock)downloadSuccessBlock;
/*
 *  上传请求
 */
+(void)QCUpload:(NSString *)urlStr parameters:(NSDictionary *)dict
       formData:(formDataBlock)formDataBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock;
/*
 *  判断网路
 */
+(void)QCNetworkKindWithStatus:(statusBlock)statusBlock;


@end
