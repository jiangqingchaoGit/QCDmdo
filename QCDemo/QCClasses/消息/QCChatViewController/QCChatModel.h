//
//  QCChatModel.h
//  QCDemo
//
//  Created by JQC on 2020/10/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCChatModel : JSONModel

@property (nonatomic, strong) NSString<Optional>*chatId;
@property (nonatomic, strong) NSString<Optional>*listId;
@property (nonatomic, strong) NSString<Optional>*mtype;
@property (nonatomic, strong) NSString<Optional>*type;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*rid;
@property (nonatomic, strong) NSString<Optional>*msgid;
@property (nonatomic, strong) NSString<Optional>*message;
@property (nonatomic, strong) NSString<Optional>*time;
@property (nonatomic, strong) NSString<Optional>*ctype;
@property (nonatomic, strong) NSString<Optional>*smsid;
@property (nonatomic, strong) NSString<Optional>*gid;
@property (nonatomic, strong) NSString<Optional>*cellH;
@property (nonatomic, strong) NSString<Optional>*tohead;
@property (nonatomic, strong) NSString<Optional>*tonick;
@property (nonatomic, strong) NSString<Optional>*uhead;
@property (nonatomic, strong) NSString<Optional>*unick;

@property (nonatomic, strong) NSString<Optional>*ghead;
@property (nonatomic, strong) NSString<Optional>*gname;
@property (nonatomic, strong) NSString<Optional>*canSend;
@property (nonatomic, strong) NSString<Optional>*canMessage;
@property (nonatomic, strong) NSString<Optional>*isSend;







@end

NS_ASSUME_NONNULL_END
