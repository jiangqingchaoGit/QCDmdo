//
//  QCFriendModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/5.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCFriendModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*account;
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*mobile;
@property (nonatomic, strong) NSString<Optional>*nick;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*status;
@property (nonatomic, strong) NSString<Optional>*sex;


@end

NS_ASSUME_NONNULL_END
