//
//  QCSupportViewController.h
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BankBlock)(NSString * _Nullable bankId,NSString * _Nullable bankName);

NS_ASSUME_NONNULL_BEGIN

@interface QCSupportViewController : UIViewController
@property (nonatomic,copy) BankBlock bankBlock;
@end

NS_ASSUME_NONNULL_END
