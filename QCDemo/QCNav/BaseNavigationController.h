//
//  BaseNavigationController.h
//  smartHome_brc
//
//  Created by ra on 2018/7/12.
//  Copyright © 2018年 com.gridlink. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol  BaseNavigationDeleGate<NSObject>
//- (void)back;
//
//@end

@interface BaseNavigationController : UINavigationController

@property (nonatomic, strong) NSString * str;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer;
@property (nonatomic,strong)  UIPanGestureRecognizer *panGestureRecognizer;
@end
