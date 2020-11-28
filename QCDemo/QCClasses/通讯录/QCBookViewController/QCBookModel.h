//
//  QCBookModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCBookModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*account;
@property (nonatomic, strong) NSString<Optional>*add_type;
@property (nonatomic, strong) NSString<Optional>*addtime;
@property (nonatomic, strong) NSString<Optional>*addymd;
@property (nonatomic, strong) NSString<Optional>*clean_time;
@property (nonatomic, strong) NSString<Optional>*des;
@property (nonatomic, strong) NSString<Optional>*fname;
@property (nonatomic, strong) NSString<Optional>*friend_apply_id;
@property (nonatomic, strong) NSString<Optional>*fuid;
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*is_black_list;
@property (nonatomic, strong) NSString<Optional>*is_disturb;
@property (nonatomic, strong) NSString<Optional>*is_screenshot;
@property (nonatomic, strong) NSString<Optional>*is_sort;
@property (nonatomic, strong) NSString<Optional>*mobile;
@property (nonatomic, strong) NSString<Optional>*uid;
@property (nonatomic, strong) NSString<Optional>*usid;
@property (nonatomic, strong) NSString<Optional>*nick;


@end

NS_ASSUME_NONNULL_END
