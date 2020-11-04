//
//  QCExpressionItem.m
//  QCDemo
//
//  Created by JQC on 2020/10/27.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCExpressionItem.h"

@implementation QCExpressionItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.expressionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(51), KSCALE_WIDTH(51))];
        [self.contentView addSubview:self.expressionImageView];
        
        self.expressionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(51), KSCALE_WIDTH(51))];
        self.expressionButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.expressionButton];
        
        
    }
    return self;
}
@end
