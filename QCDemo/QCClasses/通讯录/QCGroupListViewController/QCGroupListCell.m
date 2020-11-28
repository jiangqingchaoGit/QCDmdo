//
//  QCGroupListCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/9.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupListCell.h"

@implementation QCGroupListCell

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
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
        [self.contentView addSubview:self.headerImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(10), KSCALE_WIDTH(90), KSCALE_WIDTH(26))];
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(36), KSCALE_WIDTH(90), KSCALE_WIDTH(26))];
        self.numberLabel.font = K_12_FONT;
        self.numberLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.numberLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(20), KSCALE_WIDTH(160), KSCALE_WIDTH(32))];
        self.timeLabel.font = K_10_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];


        
    }
    return self;
}

- (void)fillCellWithModel:(QCGroupListModel *)model {
    
//    self.headerImageView.image = KHeaderImage;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head_img AppendingString:@"" placeholderImage:@"header"];
    self.nameLabel.text = model.name;
    self.numberLabel.text = [NSString stringWithFormat:@"群员:%@",model.member_num];
    self.timeLabel.text = model.create_time;
    
}





@end
