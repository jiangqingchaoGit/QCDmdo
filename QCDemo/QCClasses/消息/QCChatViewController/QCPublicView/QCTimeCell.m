//
//  QCTimeCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCTimeCell.h"

@implementation QCTimeCell

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
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(150), KSCALE_WIDTH(3), KSCALE_WIDTH(75), KSCALE_WIDTH(24))];
        self.timeLabel.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        self.timeLabel.font = K_12_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#333333"];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [QCClassFunction filletImageView:self.timeLabel withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

- (void)fillCellWithModel:(QCChatModel *)model {
    
    CGFloat labelH = [QCClassFunction getWidthWithString:model.time andFontSize:KSCALE_WIDTH(12) andConstrainedHeight:KSCALE_WIDTH(24)];
    self.timeLabel.frame = CGRectMake(KSCALE_WIDTH(180) - labelH / 2.0, KSCALE_WIDTH(3), labelH + KSCALE_WIDTH(15), KSCALE_WIDTH(24));
    self.timeLabel.text = [QCClassFunction getDateDisplayString:[model.time integerValue]];

}

@end
