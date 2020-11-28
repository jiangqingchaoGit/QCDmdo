//
//  QCSendCardViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/24.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MessageBlock)(NSString * messageStr);

@interface QCSendCardViewController : UIViewController
@property (nonatomic, copy)MessageBlock myBlock;

@end

NS_ASSUME_NONNULL_END
