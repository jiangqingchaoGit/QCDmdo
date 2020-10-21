//
//  QCInvitationCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCInvitationCell.h"

@implementation QCInvitationCell

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
        self.invitationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCALE_WIDTH(30))];
        self.invitationLabel.text = @"您邀请了 jason yang 、mmmm进入群聊";
        self.invitationLabel.font = K_14_FONT;
        self.invitationLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.invitationLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.invitationLabel];
    }
    return self;
}

@end
