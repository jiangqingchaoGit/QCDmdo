//
//  QCClassificationViewcontroller.h
//  QCDemo
//
//  Created by JQC on 2020/12/1.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnClassBlock) (NSString * city,NSString * classId);

NS_ASSUME_NONNULL_BEGIN

@interface QCClassificationViewcontroller : UIViewController
@property (nonatomic, copy) ReturnClassBlock classBlock;
@property (nonatomic, strong) NSString * status;

@end

NS_ASSUME_NONNULL_END
