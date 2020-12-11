//
//  QCPersonSellModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCPersonSellModel : JSONModel

@property (nonatomic, strong) NSString<Optional>*address;
@property (nonatomic, strong) NSString<Optional>*addtime;
@property (nonatomic, strong) NSString<Optional>*complete_time;
@property (nonatomic, strong) NSString<Optional>*create_time;
@property (nonatomic, strong) NSString<Optional>*delivery_time;

@property (nonatomic, strong) NSString<Optional>*delivery_type;
@property (nonatomic, strong) NSString<Optional>*first_img;
@property (nonatomic, strong) NSString<Optional>*gid;
@property (nonatomic, strong) NSString<Optional>*goods_price;
@property (nonatomic, strong) NSString<Optional>*head;

@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*is_new;
@property (nonatomic, strong) NSString<Optional>*is_pay;
@property (nonatomic, strong) NSString<Optional>*logistics_price;
@property (nonatomic, strong) NSString<Optional>*name;

@property (nonatomic, strong) NSString<Optional>*nick;
@property (nonatomic, strong) NSString<Optional>*num;
@property (nonatomic, strong) NSString<Optional>*order_no;
@property (nonatomic, strong) NSString<Optional>*order_status;
@property (nonatomic, strong) NSString<Optional>*pay_price;

@property (nonatomic, strong) NSString<Optional>*pay_time;
@property (nonatomic, strong) NSString<Optional>*pay_type;
@property (nonatomic, strong) NSString<Optional>*price;
@property (nonatomic, strong) NSString<Optional>*refund_status;
@property (nonatomic, strong) NSString<Optional>*refund_time;

@property (nonatomic, strong) NSString<Optional>*remark;
@property (nonatomic, strong) NSString<Optional>*seller_id;
@property (nonatomic, strong) NSString<Optional>*stock;
@property (nonatomic, strong) NSString<Optional>*trade_no;
@property (nonatomic, strong) NSString<Optional>*uid;

@property (nonatomic, strong) NSString<Optional>*usermobile;
@property (nonatomic, strong) NSString<Optional>*username;
@end

NS_ASSUME_NONNULL_END
