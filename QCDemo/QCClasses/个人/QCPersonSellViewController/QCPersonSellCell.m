//
//  QCPersonSellCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonSellCell.h"

@implementation QCPersonSellCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(16)];
        [self.contentView addSubview:self.headerImageView];
        
        self.nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(60), KSCALE_WIDTH(10), KSCALE_WIDTH(120), KSCALE_WIDTH(32))];
        self.nickLabel.text = @"思绪云骞";
        self.nickLabel.font = K_14_FONT;
        self.nickLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.nickLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(51), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(155), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(32))];
        self.statusLabel.font = K_14_FONT;
        self.statusLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.statusLabel];
        

        
        
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(62), KSCALE_WIDTH(90), KSCALE_WIDTH(90))];
        self.contentImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.contentImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.contentImageView];

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(62), KSCALE_WIDTH(225), KSCALE_WIDTH(55))];
        self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(120), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
        self.priceLabel.text = @"¥3700";
        self.priceLabel.font = K_16_BFONT;
        self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
        [self.contentView addSubview:self.priceLabel];
        

        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(190), KSCALE_WIDTH(120), KSCALE_WIDTH(165), KSCALE_WIDTH(30))];
        self.timeLabel.text = @"下单时间： 2020-10-30 15:20";
        self.timeLabel.font = K_10_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];

        
        

        self.refundButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(105), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32))];
        self.refundButton.backgroundColor = KCLEAR_COLOR;
        self.refundButton.titleLabel.font = K_14_FONT;
        self.refundButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.refundButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        [QCClassFunction filletImageView:self.refundButton withRadius:KSCALE_WIDTH(8)];
        [self.refundButton setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.refundButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.refundButton];

        self.reminderButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(190), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32))];
        self.reminderButton.backgroundColor = KCLEAR_COLOR;
        self.reminderButton.titleLabel.font = K_14_FONT;
        self.reminderButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.reminderButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        [QCClassFunction filletImageView:self.reminderButton withRadius:KSCALE_WIDTH(8)];
        [self.reminderButton setTitle:@"催单" forState:UIControlStateNormal];
        [self.reminderButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.reminderButton];

        self.goodsButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32))];
        self.goodsButton.backgroundColor = KCLEAR_COLOR;
        self.goodsButton.titleLabel.font = K_14_FONT;
        self.goodsButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.goodsButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        [QCClassFunction filletImageView:self.goodsButton withRadius:KSCALE_WIDTH(8)];
        [self.goodsButton setTitle:@"发货" forState:UIControlStateNormal];
        [self.goodsButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.goodsButton];
        
        self.delectButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32))];
        self.delectButton.backgroundColor = KCLEAR_COLOR;
        self.delectButton.titleLabel.font = K_14_FONT;
        self.delectButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.delectButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        [QCClassFunction filletImageView:self.delectButton withRadius:KSCALE_WIDTH(8)];
        [self.delectButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.delectButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.delectButton];

        UIView * goodsLineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(199), KSCALE_WIDTH(375), KSCALE_WIDTH(6))];
        goodsLineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:goodsLineView];
        
    }
    return self;
}

- (void)fillCellWithModel:(QCPersonSellModel *)model {
    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head AppendingString:@"" placeholderImage:@"header"];
    self.nickLabel.text = model.nick;
    self.timeLabel.text = [NSString stringWithFormat:@"下单时间： %@",model.create_time];
    self.contentLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    [QCClassFunction sd_imageView:self.contentImageView ImageURL:model.first_img AppendingString:@"" placeholderImage:@"header"];

    
    
//    1未支付，2待发货，3待收货，4交易成功，5订单挂起,6退款中,7拒绝退款,8-退款成功
    switch ([model.order_status intValue]) {
        case 0:
                
            break;
            
        case 1:
                
            break;
        case 2:
            self.refundButton.hidden = NO;
            self.reminderButton.hidden = YES;
            self.goodsButton.hidden = NO;
            self.delectButton.hidden = YES;

            self.refundButton.frame = CGRectMake(KSCALE_WIDTH(190), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            self.goodsButton.frame = CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            [self.refundButton setTitle:@"退款" forState:UIControlStateNormal];

            self.statusLabel.text = @"待发货";


            break;
        case 3:
            self.refundButton.hidden = NO;
            self.reminderButton.hidden = YES;
            self.goodsButton.hidden = YES;
            self.delectButton.hidden = YES;

            self.refundButton.frame = CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            [self.refundButton setTitle:@"退款" forState:UIControlStateNormal];

            self.statusLabel.text = @"待收货";
            break;
        case 4:
            self.refundButton.hidden = YES;
            self.reminderButton.hidden = YES;
            self.goodsButton.hidden = YES;
            self.delectButton.hidden = NO;

            self.delectButton.frame = CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            self.statusLabel.text = @"交易成功";

            break;
        case 5:
            self.refundButton.hidden = YES;
            self.reminderButton.hidden = YES;
            self.goodsButton.hidden = YES;
            self.delectButton.hidden = NO;

            self.delectButton.frame = CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            self.statusLabel.text = @"订单已关闭";

            break;
        case 6:
            self.refundButton.hidden = NO;
            self.reminderButton.hidden = NO;
            self.goodsButton.hidden = YES;
            self.delectButton.hidden = YES;

            
            self.refundButton.frame = CGRectMake(KSCALE_WIDTH(190), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            self.reminderButton.frame = CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));

            [self.refundButton setTitle:@"同意退款" forState:UIControlStateNormal];
            [self.reminderButton setTitle:@"拒绝退款" forState:UIControlStateNormal];

            
            self.statusLabel.text = @"退款中";

            break;
        case 7:
            self.refundButton.hidden = YES;
            self.reminderButton.hidden = YES;
            self.goodsButton.hidden = YES;
            self.delectButton.hidden = YES;

            self.statusLabel.text = @"拒绝退款";

            break;
        case 8:
            self.refundButton.hidden = YES;
            self.reminderButton.hidden = YES;
            self.goodsButton.hidden = YES;
            self.delectButton.hidden = NO;
            self.delectButton.frame = CGRectMake(KSCALE_WIDTH(275), KSCALE_WIDTH(158), KSCALE_WIDTH(80), KSCALE_WIDTH(32));
            
            self.statusLabel.text = @"退款成功";

            break;
        default:
            break;
    }

}

@end
