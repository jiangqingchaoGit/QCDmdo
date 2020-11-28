//
//  QCGroupDataViewController.h
//  QCDemo
//
//  Created by JQC on 2020/10/21.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCGroupListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface QCGroupDataViewController : UIViewController
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * groupDataArr;
@property (nonatomic, strong) NSMutableArray * personDataArr;
@property (nonatomic, strong) NSString * groupId;


@end

NS_ASSUME_NONNULL_END
