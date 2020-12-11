//
//  QCGoodsDetailsCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/3.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGoodsDetailsCell.h"
@implementation QCGoodsDetailsCell

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
        self.goodsImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.goodsImageView.image = [UIImage imageNamed:@"header"];
        [self.contentView addSubview:self.goodsImageView];
        
    }
    return self;
}
- (void)fillCellWithModel:(QCImageDetailsModel *)model {
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {


    }];
    
    self.goodsImageView.frame = CGRectMake(KSCALE_WIDTH(10), KSCALE_WIDTH(10), KSCALE_WIDTH(355), [model.cellH floatValue]);
    self.goodsImageView.contentMode = UIViewContentModeScaleAspectFit;

//    model.cellH = @"2000";
    
}

@end
