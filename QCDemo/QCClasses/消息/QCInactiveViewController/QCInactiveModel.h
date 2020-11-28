//
//  QCInactiveModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/12.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCInactiveModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*nick_name;
@property (nonatomic, strong) NSString<Optional>*mute_time;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*last_time;
@property (nonatomic, strong) NSString<Optional>*take_time;


@end

NS_ASSUME_NONNULL_END
