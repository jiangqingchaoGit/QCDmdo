//
//  QCComplaintsModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCComplaintsModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*name;
@property (nonatomic, strong) NSString<Optional>*option_key;
@property (nonatomic, strong) NSString<Optional>*option_value;
@end

NS_ASSUME_NONNULL_END
