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
@property (nonatomic, strong) NSString<Optional>*cType;
@property (nonatomic, strong) NSString<Optional>*mtype;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*rid;
@property (nonatomic, strong) NSString<Optional>*msgid;
@property (nonatomic, strong) NSString<Optional>*message;
@property (nonatomic, strong) NSString<Optional>*time;
@property (nonatomic, strong) NSString<Optional>*count;
@property (nonatomic, strong) NSString<Optional>*headImage;
@property (nonatomic, strong) NSString<Optional>*isTop;
@property (nonatomic, strong) NSString<Optional>*isRead;
@property (nonatomic, strong) NSString<Optional>*isChat;
@property (nonatomic, strong) NSString<Optional>*tohead;
@property (nonatomic, strong) NSString<Optional>*tonick;
@property (nonatomic, strong) NSString<Optional>*uhead;
@property (nonatomic, strong) NSString<Optional>*unick;

@property (nonatomic, strong) NSString<Optional>*ghead;
@property (nonatomic, strong) NSString<Optional>*gname;
@property (nonatomic, strong) NSString<Optional>*disturb;






@end

NS_ASSUME_NONNULL_END
