//
//  QCTransferViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/25.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCOpenViewController.h"
#import "QCRealnameViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^TransferBlock)(NSMutableDictionary * messageDic);

@interface QCTransferViewController : UIViewController
@property (nonatomic, copy)TransferBlock myBlock;
@property (nonatomic, strong) UILabel * bankLabel;

@property (nonatomic, strong)NSString * bankId;
@property (nonatomic, strong)NSString * payType;

@property (nonatomic, strong)NSDictionary * payDic;

@end

NS_ASSUME_NONNULL_END
