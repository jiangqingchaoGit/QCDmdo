//
//  QCGoodsModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGoodsModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*delivery_type;
@property (nonatomic, strong) NSString<Optional>*first_img;
@property (nonatomic, strong) NSString<Optional>*goods_price;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*is_new;
@property (nonatomic, strong) NSString<Optional>*is_recommend;
@property (nonatomic, strong) NSString<Optional>*name;
@property (nonatomic, strong) NSString<Optional>*original_price;
@property (nonatomic, strong) NSString<Optional>*ship_address;
@property (nonatomic, strong) NSString<Optional>*hot;

@end

NS_ASSUME_NONNULL_END
