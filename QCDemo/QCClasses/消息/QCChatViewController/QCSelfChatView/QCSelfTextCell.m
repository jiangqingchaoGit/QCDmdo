//
//  QCSelfTextCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSelfTextCell.h"

@implementation QCSelfTextCell

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
        
        self.imageViewButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.imageViewButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.imageViewButton];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.contentLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.text = @"3.如果是在模拟器上运行正常，真机上不正常，那可能是网络不是用的同一个网络，设置下网络（未做过测试）";
        [self.contentView addSubview:self.contentLabel];
        
        self.unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.unreadLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        self.unreadLabel.font = K_16_FONT;
        self.unreadLabel.numberOfLines = 0;
        self.unreadLabel.textColor = KTEXT_COLOR;
        self.unreadLabel.text = @"未读";
        [self.contentView addSubview:self.unreadLabel];
        
        self.unreadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.unreadImageView.image = KHeaderImage;
        [self.contentView addSubview:self.unreadImageView];
        
        
        self.readLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.readLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        self.readLabel.font = K_16_FONT;
        self.readLabel.numberOfLines = 0;
        self.readLabel.textColor = KTEXT_COLOR;
        self.readLabel.text = @"已读";
        [self.contentView addSubview:self.readLabel];
        
        self.readImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.readImageView.image = KHeaderImage;
        [self.contentView addSubview:self.readImageView];
        
    }
    return self;
}

@end
