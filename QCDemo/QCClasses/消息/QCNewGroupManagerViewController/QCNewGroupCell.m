//
//  QCNewGroupCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCNewGroupCell.h"

@implementation QCNewGroupCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
        [self.contentView addSubview:self.headerImageView];
        
        self.headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.headerButton];
        


        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(32))];
        self.nameLabel.text = @"思绪云骞";
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];


        
    }
    return self;
}
@end
