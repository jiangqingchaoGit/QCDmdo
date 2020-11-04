//
//  QCListModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*listId;
@property (nonatomic, strong) NSString<Optional>*type;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*rid;
@property (nonatomic, strong) NSString<Optional>*msgid;
@property (nonatomic, strong) NSString<Optional>*message;
@property (nonatomic, strong) NSString<Optional>*time;
@property (nonatomic, strong) NSString<Optional>*count;
@property (nonatomic, strong) NSString<Optional>*headImage;
@property (nonatomic, strong) NSString<Optional>*isTop;
@property (nonatomic, strong) NSString<Optional>*isRead;


@end

NS_ASSUME_NONNULL_END
