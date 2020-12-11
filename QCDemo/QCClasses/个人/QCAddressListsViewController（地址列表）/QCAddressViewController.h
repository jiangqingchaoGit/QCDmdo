//
//  QCAddressViewController.h
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QCAddressViewController : UIViewController
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) NSString * addressStr;
@property (nonatomic, strong) NSDictionary * addressDic;

@property (nonatomic, strong) QCAddressModel * model;



@end

NS_ASSUME_NONNULL_END
