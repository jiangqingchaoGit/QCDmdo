//
//  QCSupportCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSupportCell.h"

@implementation QCSupportCell

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

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(0), KSCALE_WIDTH(200), KSCALE_WIDTH(52))];
        self.nameLabel.text = @"余额支付";
        self.nameLabel.font = K_14_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
        self.chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(315), KSCALE_WIDTH(11), KSCALE_WIDTH(30), KSCALE_WIDTH(30))];
        [self.chooseButton setImage:[UIImage imageNamed:@"unselected_p"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"selected_p"] forState:UIControlStateSelected];
        self.chooseButton.userInteractionEnabled = NO;

        [self.contentView addSubview:self.chooseButton];
  
    }
    return self;
}

- (void)fillCellWithModel:(QCSupportModel *)model {
    self.nameLabel.text = model.bank_name;
    
}

@end
