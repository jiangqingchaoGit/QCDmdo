//
//  QCNoSpeakCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCNoSpeakCell.h"

@implementation QCNoSpeakCell

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
        
        self.headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.headerButton];
        

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(21))];
        self.nameLabel.text = @"思绪云骞";
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(42), KSCALE_WIDTH(40), KSCALE_WIDTH(18))];
        self.contentLabel.text = @"管理员";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.backgroundColor = [QCClassFunction stringTOColor:@"#66CC66"];
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [QCClassFunction filletImageView:self.contentLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.contentLabel];
        

        
    }
    return self;
}


@end
