//
//  QCPayCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/8.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPayCell.h"

@implementation QCPayCell

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
        self.payLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.payLabel.text = @"余额支付";
        self.payLabel.font = K_14_FONT;
        self.payLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.payLabel];
        
        self.chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(315), KSCALE_WIDTH(11), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
        [self.chooseButton setImage:[UIImage imageNamed:@"unselected_p"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"selected_p"] forState:UIControlStateSelected];
        self.chooseButton.userInteractionEnabled = NO;

        [self.contentView addSubview:self.chooseButton];
    }
    return self;
}
- (void)fillCellWithModel:(QCBankModel *)model {
    self.payLabel.text = [NSString stringWithFormat:@"%@ %@",model.bank_name,model.bank_no];

}

@end
