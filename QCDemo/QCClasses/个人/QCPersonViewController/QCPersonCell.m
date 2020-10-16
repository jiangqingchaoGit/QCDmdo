//
//  QCPersonCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonCell.h"

@implementation QCPersonCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(23), KSCALE_WIDTH(15), KSCALE_WIDTH(24), KSCALE_WIDTH(24))];
        self.headerImageView.image = KHeaderImage;
        [self.contentView addSubview:self.headerImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(15), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        self.titleLabel.text = @"钱包";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(54), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#D7D7D7"];
        [self.contentView addSubview:lineView];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(340), KSCALE_WIDTH(22), KSCALE_WIDTH(10), KSCALE_WIDTH(10))];
        imageView.image = [UIImage imageNamed:@"向右箭头"];
        [self.contentView addSubview:imageView];
    }
    return self;;
}

@end
