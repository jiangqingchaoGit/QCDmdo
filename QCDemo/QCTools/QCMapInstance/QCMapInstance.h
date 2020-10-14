//
//  QCMapInstance.h
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/26.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

//  block

typedef void (^locationCompletion) (CLLocationCoordinate2D coor,NSString *city,NSString *cityCode);

@interface QCMapInstance : NSObject<CLLocationManagerDelegate>{
    //  定位对象
    CLLocationManager *_locationManager;
    //  block对象
    locationCompletion _completion;
    //  是否需要传入城市
    BOOL _isNeedCity;
}


+ (QCMapInstance *)shared;
- (void)startLocationIsNeedCity: (BOOL)isNeedCity WithCompletion: (locationCompletion)completion;
@end
