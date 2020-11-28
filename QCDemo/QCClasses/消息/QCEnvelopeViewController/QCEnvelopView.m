//
//  QCEnvelopView.m
//  QCDream
//
//  Created by JQC on 2019/2/22.
//  Copyright © 2019 JQC. All rights reserved.
//

#import "QCEnvelopView.h"

@implementation QCEnvelopView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = KWHITE_COLOR;
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, KSCREEN_WIDTH - 30, 20)];
        _label.text = @"2秒抢完";
        _label.font = K_14_FONT;
        _label.textColor = KTEXT_COLOR;
        [self.contentView addSubview:_label];
        
        

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
