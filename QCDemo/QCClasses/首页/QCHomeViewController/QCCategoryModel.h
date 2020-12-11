//
//  QCCategoryModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCCategoryModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*img;
@property (nonatomic, strong) NSString<Optional>*name;
@property (nonatomic, strong) NSString<Optional>*pid;
@end

NS_ASSUME_NONNULL_END
