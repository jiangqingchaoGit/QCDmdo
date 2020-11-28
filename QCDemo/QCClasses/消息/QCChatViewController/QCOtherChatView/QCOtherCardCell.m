//
//  QCOtherCardCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOtherCardCell.h"

@implementation QCOtherCardCell

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
        self.backImageView.image = [UIImage imageNamed:@"book_l"];
        [self.contentView addSubview:_backImageView];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(21), KSCALE_WIDTH(160), KSCALE_WIDTH(20))];


        self.contentLabel.font = K_16_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.contentLabel];

        self.getLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(130), KSCALE_WIDTH(46), KSCALE_WIDTH(239), KSCALE_WIDTH(15))];
        self.getLabel.font = K_12_FONT;
        self.getLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.getLabel];

        
        self.fHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(20), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.fHeaderImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.fHeaderImageView withRadius:KSCALE_WIDTH(21)];
        [self.contentView addSubview:self.fHeaderImageView];
        
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(71), KSCALE_WIDTH(239), KSCALE_WIDTH(28.5))];
        self.typeLabel.text = @"个人名片";
        self.typeLabel.font = K_11_FONT;
        self.typeLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.typeLabel];

        self.envelopeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(239), KSCALE_WIDTH(88.5))];
        self.envelopeButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.envelopeButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(70.5), KSCALE_WIDTH(200), KSCALE_WIDTH(0.5))];
        lineView.backgroundColor = KWHITE_COLOR;
        lineView.alpha = 0.5;
        [self.contentView addSubview:lineView];
        
        
    }
    return self;
}
- (void)fillCellWithModel:(QCChatModel *)model {
    
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];

    
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.uhead AppendingString:nil placeholderImage:@"header"];
    [QCClassFunction sd_imageView:self.fHeaderImageView ImageURL:arr[0] AppendingString:nil placeholderImage:@"header"];
    self.contentLabel.text = arr[1];
    self.getLabel.text = arr[2];
    
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
