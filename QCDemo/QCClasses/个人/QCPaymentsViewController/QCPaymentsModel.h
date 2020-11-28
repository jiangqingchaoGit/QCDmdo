//
//  QCPaymentsModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCPaymentsModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *addtime;
@property (nonatomic, strong) NSString<Optional> *addymd;
@property (nonatomic, strong) NSString<Optional> *amount;
@property (nonatomic, strong) NSString<Optional> *balance;
@property (nonatomic, strong) NSString<Optional> *c_id;

@property (nonatomic, strong) NSString<Optional> *c_type;
@property (nonatomic, strong) NSString<Optional> *nick;
@property (nonatomic, strong) NSString<Optional> *product_id;
@property (nonatomic, strong) NSString<Optional> *r_id;
@property (nonatomic, strong) NSString<Optional> *remark;

@property (nonatomic, strong) NSString<Optional> *type_name;
@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *unbalance;
@end

NS_ASSUME_NONNULL_END
