//
//  QCTransferViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/25.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^TransferBlock)(NSMutableDictionary * messageDic);

@interface QCTransferViewController : UIViewController
@property (nonatomic, copy)TransferBlock myBlock;

@end

NS_ASSUME_NONNULL_END
