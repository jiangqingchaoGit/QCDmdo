//
//  QCSupportModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCSupportModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*bank_code;
@property (nonatomic, strong) NSString<Optional>*bank_name;
@property (nonatomic, strong) NSString<Optional>*id;
@end

NS_ASSUME_NONNULL_END
