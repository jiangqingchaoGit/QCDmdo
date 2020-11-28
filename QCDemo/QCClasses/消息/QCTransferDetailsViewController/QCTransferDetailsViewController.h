//
//  QCTransferDetailsViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SureBlock)(NSString * messageStr);


@interface QCTransferDetailsViewController : UIViewController
@property (nonatomic, copy)SureBlock sureBlock;
@property (nonatomic, strong)NSDictionary * typeDic;
@property (nonatomic, strong)NSString * type;


@end

NS_ASSUME_NONNULL_END
