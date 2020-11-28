//
//  QCGetEnvelopeModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGetEnvelopeModel : JSONModel


@property (nonatomic, strong) NSString<Optional>*addtime;
@property (nonatomic, strong) NSString<Optional>*addymd;
@property (nonatomic, strong) NSString<Optional>*head;
@property (nonatomic, strong) NSString<Optional>*id;
@property (nonatomic, strong) NSString<Optional>*is_max;
@property (nonatomic, strong) NSString<Optional>*nick;
@property (nonatomic, strong) NSString<Optional>*price;
@property (nonatomic, strong) NSString<Optional>*red_id;
@property (nonatomic, strong) NSString<Optional>*ruid;
@property (nonatomic, strong) NSString<Optional>*uid;

@end

NS_ASSUME_NONNULL_END
