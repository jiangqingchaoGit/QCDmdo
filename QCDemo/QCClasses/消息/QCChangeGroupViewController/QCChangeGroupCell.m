//
//  QCChangeGroupCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/27.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChangeGroupCell.h"

@implementation QCChangeGroupCell

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
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
        lineView.backgroundColor = [UIColor clearColor];
        lineView.layer.borderWidth = KSCALE_WIDTH(1);
        lineView.layer.borderColor = [QCClassFunction stringTOColor:@"#ffba00"].CGColor;
        [QCClassFunction filletImageView:lineView withRadius:KSCALE_WIDTH(8)];
        [self.contentView addSubview:lineView];
        
        self.changeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(35), KSCALE_WIDTH(15), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
        [self.changeButton setImage:KHeaderImage forState:UIControlStateNormal];
        [self.changeButton setImage:KHeaderImage forState:UIControlStateSelected];
        [self.contentView addSubview:self.changeButton];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(60))];
        self.contentLabel.text = @"特权试用：1次";
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(235), KSCALE_WIDTH(0), KSCALE_WIDTH(100), KSCALE_WIDTH(60))];
        self.priceLabel.text = @"¥98";
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.font = K_16_FONT;
        self.priceLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.priceLabel];

    }
    return self;
}

@end
