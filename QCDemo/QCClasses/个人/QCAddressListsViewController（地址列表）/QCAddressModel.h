//
//  QCAddressModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/5.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCAddressModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*address;
@property (nonatomic, strong) NSString<Optional>*area_id;
@property (nonatomic, strong) NSString<Optional>*area_name;
@property (nonatomic, strong) NSString<Optional>*city_id;
@property (nonatomic, strong) NSString<Optional>*city_name;

@property (nonatomic, strong) NSString<Optional>*create_time;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*is_default;
@property (nonatomic, strong) NSString<Optional>*mobile;

@property (nonatomic, strong) NSString<Optional>*name;
@property (nonatomic, strong) NSString<Optional>*province_id;
@property (nonatomic, strong) NSString<Optional>*province_name;
@property (nonatomic, strong) NSString<Optional>*uid;


@end

NS_ASSUME_NONNULL_END
