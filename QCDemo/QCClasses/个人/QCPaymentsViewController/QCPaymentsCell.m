//
//  QCPaymentsCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPaymentsCell.h"

@implementation QCPaymentsCell

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

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(15), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        self.contentLabel.text = @"钱包";
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(15), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        self.timeLabel.text = @"钱包";
        self.timeLabel.font = K_16_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.timeLabel];
        
        self.paymentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(15), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        self.paymentsLabel.text = @"钱包";
        self.paymentsLabel.font = K_16_FONT;
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.paymentsLabel];
        
        self.restLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(65), KSCALE_WIDTH(15), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        self.restLabel.text = @"钱包";
        self.restLabel.font = K_16_FONT;
        self.restLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.restLabel];
        
        
    }
    return self;;
}

@end
