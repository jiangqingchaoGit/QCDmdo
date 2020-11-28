//
//  QCSaveCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSaveCell.h"

@implementation QCSaveCell

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
        
        self.saveLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(90), 0, KSCALE_WIDTH(205), KSCALE_WIDTH(26))];
        self.saveLabel.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        self.saveLabel.text = @"多多安全已为您开启聊天加密";
        self.saveLabel.font = K_12_FONT;
        self.saveLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
        self.saveLabel.textAlignment = NSTextAlignmentCenter;
        [QCClassFunction filletImageView:self.saveLabel withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.saveLabel];
        
        self.saveImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(100), KSCALE_WIDTH(7), KSCALE_WIDTH(12), KSCALE_WIDTH(12))];
        self.saveImageView.hidden = YES;
        self.saveImageView.image = KHeaderImage;
        [self.contentView addSubview:self.saveImageView];
        
    }
    return self;
}

@end
