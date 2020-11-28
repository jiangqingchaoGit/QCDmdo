//
//  QCGroupPersonModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/10.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupPersonModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*is_mute;
@property (nonatomic, strong) NSString<Optional>*is_take;
@property (nonatomic, strong) NSString<Optional>*nick_name;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*user_type;
@end

NS_ASSUME_NONNULL_END
