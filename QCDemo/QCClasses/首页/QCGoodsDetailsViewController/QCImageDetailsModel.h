//
//  QCImageDetailsModel.h
//  QCDemo
//
//  Created by JQC on 2020/12/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCImageDetailsModel : JSONModel
@property (nonatomic, strong) NSString <Optional> * create_time;
@property (nonatomic, strong) NSString <Optional> * goods_id;
@property (nonatomic, strong) NSString <Optional> * goods_img;
@property (nonatomic, strong) NSString <Optional> * goods_type;
@property (nonatomic, strong) NSString <Optional> * id;
@property (nonatomic, strong) NSString <Optional> * cellH;

@end

NS_ASSUME_NONNULL_END
