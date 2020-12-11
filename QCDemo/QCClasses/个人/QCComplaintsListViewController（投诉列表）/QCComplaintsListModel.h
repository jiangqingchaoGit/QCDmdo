//
//  QCComplaintsListModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCComplaintsListModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*attrs;
@property (nonatomic, strong) NSString<Optional>*context;
@property (nonatomic, strong) NSString<Optional>*create_time;
@property (nonatomic, strong) NSString<Optional>*handle_context;
@property (nonatomic, strong) NSString<Optional>*handle_date;

@property (nonatomic, strong) NSString<Optional>*handle_user_id;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*is_delete;
@property (nonatomic, strong) NSString<Optional>*is_notice;
@property (nonatomic, strong) NSString<Optional>*mobile;

@property (nonatomic, strong) NSString<Optional>*star;
@property (nonatomic, strong) NSString<Optional>*status;
@property (nonatomic, strong) NSString<Optional>*targer_id;
@property (nonatomic, strong) NSString<Optional>*targer_name;
@property (nonatomic, strong) NSString<Optional>*targer_type;


@property (nonatomic, strong) NSString<Optional>*type;
@property (nonatomic, strong) NSString<Optional>*type_name;
@property (nonatomic, strong) NSString<Optional>*uid;
@end

NS_ASSUME_NONNULL_END
