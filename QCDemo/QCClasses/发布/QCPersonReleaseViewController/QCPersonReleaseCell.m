//
//  QCPersonReleaseCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/31.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCPersonReleaseCell.h"

@implementation QCPersonReleaseCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(20), KSCALE_WIDTH(90), KSCALE_WIDTH(90))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.headerImageView];

        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(20), KSCALE_WIDTH(225), KSCALE_WIDTH(55))];
        self.contentLabel.text = @"[9.5新] 华为HUAWEI P30，自用带票，仅3个月，新机入手，含泪低价出售";
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(80), KSCALE_WIDTH(60), KSCALE_WIDTH(30))];
        self.priceLabel.text = @"¥3700";
        self.priceLabel.font = K_16_BFONT;
        self.priceLabel.textColor = [QCClassFunction stringTOColor:@"#FF3300"];
        [self.contentView addSubview:self.priceLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(80), KSCALE_WIDTH(80), KSCALE_WIDTH(30))];
        self.numLabel.text = @"库存：120";
        self.numLabel.font = K_12_FONT;
        self.numLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.contentView addSubview:self.numLabel];
        

        
        
        self.freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(280), KSCALE_WIDTH(86), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
        self.freeLabel.text = @"包邮";
        self.freeLabel.font = K_10_FONT;
        self.freeLabel.layer.borderWidth = KSCALE_WIDTH(1);
        self.freeLabel.textAlignment = NSTextAlignmentCenter;
        self.freeLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.freeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [QCClassFunction filletImageView:self.freeLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.freeLabel];

        self.unoldLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(320), KSCALE_WIDTH(86), KSCALE_WIDTH(32), KSCALE_WIDTH(18))];
        self.unoldLabel.text = @"全新";
        self.unoldLabel.font = K_10_FONT;
        self.unoldLabel.layer.borderWidth = KSCALE_WIDTH(1);
        self.unoldLabel.textAlignment = NSTextAlignmentCenter;
        self.unoldLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.unoldLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [QCClassFunction filletImageView:self.unoldLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.unoldLabel];
        
        
        
        self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(291), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32))];
        self.upButton.backgroundColor = KCLEAR_COLOR;
        self.upButton.titleLabel.font = K_14_FONT;
        self.upButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.upButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.upButton.hidden = YES;
        [QCClassFunction filletImageView:self.upButton withRadius:KSCALE_WIDTH(8)];
        [self.upButton setTitle:@"上架" forState:UIControlStateNormal];
        [self.upButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
    
        [self.contentView addSubview:self.upButton];
        
        self.downButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(143), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32))];
        self.downButton.backgroundColor = KCLEAR_COLOR;
        self.downButton.titleLabel.font = K_14_FONT;
        self.downButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.downButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.downButton.hidden = YES;

        [QCClassFunction filletImageView:self.downButton withRadius:KSCALE_WIDTH(8)];
        [self.downButton setTitle:@"下架" forState:UIControlStateNormal];
        [self.downButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.downButton];
        
        self.editorButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(217), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32))];
        self.editorButton.backgroundColor = KCLEAR_COLOR;
        self.editorButton.titleLabel.font = K_14_FONT;
        self.editorButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.editorButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.editorButton.hidden = YES;

        [QCClassFunction filletImageView:self.editorButton withRadius:KSCALE_WIDTH(8)];
        [self.editorButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editorButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.editorButton];
        
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(291), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32))];
        self.deleteButton.backgroundColor = KCLEAR_COLOR;
        self.deleteButton.titleLabel.font = K_14_FONT;
        self.deleteButton.layer.borderWidth = KSCALE_WIDTH(1);
        self.deleteButton.layer.borderColor = [QCClassFunction stringTOColor:@"#F2F2F2"].CGColor;
        self.deleteButton.hidden = YES;

        [QCClassFunction filletImageView:self.deleteButton withRadius:KSCALE_WIDTH(8)];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[QCClassFunction stringTOColor:@"#0000000"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(159), KSCALE_WIDTH(225), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}
- (void)fillCellWithModel:(QCGoodsDetailsModel *)model {
    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.first_img AppendingString:@"" placeholderImage:@"header"];
    self.contentLabel.text = model.content;
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
- (void)fillSizeWithStatus:(NSString *)status {
    
    if ([status isEqualToString:@"1"]) {
        //  下架 编辑
        self.upButton.hidden = YES;
        self.downButton.hidden = NO;
        self.editorButton.hidden = NO;
        self.deleteButton.hidden = YES;
        self.downButton.frame = CGRectMake(KSCALE_WIDTH(217), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32));
        self.editorButton.frame = CGRectMake(KSCALE_WIDTH(291), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32));


        
    }else{
        //  上架 编辑 删除
        self.upButton.hidden = NO;
        self.downButton.hidden = YES;
        self.editorButton.hidden = NO;
        self.deleteButton.hidden = NO;
        
        self.upButton.frame = CGRectMake(KSCALE_WIDTH(143), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32));
        self.editorButton.frame = CGRectMake(KSCALE_WIDTH(217), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32));
        self.deleteButton.frame = CGRectMake(KSCALE_WIDTH(291), KSCALE_WIDTH(118), KSCALE_WIDTH(64), KSCALE_WIDTH(32));
    }
}

@end
