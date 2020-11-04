//
//  QCClassItem.m
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCClassItem.h"

@implementation QCClassItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(5), 0, KSCALE_WIDTH(45), KSCALE_WIDTH(45))];
        self.classImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.classImageView withRadius:KSCALE_WIDTH(22.5)];
        [self.contentView addSubview:self.classImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(45), KSCALE_WIDTH(55), KSCALE_WIDTH(20))];
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.text = @"水果多多";
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.contentLabel];

        
    }
    return self;
}
@end
