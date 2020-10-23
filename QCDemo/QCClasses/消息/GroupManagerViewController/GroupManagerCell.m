//
//  GroupManagerCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "GroupManagerCell.h"

@implementation GroupManagerCell

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
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
        self.titleLabel.text = @"群号/群二维码";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(30), KSCALE_WIDTH(335), KSCALE_WIDTH(20))];
        self.contentLabel.text = @"钱多多";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
        [self.contentView addSubview:self.contentLabel];
        

        self.chooseSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(14.5), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
        self.chooseSwitch.onTintColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        self.chooseSwitch.tintColor = [UIColor greenColor];
        self.chooseSwitch.on = YES;
        self.chooseSwitch.thumbTintColor = [UIColor whiteColor];

        [self.contentView addSubview:self.chooseSwitch];
        
    }
    return self;
}

@end
