//
//  QCChooseTimeCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChooseTimeCell.h"

@implementation QCChooseTimeCell

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

        self.chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(11.5), KSCALE_WIDTH(20), KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        self.chooseButton.backgroundColor = KCLEAR_COLOR;
        [self.chooseButton setImage:[UIImage imageNamed:@"num_unselect"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"num_select"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.chooseButton];
        

        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(20), KSCALE_WIDTH(200), KSCALE_WIDTH(32))];
        self.timeLabel.text = @"思绪云骞";
        self.timeLabel.font = K_16_FONT;
        self.timeLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.timeLabel];


        
    }
    return self;
}

@end
