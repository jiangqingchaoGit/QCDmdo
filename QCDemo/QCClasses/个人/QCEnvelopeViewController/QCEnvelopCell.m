//
//  QCEnvelopCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/19.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCEnvelopCell.h"

@implementation QCEnvelopCell

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

- (void)fillCellWithModel:(QCEnvelopModel *)model {
    self.contentLabel.text = @"【红包】我发出的";
    self.timeLabel.text = [QCClassFunction ConvertStrToTime:model.pay_time withType:@"yyyy-MM-dd"];
    self.paymentsLabel.text = [NSString stringWithFormat:@"-%@元",model.red_price];
    self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];

    self.restLabel.text = [NSString stringWithFormat:@"%@/%@",model.gain_num,model.red_num];

}

- (void)fillCellWithEnvelopModel:(QCEnvelopModel *)model {
    self.contentLabel.text = @"【红包】我发出的";
    self.timeLabel.text = [QCClassFunction ConvertStrToTime:model.pay_time withType:@"yyyy-MM-dd"];
    self.restLabel.text = [NSString stringWithFormat:@"%@/%@",model.gain_num,model.red_num];
    self.paymentsLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];


}
@end
