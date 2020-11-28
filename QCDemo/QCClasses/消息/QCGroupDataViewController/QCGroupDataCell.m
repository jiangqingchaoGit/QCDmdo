//
//  QCGroupDataCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupDataCell.h"

@implementation QCGroupDataCell

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
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.titleLabel.text = @"群号/群二维码";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(240), KSCALE_WIDTH(0), KSCALE_WIDTH(100), KSCALE_WIDTH(52))];
        self.contentLabel.text = @"钱多多";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.contentLabel];
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(305), KSCALE_WIDTH(7), KSCALE_WIDTH(38), KSCALE_WIDTH(38))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(19)];
        [self.contentView addSubview:self.headerImageView];
        
        self.chooseSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(10.5), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
        self.chooseSwitch.onTintColor = [QCClassFunction stringTOColor:@"#ffba00"];
        self.chooseSwitch.tintColor = [UIColor greenColor];
        self.chooseSwitch.on = NO;
        self.chooseSwitch.thumbTintColor = [UIColor whiteColor];

        [self.contentView addSubview:self.chooseSwitch];
        
    }
    return self;
}

@end
