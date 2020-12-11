//
//  QCNavigationBar.m
//  QCCultureDemo
//
//  Created by JQC on 2019/11/5.
//  Copyright © 2019 pf-001. All rights reserved.
//

#import "QCNavigationBar.h"

@interface QCNavigationBar ()

@end

@implementation QCNavigationBar



- (void)setNav {
    self.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KNavHight);
    
//    self.backColor = [UIColor purpleColor];
    self.backgroundColor = [self.backColor colorWithAlphaComponent:1];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightButton];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavHight - 44);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(KSCALE_WIDTH(44));

    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavHight - 44);
        make.left.mas_equalTo(100);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(KSCALE_WIDTH(175));
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavHight- 44);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(KSCALE_WIDTH(44));
    }];


}

- (void)showNavWithAlpha:(CGFloat)alpha {
    if (alpha > 1) {
        self.backgroundColor = [self.backColor colorWithAlphaComponent:1];
        self.titleLabel.alpha = 1;
    }else if (alpha < 0) {
        self.backgroundColor = [self.backColor colorWithAlphaComponent:0];
        self.titleLabel.alpha = 0;

    }else{
        self.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
        self.titleLabel.alpha = alpha;

    }
}
- (void)hiddenNav {
    self.backgroundColor = [self.backColor colorWithAlphaComponent:0];
    self.titleLabel.alpha = 0;

}
- (void)showNav {
    self.backgroundColor = [self.backColor colorWithAlphaComponent:1];
    self.titleLabel.alpha = 1;

}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = KSCALE_FONT(16);
        _titleLabel.textColor = KBLACK_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"";
        _titleLabel.backgroundColor = KCLEAR_COLOR;

        
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton new];
        [_rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _rightButton;
}

#pragma mark - backAction(返回)
- (void)backAction {
    [[QCClassFunction getCurrentViewController].navigationController popViewControllerAnimated:YES];
}
- (void)rightAction {

}
@end
