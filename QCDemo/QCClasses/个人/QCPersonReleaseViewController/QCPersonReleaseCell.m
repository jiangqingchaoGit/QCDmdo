//
//  QCPersonReleaseCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/31.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonReleaseCell.h"

@implementation QCPersonReleaseCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(90))];
        self.headerImageView.image = KHeaderImage;

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(60))];
        self.contentLabel.text = @"特权试用：1次";
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(60))];
        self.priceLabel.text = @"特权试用：1次";
        self.priceLabel.font = K_16_FONT;
        self.priceLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.priceLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(60))];
        self.numLabel.text = @"特权试用：1次";
        self.numLabel.font = K_16_FONT;
        self.numLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.numLabel];
        
        self.mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(60))];
        self.mailLabel.text = @"特权试用：1次";
        self.mailLabel.font = K_16_FONT;
        self.mailLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.mailLabel];
        
        self.newsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(60))];
        self.newsLabel.text = @"特权试用：1次";
        self.newsLabel.font = K_16_FONT;
        self.newsLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.newsLabel];
        
        self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 00)];
        
        self.upButton.backgroundColor = KCLEAR_COLOR;
        self.upButton.backgroundColor = KCLEAR_COLOR;
        self.upButton.backgroundColor = KCLEAR_COLOR;

        [self.upButton setTitle:@"" forState:UIControlStateNormal];
        [self.upButton setTitleColor:[QCClassFunction stringTOColor:@""] forState:UIControlStateNormal];
        
        
    }
    return self;
}
@end
