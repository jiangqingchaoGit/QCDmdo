//
//  QCGroupListModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*create_time;
@property (nonatomic, strong) NSString<Optional>*group_code;
@property (nonatomic, strong) NSString<Optional>*group_user_id;
@property (nonatomic, strong) NSString<Optional>*head_img;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*member_num;
@property (nonatomic, strong) NSString<Optional>*name;
@property (nonatomic, strong) NSString<Optional>*nick_name;

@end

NS_ASSUME_NONNULL_END
