//
//  QCPayView.h
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCPayView : UIView
@property (nonatomic, strong) NSMutableDictionary * messageDic;
@property (nonatomic, strong) NSString * type;
- (void)initUI;
@end

NS_ASSUME_NONNULL_END
