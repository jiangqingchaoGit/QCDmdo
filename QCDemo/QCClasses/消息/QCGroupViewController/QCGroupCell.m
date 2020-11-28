//
//  QCGroupCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupCell.h"

@implementation QCGroupCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
        [self.contentView addSubview:self.headerImageView];
        
        self.headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(55), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.headerButton];
        
        self.chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(11.5), KSCALE_WIDTH(20), KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        self.chooseButton.backgroundColor = KCLEAR_COLOR;

        [self.chooseButton setImage:[UIImage imageNamed:@"num_unselect"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"num_select"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.chooseButton];
        

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(125), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(32))];
        self.nameLabel.text = @"思绪云骞";
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];


        
    }
    return self;
}

- (void)fillCellWithModel:(QCBookModel *)model {
    self.nameLabel.text = model.nick;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head AppendingString:nil placeholderImage:@"header"];
}


- (void)fillCellWithgroupModel:(QCGroupDataModel *)model {
    self.nameLabel.text = model.nick_name;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head AppendingString:nil placeholderImage:@"header"];

}

@end
