//
//  QCGoodsListViewController.h
//  QCDemo
//
//  Created by JQC on 2020/12/2.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCGoodsListViewController : UIViewController
@property (nonatomic, strong) NSString * classId;
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, assign) NSInteger i;

- (void)GETDATA;

@end

NS_ASSUME_NONNULL_END
