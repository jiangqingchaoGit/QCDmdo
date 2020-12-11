//
//  QCAddressListsViewController.h
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^AddressBlock)(NSDictionary * _Nullable addressDic);

NS_ASSUME_NONNULL_BEGIN

@interface QCAddressListsViewController : UIViewController
@property (nonatomic, strong) NSString * status;
@property (nonatomic, copy) AddressBlock addressBlock;

@end

NS_ASSUME_NONNULL_END
