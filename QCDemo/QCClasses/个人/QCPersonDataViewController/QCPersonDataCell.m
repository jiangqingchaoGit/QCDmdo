//
//  QCPersonDataCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonDataCell.h"

@implementation QCPersonDataCell

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

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(100), KSCALE_WIDTH(50))];
        self.titleLabel.text = @"钱包";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(240), KSCALE_WIDTH(0), KSCALE_WIDTH(100), KSCALE_WIDTH(50))];
        self.contentLabel.text = @"思绪云骞";
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.contentLabel];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(316), KSCALE_WIDTH(13), KSCALE_WIDTH(24), KSCALE_WIDTH(24))];
        self.picImageView.image = KHeaderImage;
        [self.contentView addSubview:self.picImageView];
        
    }
    return self;
}

@end
