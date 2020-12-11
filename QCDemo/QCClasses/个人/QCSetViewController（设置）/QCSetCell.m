//
//  QCSetCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSetCell.h"

@implementation QCSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(46))];
        self.titleLabel.text = @"群号/群二维码";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(245), KSCALE_WIDTH(0), KSCALE_WIDTH(100), KSCALE_WIDTH(46))];
        self.contentLabel.text = @"当前版本1.1";
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.contentLabel];
        
        self.onSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(7.5), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
        self.onSwitch.onTintColor = [QCClassFunction stringTOColor:@"#ffba00"];
        self.onSwitch.tintColor = [UIColor greenColor];
        self.onSwitch.on = NO;
        self.onSwitch.thumbTintColor = [UIColor whiteColor];

        [self.contentView addSubview:self.onSwitch];
        
    }
    return self;
}
@end
