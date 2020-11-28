//
//  QCAssociatedModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCAssociatedModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*associatedId;
@property (nonatomic, strong) NSString<Optional>*type;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*rid;
@property (nonatomic, strong) NSString<Optional>*msgid;
@property (nonatomic, strong) NSString<Optional>*message;
@property (nonatomic, strong) NSString<Optional>*time;
@property (nonatomic, strong) NSString<Optional>*status;
@property (nonatomic, strong) NSString<Optional>*applyid;
@property (nonatomic, strong) NSString<Optional>*smsid;

@end

NS_ASSUME_NONNULL_END
