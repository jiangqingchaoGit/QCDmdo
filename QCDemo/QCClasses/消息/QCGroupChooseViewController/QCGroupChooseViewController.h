//
//  QCGroupChooseViewController.h
//  QCDemo
//
//  Created by JQC on 2020/11/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^RefreshBlock)(NSString * _Nullable str);


@interface QCGroupChooseViewController : UIViewController
@property (nonatomic, strong) NSMutableArray * numberArr;
@property (nonatomic, strong) NSString * group_id;
@property (nonatomic,copy)  RefreshBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
