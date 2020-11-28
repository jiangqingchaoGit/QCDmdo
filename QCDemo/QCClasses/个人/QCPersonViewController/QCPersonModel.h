//
//  QCPersonModel.h
//  QCDemo
//
//  Created by JQC on 2020/10/24.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCPersonModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *nick;
@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *head_img;
@property (nonatomic, strong) NSString<Optional> *balance;
@property (nonatomic, strong) NSString<Optional> *mobile;
@property (nonatomic, strong) NSString<Optional> *sex;
@property (nonatomic, strong) NSString<Optional> *fabu;
@property (nonatomic, strong) NSString<Optional> *order;
@property (nonatomic, strong) NSString<Optional> *buy;
@property (nonatomic, strong) NSString<Optional> *real_name;
@property (nonatomic, strong) NSString<Optional> *identifyNum;
@property (nonatomic, strong) NSString<Optional> *is_pay_wallet;
@property (nonatomic, strong) NSString<Optional> *account;






@end

NS_ASSUME_NONNULL_END
