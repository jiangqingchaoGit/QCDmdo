//
//  QCEnvelopModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCEnvelopModel : JSONModel


@property (nonatomic, strong) NSString<Optional> *gain_num;
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *pay_time;
@property (nonatomic, strong) NSString<Optional> *red_num;
@property (nonatomic, strong) NSString<Optional> *red_price;
@property (nonatomic, strong) NSString<Optional> *price;
@property (nonatomic, strong) NSString<Optional> *red_id;
@property (nonatomic, strong) NSString<Optional> *addtime;
@property (nonatomic, strong) NSString<Optional> *nick;



@end

NS_ASSUME_NONNULL_END
