//
//  QCWithdrawalModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCWithdrawalModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *addtime;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *amount;
@property (nonatomic, strong) NSString<Optional> *balance;
@property (nonatomic, strong) NSString<Optional> *paynum;

@end

NS_ASSUME_NONNULL_END
