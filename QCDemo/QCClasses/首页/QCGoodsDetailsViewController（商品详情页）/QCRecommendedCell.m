//
//  QCRecommendedCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/7.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCRecommendedCell.h"
#import "QCGoodsDetailsModel.h"
@implementation QCRecommendedCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(90))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.headerImageView];

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(15), KSCALE_WIDTH(225), KSCALE_WIDTH(55))];
        self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(75), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
        self.priceLabel.text = @"¥3700";
        self.priceLabel.font = K_16_BFONT;
        self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
        [self.contentView addSubview:self.priceLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(75), KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
        self.numLabel.text = @"库存：120";
        self.numLabel.font = K_12_FONT;
        self.numLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.contentView addSubview:self.numLabel];
        

        
        
        self.freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(81), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
        self.freeLabel.text = @"包邮";
        self.freeLabel.font = K_10_FONT;
        self.freeLabel.layer.borderWidth = KSCALE_WIDTH(1);
        self.freeLabel.textAlignment = NSTextAlignmentCenter;
        self.freeLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.freeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [QCClassFunction filletImageView:self.freeLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.freeLabel];

        self.unoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(320), KSCALE_WIDTH(81), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
        self.unoldLabel.text = @"全新";
        self.unoldLabel.font = K_10_FONT;
        self.unoldLabel.layer.borderWidth = KSCALE_WIDTH(1);
        self.unoldLabel.textAlignment = NSTextAlignmentCenter;
        self.unoldLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.unoldLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [QCClassFunction filletImageView:self.unoldLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.unoldLabel];

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(119), KSCALE_WIDTH(225), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}
- (void)fillCellWithModel:(QCGoodsModel *)model {
    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.first_img AppendingString:@"" placeholderImage:@"header"];
    self.contentLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    self.numLabel.text = @"库存：120";
    if ([model.is_new isEqualToString:@"1"]) {
        self.unoldLabel.text = @"全新";
    }else{
        self.unoldLabel.text = @"二手";
    }
    if ([model.delivery_type isEqualToString:@"1"]) {
        self.freeLabel.text = @"自提";
        self.freeLabel.hidden = NO;

    }else if ([model.delivery_type isEqualToString:@"2"]) {
        self.freeLabel.text = @"包邮";
        self.freeLabel.hidden = NO;

    }else{
        self.freeLabel.hidden = YES;
    }
    

}


@end
