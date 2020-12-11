//
//  QCBankCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCBankCell.h"

@implementation QCBankCell

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

        self.contentView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20), KSCALE_WIDTH(335), KSCALE_WIDTH(125))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#FFFFFF"];
        lineView.userInteractionEnabled = NO;
        [QCClassFunction filletImageView:lineView withRadius:KSCALE_WIDTH(12)];
        [self.contentView addSubview:lineView];
        
        self.bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(45), KSCALE_WIDTH(40), KSCALE_WIDTH(200), KSCALE_WIDTH(24))];
        self.bankLabel.font = K_16_BFONT;
        self.bankLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.bankLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(45), KSCALE_WIDTH(65), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
        self.nameLabel.font = K_12_FONT;
        self.nameLabel.textColor = [QCClassFunction stringTOColor:@"#AEAEAE"];
        [self.contentView addSubview:self.nameLabel];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(45), KSCALE_WIDTH(100), KSCALE_WIDTH(260), KSCALE_WIDTH(24))];
        self.numberLabel.font = K_24_BFONT;
        self.numberLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.numberLabel];
        
        
        
    }
    return self;;
}
- (void)fillCellWithModel:(QCBankModel *)model {
    self.nameLabel.text = model.bank_code;
    self.bankLabel.text = model.bank_name;
    self.numberLabel.text = model.bank_no;
}


@end
