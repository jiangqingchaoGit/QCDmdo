//
//  QCAssistantCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/23.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAssistantCell.h"

@implementation QCAssistantCell

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
        
        self.contentView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCALE_WIDTH(103))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
        [QCClassFunction filletImageView:lineView withRadius:KSCALE_WIDTH(8)];
        [self.contentView addSubview:lineView];
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(18), KSCALE_WIDTH(67), KSCALE_WIDTH(67))];
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(33.5)];
        [self.contentView addSubview:self.headerImageView];
        
        

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(20), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(50), KSCALE_WIDTH(140), KSCALE_WIDTH(35))];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [QCClassFunction filletImageView:self.contentLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.contentLabel];
        
        self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(270), KSCALE_WIDTH(36), KSCALE_WIDTH(72), KSCALE_WIDTH(32))];
        self.addButton.backgroundColor = [QCClassFunction stringTOColor:@"#FF3300"];
        self.addButton.titleLabel.font = K_16_FONT;
        [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
        [self.addButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
        [QCClassFunction filletImageView:self.addButton withRadius:KSCALE_WIDTH(6)];
        [self.contentView addSubview:self.addButton];

        
    }
    return self;
}

- (void)fillCellWithModel:(QCAssistantModel *)model {
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.img AppendingString:@"" placeholderImage:@"header"];
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.introduction;

}

@end
