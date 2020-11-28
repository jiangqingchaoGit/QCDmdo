//
//  QCPersonSaveCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonSaveCell.h"

@implementation QCPersonSaveCell

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
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(55))];
        self.titleLabel.text = @"群号/群二维码";
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(50), KSCALE_WIDTH(345), KSCALE_WIDTH(20))];
        self.contentLabel.text = @"开启后，离开或锁定多多，再次进入需要使用密码解锁";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.contentLabel];
        
        self.chooseSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(12), KSCALE_WIDTH(0), KSCALE_WIDTH(0))];
        self.chooseSwitch.onTintColor = [QCClassFunction stringTOColor:@"#ffba00"];
        self.chooseSwitch.tintColor = [UIColor greenColor];
        self.chooseSwitch.on = YES;
        self.chooseSwitch.thumbTintColor = [UIColor whiteColor];

        [self.contentView addSubview:self.chooseSwitch];
    }
    return self;
}

@end
