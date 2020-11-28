//
//  GroupManagerViewController.h
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(NSString * _Nullable str);
NS_ASSUME_NONNULL_BEGIN

@interface GroupManagerViewController : UIViewController
@property (nonatomic, strong) NSString * group_id;
@property (nonatomic, strong) NSMutableArray * numberArr;
@property (nonatomic, strong) NSMutableArray * groupDataArr;

@property (nonatomic,copy)  RefreshBlock refreshBlock;


@end

NS_ASSUME_NONNULL_END
