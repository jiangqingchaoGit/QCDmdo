//
//  QCOtherEnvelopeCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOtherEnvelopeCell.h"

@implementation QCOtherEnvelopeCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(21)];
        [self.contentView addSubview:self.headerImageView];
        
        self.imageViewButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.imageViewButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.imageViewButton];

        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(239), KSCALE_WIDTH(88.5))];
        self.backImageView.image = [UIImage imageNamed:@"hot_l"];
        [self.contentView addSubview:_backImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(21), KSCALE_WIDTH(160), KSCALE_WIDTH(20))];
        self.contentLabel.text = @"积分-类型";
        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = KWHITE_COLOR;
        [self.contentView addSubview:self.contentLabel];

        self.getLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(46), KSCALE_WIDTH(239), KSCALE_WIDTH(15))];
        self.getLabel.font = K_12_FONT;
        self.getLabel.textColor = KWHITE_COLOR;
        [self.contentView addSubview:self.getLabel];

        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(71), KSCALE_WIDTH(239), KSCALE_WIDTH(28.5))];
        self.typeLabel.text = @"小闲闲红包";
        self.typeLabel.font = K_11_FONT;
        self.typeLabel.textColor = KWHITE_COLOR;
        [self.contentView addSubview:self.typeLabel];

        self.envelopeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(239), KSCALE_WIDTH(88.5))];
        self.envelopeButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.envelopeButton];
        
        
        self.fHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(20), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.fHeaderImageView.image = [UIImage imageNamed:@"hot_image"];
        self.fHeaderImageView.contentMode = UIViewContentModeCenter;

        [self.contentView addSubview:self.fHeaderImageView];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(188), KSCALE_WIDTH(71), KSCALE_WIDTH(100), KSCALE_WIDTH(28.5))];
        self.moneyLabel.text = @"¥2.00";
        self.moneyLabel.font = K_11_FONT;
        self.moneyLabel.textColor = KWHITE_COLOR;
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.moneyLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(70.5), KSCALE_WIDTH(200), KSCALE_WIDTH(0.5))];
        lineView.backgroundColor = KWHITE_COLOR;
        lineView.alpha = 0.5;
        [self.contentView addSubview:lineView];
        
    }
    return self;
}
- (void)fillCellWithModel:(QCChatModel *)model {
    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:K_HEADIMAGE AppendingString:nil placeholderImage:@"header"];
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];
    
    self.contentLabel.text = arr[2];
    if ([arr[0] isEqualToString:@"0"]) {
        self.backImageView.alpha = 1;
        self.fHeaderImageView.alpha = 1;

        self.getLabel.text = @"领取红包";

    }else{
        self.backImageView.alpha = 0.5;
        self.fHeaderImageView.alpha = 0.5;

        self.getLabel.text = @"已领取";


    }
    
    self.loadingImageView.hidden = YES;
    if ([model.canSend isEqualToString:@"0"]) {
        
        self.canButton.hidden = NO;
    }else{
        self.canButton.hidden = YES;

        if ([model.isSend isEqualToString:@"0"]) {
            self.loadingImageView.hidden = NO;
        }else {
            self.loadingImageView.hidden = YES;

        }
    }
    



}
@end
