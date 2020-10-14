//
//  QCMapInstance.m
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/26.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import "QCMapInstance.h"

//  声明全局变量关键字
static QCMapInstance * _mapInstance = nil;
@implementation QCMapInstance



+ (QCMapInstance *)shared
{
//     GCD引入了一个新特征，更为方便:
//    https://blog.csdn.net/lyl123_456/article/details/52462621
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mapInstance = [[QCMapInstance alloc] init];
    });
    return _mapInstance;

}


-(void)startLocationIsNeedCity: (BOOL)isNeedCity WithCompletion: (locationCompletion)completion
{
    _completion = completion;
    _isNeedCity = isNeedCity;
    /**判断 是否开启定位模式*/
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        /**创建一个location管理器*/
        _locationManager = [[CLLocationManager alloc] init];
        
        /**设置代理，实现定位成功或失败后执行相应地方法*/
        _locationManager.delegate = self;
        
        /**设置定位精度，有好几个等级，如果对精确度要求不是太高，可以设置10米或百米*/
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        /**设置距离过滤,当我超出上次定位多少米之后才重新定位*/
        _locationManager.distanceFilter = 10;
        
        /**当当前系统版本大于8.0的时候，执行以下方法*/
        
        if ([UIDevice currentDevice].systemVersion.floatValue >8.0) {
            /**ios8新加的，当使用的时候获取地理位置*/
            [_locationManager requestAlwaysAuthorization];
        }
        /**发送请求*/
        [_locationManager startUpdatingLocation];
    }
    else
    {
        

    }
}

/**返回定位信息*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    /**停止更新定位信息*/
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations firstObject];
    if (_isNeedCity) {
        /**进行反向地理解析，解析地址得到城市信息*/
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:[locations firstObject] completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *mark = [placemarks firstObject];
              NSDictionary *tmpDict = [QCClassFunction Read:@"cityDic"];
            self->_completion(location.coordinate,mark.locality,[tmpDict objectForKey:[mark.locality stringByReplacingOccurrencesOfString:@"市" withString:@""]]);

            
        }];
    }
    else
    {
        _completion(location.coordinate,nil,nil);
    }
}

/**返回错误信息*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);


}

@end
