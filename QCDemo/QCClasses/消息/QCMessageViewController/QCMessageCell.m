//
//  QCMessageCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCMessageCell.h"

@implementation QCMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
        [self.contentView addSubview:self.headerImageView];
        
        self.headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.headerButton];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(57), KSCALE_WIDTH(10), KSCALE_WIDTH(20), KSCALE_WIDTH(20))];
        self.numberLabel.text = @"99";
        self.numberLabel.font = K_10_FONT;
        self.numberLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FF5E5E"];
        self.numberLabel.textColor = KBACK_COLOR;
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        [QCClassFunction filletImageView:self.numberLabel withRadius:KSCALE_WIDTH(10)];
        [self.contentView addSubview:self.numberLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(21))];
        self.nameLabel.text = @"思绪云骞";
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(160), KSCALE_WIDTH(17.5), KSCALE_WIDTH(25), KSCALE_WIDTH(16))];
        self.tipLabel.text = @"官方";
        self.tipLabel.font = K_8_FONT;
        self.tipLabel.textColor = [QCClassFunction stringTOColor:@"#282828"];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.layer.borderWidth = KSCALE_WIDTH(1);
        self.tipLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#282828"].CGColor;

        [QCClassFunction filletImageView:self.tipLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.tipLabel];
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(36), KSCALE_WIDTH(290), KSCALE_WIDTH(26))];
        self.contentLabel.text = @"请问你的水果什么时候发货？";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(15), KSCALE_WIDTH(60), KSCALE_WIDTH(21))];
        self.timeLabel.text = @"13:36";
        self.timeLabel.font = K_10_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];

        
    }
    return self;
}

@end
