//
//  QCChatDetailsCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/17.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChatDetailsCell.h"

@implementation QCChatDetailsCell

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
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.titleLabel.text = @"群号/群二维码";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        

        self.chooseSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(10.5), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
        self.chooseSwitch.onTintColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        self.chooseSwitch.tintColor = [UIColor greenColor];
        self.chooseSwitch.on = YES;
        self.chooseSwitch.thumbTintColor = [UIColor whiteColor];

        [self.contentView addSubview:self.chooseSwitch];
        
    }
    return self;
}

@end
