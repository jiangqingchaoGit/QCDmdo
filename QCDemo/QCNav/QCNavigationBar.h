//
//  QCNavigationBar.h
//  QCCultureDemo
//
//  Created by JQC on 2019/11/5.
//  Copyright © 2019 pf-001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QCNavigationBar : UIView
@property (nonatomic, strong) UIColor * backColor;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * rightButton;
- (void)setNav;
- (void)hiddenNav;
- (void)showNav;

- (void)showNavWithAlpha:(CGFloat)alpha;


- (void)backAction;
- (void)rightAction;

@end

NS_ASSUME_NONNULL_END
