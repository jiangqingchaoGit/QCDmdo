//
//  QCGoodsDetailsModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGoodsDetailsModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * content;
@property (nonatomic, strong) NSString <Optional> * create_time;
@property (nonatomic, strong) NSString <Optional> * delivery_type;
@property (nonatomic, strong) NSString <Optional> * first_img;
@property (nonatomic, strong) NSString <Optional> * goods_code;

@property (nonatomic, strong) NSString <Optional> * goods_price;
@property (nonatomic, strong) NSString <Optional> * head;
@property (nonatomic, strong) NSString <Optional> * hot;
@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * is_new;

@property (nonatomic, strong) NSString <Optional> * is_query;
@property (nonatomic, strong) NSString <Optional> * is_recommend;
@property (nonatomic, strong) NSString <Optional> * is_spike;
@property (nonatomic, strong) NSString <Optional> * logistics_price;
@property (nonatomic, strong) NSString <Optional> * nick;

@property (nonatomic, strong) NSString <Optional> * num;
@property (nonatomic, strong) NSString <Optional> * original_price;
@property (nonatomic, strong) NSString <Optional> * ship_address;
@property (nonatomic, strong) NSString <Optional> * status;
@property (nonatomic, strong) NSString <Optional> * stock;

@property (nonatomic, strong) NSString <Optional> * type_id;
@property (nonatomic, strong) NSString <Optional> * uid;
@property (nonatomic, strong) NSString <Optional> * name;
@property (nonatomic, strong) NSString <Optional> * category_name;


@end

NS_ASSUME_NONNULL_END
