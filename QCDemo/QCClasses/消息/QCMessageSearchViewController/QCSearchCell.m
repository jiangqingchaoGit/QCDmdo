//
//  QCSearchCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSearchCell.h"

@implementation QCSearchCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
        [self.contentView addSubview:self.headerImageView];
        


        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(21))];
        self.nameLabel.text = @"思绪云骞";
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
        
        self.idLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(36), KSCALE_WIDTH(200), KSCALE_WIDTH(21))];
        self.idLabel.text = @"多多号：123456";
        self.idLabel.font = K_12_FONT;
        self.idLabel.textColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
        [self.contentView addSubview:self.idLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(150), KSCALE_WIDTH(30), KSCALE_WIDTH(210), KSCALE_WIDTH(22))];
        self.timeLabel.font = K_12_FONT;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
        [self.contentView addSubview:self.timeLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCALE_WIDTH(72), KSCALE_WIDTH(375), KSCALE_WIDTH(10))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];

        
    }
    return self;
}


@end
