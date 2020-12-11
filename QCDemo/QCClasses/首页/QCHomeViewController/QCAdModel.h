//
//  QCAdModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCAdModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*ad_type;
@property (nonatomic, strong) NSString<Optional>*create_time;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*img_url;
@property (nonatomic, strong) NSString<Optional>*jump_type;
@property (nonatomic, strong) NSString<Optional>*jump_url;
@property (nonatomic, strong) NSString<Optional>*name;
@property (nonatomic, strong) NSString<Optional>*sort;
@property (nonatomic, strong) NSString<Optional>*status;
@property (nonatomic, strong) NSString<Optional>*uid;
@end

NS_ASSUME_NONNULL_END
