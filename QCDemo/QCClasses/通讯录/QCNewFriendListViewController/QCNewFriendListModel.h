//
//  QCNewFriendListModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCNewFriendListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*account;
@property (nonatomic, strong) NSString<Optional>*addymd;
@property (nonatomic, strong) NSString<Optional>*fuid;
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*mobile;
@property (nonatomic, strong) NSString<Optional>*nick;
@property (nonatomic, strong) NSString<Optional>*status;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*usid;

@property (nonatomic, strong) NSString<Optional>*audit_status;
@property (nonatomic, strong) NSString<Optional>*audit_time;
@property (nonatomic, strong) NSString<Optional>*create_time;
@property (nonatomic, strong) NSString<Optional>*uuid;

@property (nonatomic, strong) NSString<Optional>*content;

@end

NS_ASSUME_NONNULL_END
