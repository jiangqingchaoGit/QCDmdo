//
//  QCChooseBankCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/1.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChooseBankCell.h"

@implementation QCChooseBankCell

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
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(25), KSCALE_WIDTH(15), KSCALE_WIDTH(200), KSCALE_WIDTH(24))];
        self.contentLabel.text = @"中国农业银行(**8888)";
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.contentLabel];
        
        self.chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(330), KSCALE_WIDTH(10), KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        self.chooseButton.backgroundColor = KCLEAR_COLOR;
        [self.chooseButton setImage:[UIImage imageNamed:@"num_unselect"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"num_select"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.chooseButton];
        
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(25), KSCALE_WIDTH(54), KSCALE_WIDTH(325), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}
@end
