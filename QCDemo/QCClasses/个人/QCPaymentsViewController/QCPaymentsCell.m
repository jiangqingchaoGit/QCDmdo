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

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(24))];
        self.contentLabel.font = K_16_BFONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(36), KSCALE_WIDTH(200), KSCALE_WIDTH(20))];
        self.timeLabel.font = K_12_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.timeLabel];
        
        self.paymentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(255), KSCALE_WIDTH(10), KSCALE_WIDTH(100), KSCALE_WIDTH(24))];
        self.paymentsLabel.font = K_16_BFONT;
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        self.paymentsLabel.textAlignment = NSTextAlignmentRight;

        [self.contentView addSubview:self.paymentsLabel];
        
        self.restLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(255), KSCALE_WIDTH(36), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
        self.restLabel.font = K_12_FONT;
        self.restLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.restLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.restLabel];
        
        
    }
    return self;;
}

- (void)fillCellWithModel:(QCPaymentsModel *)model {
    
    
    self.restLabel.text = [NSString stringWithFormat:@"余额:%@",model.balance];
    if ([model.c_type isEqualToString:@"1"]) {
        self.paymentsLabel.text = [NSString stringWithFormat:@"+%@",model.amount];
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
    }
    if ([model.c_type isEqualToString:@"0"]) {
        self.paymentsLabel.text = [NSString stringWithFormat:@"-%@",model.amount];
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];

    }

//    self.paymentsLabel.text = [NSString stringWithFormat:@"+%@",model.amount];
    self.timeLabel.text = [QCClassFunction ConvertStrToTime:model.addtime withType:@"yyyy-MM-dd HH:mm"];
    self.contentLabel.text = [NSString stringWithFormat:@"【%@】",model.type_name];
    
}


- (void)fillCellWithDrawalModel:(QCWithdrawalModel *)model {
    self.restLabel.text = [NSString stringWithFormat:@"余额:%@",model.balance];

    if ([model.status isEqualToString:@"0"]) {
        self.paymentsLabel.text = [NSString stringWithFormat:@"-¥%.2f",[model.amount floatValue]];
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        self.contentLabel.text = [NSString stringWithFormat:@"【%@】",@"提现中"];

    }

    if ([model.status isEqualToString:@"1"]) {
        self.paymentsLabel.text = [NSString stringWithFormat:@"-¥%.2f",[model.amount floatValue]];
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        self.contentLabel.text = [NSString stringWithFormat:@"【%@】",@"提现成功"];

    }
    
    if ([model.status isEqualToString:@"2"]) {
        self.paymentsLabel.text = [NSString stringWithFormat:@"+¥%.2f",[model.amount floatValue]];
        self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
        self.contentLabel.text = [NSString stringWithFormat:@"【%@】",@"提现失败"];

    }
    

    self.timeLabel.text = model.addtime;
    
    
}
@end
