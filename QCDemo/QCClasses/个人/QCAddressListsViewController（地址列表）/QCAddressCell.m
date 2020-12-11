//
//  QCAddressCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/4.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCAddressCell.h"

@implementation QCAddressCell

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
        
        self.areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(280), KSCALE_WIDTH(20))];
        self.areaLabel.font = K_16_FONT;
        self.areaLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.areaLabel];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(40), KSCALE_WIDTH(280), KSCALE_WIDTH(20))];
        self.addressLabel.font = K_16_BFONT;
        self.addressLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.addressLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(70), KSCALE_WIDTH(300), KSCALE_WIDTH(20))];
        self.nameLabel.font = K_14_FONT;
        self.nameLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.nameLabel];
        
        self.defaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(120), KSCALE_WIDTH(71), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
        self.defaultLabel.text = @"默认";
        self.defaultLabel.font = K_10_FONT;
        self.defaultLabel.layer.borderWidth = KSCALE_WIDTH(1);
        self.defaultLabel.textAlignment = NSTextAlignmentCenter;
        self.defaultLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.defaultLabel.textColor = [QCClassFunction stringTOColor:@"#ffba00"];
        [QCClassFunction filletImageView:self.defaultLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.defaultLabel];
        
        
        

        self.changeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(305), KSCALE_WIDTH(25), KSCALE_WIDTH(50), KSCALE_WIDTH(50))];
        self.changeButton.userInteractionEnabled = NO;
        [self.changeButton setImage:[UIImage imageNamed:@"editor"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.changeButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(99), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];

    }
    return self;
}

- (void)fillCellWithModel:(QCAddressModel *)model {
    self.areaLabel.text = [NSString stringWithFormat:@"%@%@%@",model.province_name,model.city_name,model.area_name];
    self.addressLabel.text = model.address;
    self.nameLabel.text = [NSString stringWithFormat:@"%@    %@",model.name,model.mobile];
    CGFloat labelW = [QCClassFunction getWidthWithString:self.nameLabel.text andFontSize:14 andConstrainedHeight:20];
    self.defaultLabel.frame = CGRectMake(KSCALE_WIDTH(20) + labelW, KSCALE_WIDTH(71), KSCALE_WIDTH(32), KSCALE_WIDTH(18));
    if ([model.is_default isEqualToString:@"1"]) {
        self.defaultLabel.hidden = NO;
    }else {
        self.defaultLabel.hidden = YES;

    }
}

@end
