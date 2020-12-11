//
//  QCHomeItem.m
//  QCDemo
//
//  Created by JQC on 2020/11/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHomeItem.h"

@implementation QCHomeItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = KCLEAR_COLOR;
        
        self.backView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.backView.backgroundColor = KBACK_COLOR;
        self.backView.layer.borderWidth = KSCALE_WIDTH(1);
        self.backView.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;

        [QCClassFunction filletImageView:self.backView withRadius:KSCALE_WIDTH(12)];
        [self.contentView addSubview:self.backView];
        
        self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(167.5), KSCALE_WIDTH(175))];
        [self.contentView addSubview:self.goodsImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(8), KSCALE_WIDTH(180), KSCALE_WIDTH(161), KSCALE_WIDTH(40))];
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(8), KSCALE_WIDTH(220), KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
        self.priceLabel.font = K_20_BFONT;
        self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3333"];
        [self.contentView addSubview:self.priceLabel];
        
        self.serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(75), KSCALE_WIDTH(220), KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
        self.serviceLabel.font = K_12_FONT;
        self.serviceLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.serviceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.serviceLabel];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(8), KSCALE_WIDTH(244), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
        self.addressLabel.font = K_12_FONT;
        self.addressLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.addressLabel];
        
        self.browseLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(95), KSCALE_WIDTH(244), KSCALE_WIDTH(60), KSCALE_WIDTH(20))];
        self.browseLabel.font = K_12_FONT;
        self.browseLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.browseLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.browseLabel];
        
    }
    return self;
}

- (void)fillItemWithModel:(QCGoodsModel *)model  {
    [QCClassFunction sd_imageView:self.goodsImageView ImageURL:model.first_img AppendingString:@"" placeholderImage:@"header"];
    self.contentLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    
    NSString * freeStr;

    if ([model.delivery_type isEqualToString:@"1"] ) {
        freeStr = @"自提";
    }else if ([model.delivery_type isEqualToString:@"2"] ) {
        freeStr = @"不包邮";
    }else{
        freeStr = @"包邮";
    }
    
    
    if (model.is_new) {
        self.serviceLabel.text = [NSString stringWithFormat:@"%@+全新",freeStr];

    }else{
        self.serviceLabel.text = freeStr;

    }
    self.addressLabel.text = model.ship_address;
    self.browseLabel.text = model.hot;
    

}
@end
