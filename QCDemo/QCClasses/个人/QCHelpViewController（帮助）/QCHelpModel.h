//
//  QCHelpModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/8.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCHelpModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *content;
@property (nonatomic, strong) NSString<Optional> *create_time;
@property (nonatomic, strong) NSString<Optional> *first_type;
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *is_recommend;

@property (nonatomic, strong) NSString<Optional> *modify_time;
@property (nonatomic, strong) NSString<Optional> *modify_uid;
@property (nonatomic, strong) NSString<Optional> *release_time;
@property (nonatomic, strong) NSString<Optional> *second_type;
@property (nonatomic, strong) NSString<Optional> *sort;


@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *uid;
@property (nonatomic, strong) NSString<Optional> *visits_num;
@end

NS_ASSUME_NONNULL_END
