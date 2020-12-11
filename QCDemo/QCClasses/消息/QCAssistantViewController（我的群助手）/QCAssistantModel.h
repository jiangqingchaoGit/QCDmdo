//
//  QCAssistantModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/10.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCAssistantModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *create_time;
@property (nonatomic, strong) NSString<Optional> *des;
@property (nonatomic, strong) NSString<Optional> *group;
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *img;

@property (nonatomic, strong) NSString<Optional> *introduction;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *sort;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *url;
@end

NS_ASSUME_NONNULL_END
