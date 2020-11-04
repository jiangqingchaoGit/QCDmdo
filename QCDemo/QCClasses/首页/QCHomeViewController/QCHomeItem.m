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
        self.goodsImageView.image = KHeaderImage;
        [self.contentView addSubview:self.goodsImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(8), KSCALE_WIDTH(180), KSCALE_WIDTH(161), KSCALE_WIDTH(40))];
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.text = @"泰国进口山竹精选大果5斤装";
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(8), KSCALE_WIDTH(220), KSCALE_WIDTH(80), KSCALE_WIDTH(24))];
        self.priceLabel.font = K_20_BFONT;
        self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3333"];
        self.priceLabel.text = @"￥88.0";
        [self.contentView addSubview:self.priceLabel];
        
        self.serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(95), KSCALE_WIDTH(220), KSCALE_WIDTH(60), KSCALE_WIDTH(24))];
        self.serviceLabel.font = K_12_FONT;
        self.serviceLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.serviceLabel.text = @"包邮+全新";
        self.serviceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.serviceLabel];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(8), KSCALE_WIDTH(244), KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
        self.addressLabel.font = K_12_FONT;
        self.addressLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.addressLabel.text = @"重庆市渝北区";
        [self.contentView addSubview:self.addressLabel];
        
        self.browseLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(95), KSCALE_WIDTH(244), KSCALE_WIDTH(60), KSCALE_WIDTH(20))];
        self.browseLabel.font = K_12_FONT;
        self.browseLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.browseLabel.text = @"655";
        self.browseLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.browseLabel];
        
    }
    return self;
}
@end
