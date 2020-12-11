//
//  QCPayTypeView.h
//  QCDemo
//
//  Created by JQC on 2020/12/8.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TypeBlock)(NSDictionary * payTypeDic);

@interface QCPayTypeView : UIView
@property (nonatomic, strong) NSString * typeStr;
@property (nonatomic, strong) NSString * statusStr;
@property (nonatomic, copy)TypeBlock typeBlock;

- (void)initUI;
@end

NS_ASSUME_NONNULL_END
