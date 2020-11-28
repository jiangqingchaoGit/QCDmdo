//
//  QCEnveolpModel.h
//  QCDream
//
//  Created by JQC on 2019/2/22.
//  Copyright © 2019 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol QCEnveolpListModel;

@interface QCEnveolpListModel : JSONModel

//@property (nonatomic, strong) NSString <Optional>* markId;
//@property (nonatomic, strong) NSString <Optional>* headerUrl;
//@property (nonatomic, strong) NSString <Optional>* nickName;
//@property (nonatomic, strong) NSString <Optional>* userId;
//@property (nonatomic, strong) NSString <Optional>* money;
//@property (nonatomic, strong) NSString <Optional>* rapType;
//@property (nonatomic, strong) NSString <Optional>* time;


@property (nonatomic, strong) NSString <Optional>* u;
@property (nonatomic, strong) NSString <Optional>* n;
@property (nonatomic, strong) NSString <Optional>* b;
@property (nonatomic, strong) NSString <Optional>* m;
@property (nonatomic, strong) NSString <Optional>* t;
@property (nonatomic, strong) NSString <Optional>* ct;

@end

@interface QCEnveolpModel : JSONModel


//@property (nonatomic, strong) NSString<Optional>*time;
//@property (nonatomic, strong) NSString<Optional>*remainMoney;
//@property (nonatomic, strong) NSString<Optional>*remainEnveolp;
//@property (nonatomic, strong) NSArray<QCEnveolpListModel>* enveolpList;


@property (nonatomic, strong) NSString<Optional>*r;
@property (nonatomic, strong) NSString<Optional>*n;
@property (nonatomic, strong) NSString<Optional>*u;
@property (nonatomic, strong) NSString<Optional>*s;
@property (nonatomic, strong) NSString<Optional>*m;
@property (nonatomic, strong) NSString<Optional>*l;
@property (nonatomic, strong) NSString<Optional>*c;
@property (nonatomic, strong) NSString<Optional>*t;
@property (nonatomic, strong) NSArray<QCEnveolpListModel>* d;
@end

NS_ASSUME_NONNULL_END
