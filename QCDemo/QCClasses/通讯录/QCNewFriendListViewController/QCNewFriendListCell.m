//
//  QCNewFriendListCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCNewFriendListCell.h"

@implementation QCNewFriendListCell

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
        
        self.headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.headerButton];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(21))];
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        self.nameLabel.text = @"思绪云骞";
        [self.contentView addSubview:self.nameLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(36), KSCALE_WIDTH(290), KSCALE_WIDTH(26))];
        self.contentLabel.text = @"来自某某某的申请";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.contentLabel];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(289), KSCALE_WIDTH(20), KSCALE_WIDTH(66), KSCALE_WIDTH(32))];
        self.statusLabel.font = K_14_FONT;
        self.statusLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.contentView addSubview:self.statusLabel];
        
   
        self.agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(289), KSCALE_WIDTH(20), KSCALE_WIDTH(66), KSCALE_WIDTH(32))];
        self.agreeButton.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
        self.agreeButton.titleLabel.font = K_14_FONT;
        [self.agreeButton setTitle:@"同意" forState:UIControlStateNormal];
        [self.agreeButton setTitleColor:KTEXT_COLOR forState:UIControlStateNormal];
        [QCClassFunction filletImageView:self.agreeButton withRadius:KSCALE_WIDTH(6)];
        [self.contentView addSubview:self.agreeButton];
        
        self.refuseButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(210), KSCALE_WIDTH(20), KSCALE_WIDTH(66), KSCALE_WIDTH(32))];
        self.refuseButton.backgroundColor = [QCClassFunction stringTOColor:@"#66CC66"];
        self.refuseButton.titleLabel.font = K_14_FONT;
        [self.refuseButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [self.refuseButton setTitleColor:KBACK_COLOR forState:UIControlStateNormal];
        [QCClassFunction filletImageView:self.refuseButton withRadius:KSCALE_WIDTH(6)];
        [self.contentView addSubview:self.refuseButton];

        
    }
    return self;
}

- (void)fillCellWithModel:(QCNewFriendListModel *)model {
    self.nameLabel.text = model.nick;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:@"" AppendingString:model.head placeholderImage:@"header"];
    
    
    self.contentLabel.text = model.content;
    if (model.status) {
        if ([model.status isEqualToString:@"0"]) {
            self.statusLabel.hidden = YES;
            self.agreeButton.hidden = NO;
            self.refuseButton.hidden = NO;

        }else if ([model.status isEqualToString:@"1"]){
            self.statusLabel.hidden = NO;
            self.agreeButton.hidden = YES;
            self.refuseButton.hidden = YES;
            self.statusLabel.text = @"已同意";


        }else if ([model.status isEqualToString:@"2"]){
            self.statusLabel.hidden = NO;
            self.agreeButton.hidden = YES;
            self.refuseButton.hidden = YES;
            self.statusLabel.text = @"已拒绝";


        }else{
            self.statusLabel.hidden = NO;
            self.agreeButton.hidden = YES;
            self.refuseButton.hidden = YES;
            self.statusLabel.text = @"已过期";

        }
        
    }else{
        if ([model.audit_status isEqualToString:@"1"]) {
            self.statusLabel.hidden = YES;
            self.agreeButton.hidden = NO;
            self.refuseButton.hidden = NO;

        }else if ([model.audit_status isEqualToString:@"2"]){
            self.statusLabel.hidden = NO;
            self.agreeButton.hidden = YES;
            self.refuseButton.hidden = YES;
            self.statusLabel.text = @"已同意";


        }else if ([model.audit_status isEqualToString:@"3"]){
            self.statusLabel.hidden = NO;
            self.agreeButton.hidden = YES;
            self.refuseButton.hidden = YES;
            self.statusLabel.text = @"已拒绝";


        }else{
            self.statusLabel.hidden = NO;
            self.agreeButton.hidden = YES;
            self.refuseButton.hidden = YES;
            self.statusLabel.text = @"已过期";

        }
    }
    

}



@end
