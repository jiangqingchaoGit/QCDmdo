//
//  QCUngetModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCUngetModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*nick;
@property (nonatomic, strong) NSString<Optional>*red_num;
@property (nonatomic, strong) NSString<Optional>*red_price;

@property (nonatomic, strong) NSString<Optional>*red_total_price;
@property (nonatomic, strong) NSString<Optional>*uid;
@end

NS_ASSUME_NONNULL_END
