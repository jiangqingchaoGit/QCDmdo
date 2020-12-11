//
//  QCSendEnvelopeViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SendBlock)(NSMutableDictionary * envelopeDic);

@interface QCSendEnvelopeViewController : UIViewController
@property (nonatomic, strong) NSString * target_type;
@property (nonatomic, copy)SendBlock myBlock;
@property (nonatomic, strong) UILabel * bankLabel;

//  银行卡ID
@property (nonatomic, strong)NSString * bankId;
//  付款方式
@property (nonatomic, strong)NSString * payType;

@property (nonatomic, strong)NSDictionary * payDic;


@end

NS_ASSUME_NONNULL_END
