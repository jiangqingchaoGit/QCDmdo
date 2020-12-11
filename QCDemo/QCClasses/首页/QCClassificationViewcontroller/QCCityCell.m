//
//  QCCityCell.m
//  QCCultureDemo
//
//  Created by pf-001 on 2018/9/27.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import "QCCityCell.h"

@implementation QCCityCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH / 4.0 - 2, KSCALE_WIDTH(50))];
        _provinceLabel.textColor = KTEXT_COLOR;
        _provinceLabel.font = K_14_FONT;
        _provinceLabel.text = @"湖北湖北";
        _provinceLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_provinceLabel];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithModel:(QCClassificationModel *)model {
    self.provinceLabel.text = model.name;
}
@end
