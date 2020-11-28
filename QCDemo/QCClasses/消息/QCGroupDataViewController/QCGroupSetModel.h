//
//  QCGroupSetModel.h
//  QCDemo
//
//  Created by JQC on 2020/11/10.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCGroupSetModel : JSONModel
@property (nonatomic, strong) NSString<Optional>*code;  //  群二维码
@property (nonatomic, strong) NSString<Optional>*group_code;    //  群号
@property (nonatomic, strong) NSString<Optional>*group_user_id; //  群主ID
@property (nonatomic, strong) NSString<Optional>*head_img;  //  群头像
@property (nonatomic, strong) NSString<Optional>*id;    //  群ID
@property (nonatomic, strong) NSString<Optional>*is_delete; //  群已经解散
@property (nonatomic, strong) NSString<Optional>*is_jieping;    //  截屏
@property (nonatomic, strong) NSString<Optional>*is_nraq;   //  内容安全
@property (nonatomic, strong) NSString<Optional>*is_privacy;    //  群隐私
@property (nonatomic, strong) NSString<Optional>*is_verify;     //  群验证
@property (nonatomic, strong) NSString<Optional>*is_mute;     //  群禁言

@property (nonatomic, strong) NSString<Optional>*member_num;    //  群成员数量
@property (nonatomic, strong) NSString<Optional>*name;  //  群名称
@property (nonatomic, strong) NSString<Optional>*placard;   //  群公告



@end

NS_ASSUME_NONNULL_END
