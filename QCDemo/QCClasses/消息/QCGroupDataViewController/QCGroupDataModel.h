//
//  QCGroupDataModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/10.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupDataModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*nick_name;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*user_type;
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*sex;


@property (nonatomic, strong) NSString<Optional>*mute_time;
@property (nonatomic, strong) NSString<Optional>*is_mute;
@property (nonatomic, strong) NSString<Optional>*is_take;
@end

NS_ASSUME_NONNULL_END
