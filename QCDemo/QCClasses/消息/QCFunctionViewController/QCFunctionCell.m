//
//  QCFunctionCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCFunctionCell.h"

@implementation QCFunctionCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(15), KSCALE_WIDTH(20), KSCALE_WIDTH(20))];
        self.headerImageView.image = KHeaderImage;
        [self.contentView addSubview:self.headerImageView];
        
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(70 ), KSCALE_WIDTH(15), KSCALE_WIDTH(60), KSCALE_WIDTH(20))];
        self.contentLabel.text = @"添加朋友";
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.contentLabel];
        

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(49), KSCALE_WIDTH(110), KSCALE_WIDTH(1))];
        self.lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];

        [self.contentView addSubview:self.lineView];
        
        self.functionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(170), KSCALE_WIDTH(50))];
        [self.contentView addSubview:self.functionButton];

        
    }
    return self;
}


@end
