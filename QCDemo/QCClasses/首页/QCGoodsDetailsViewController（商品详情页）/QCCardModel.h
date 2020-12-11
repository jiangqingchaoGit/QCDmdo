//
//  QCCardModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCCardModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * bank_name;
@property (nonatomic, strong) NSString <Optional> * bank_no;
@property (nonatomic, strong) NSString <Optional> * id;

@end

NS_ASSUME_NONNULL_END
