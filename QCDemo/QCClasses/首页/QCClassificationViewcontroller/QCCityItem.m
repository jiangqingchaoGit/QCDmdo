//
//  QCCityItem.m
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/27.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import "QCCityItem.h"

#define KWIDTH KSCREEN_WIDTH / 4.0

@implementation QCCityItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        

        
        _cityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(21.75), KSCALE_WIDTH(25), KSCALE_WIDTH(50),KSCALE_WIDTH(50))];
//        _cityImageView.image = [UIImage imageNamed:@"header"];
        [QCClassFunction filletImageView:_cityImageView withRadius:KSCALE_WIDTH(25)];
        [self.contentView addSubview:_cityImageView];
        
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(75), KWIDTH, KSCALE_WIDTH(35))];
        _cityLabel.text = @"大学之城";
        _cityLabel.textColor = KTEXT_COLOR;
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.font = K_14_FONT;
        [self.contentView addSubview:_cityLabel];
    }
    return self;
}

- (void)fillCellWithModel:(QCClassificationModel *)model {
    self.cityLabel.text = model.name;
    [QCClassFunction sd_imageView:self.cityImageView ImageURL:model.img AppendingString:@"" placeholderImage:@"header"];
    
    
}
@end
