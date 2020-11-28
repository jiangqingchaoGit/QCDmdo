//
//  QCOtherTextCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOtherTextCell.h"



@interface QCOtherTextCell()
@property(nonatomic, assign) CGFloat labelH;
@property(nonatomic, assign) CGFloat labelW;


@end
@implementation QCOtherTextCell
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
        
        
        self.labelView = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(241), KSCALE_WIDTH(42))];
        self.labelView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [QCClassFunction filletImageView:self.labelView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.labelView];
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(77), KSCALE_WIDTH(10), KSCALE_WIDTH(221), KSCALE_WIDTH(42))];
        self.contentLabel.backgroundColor = KCLEAR_COLOR;
        self.contentLabel.font = K_15_FONT;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.contentLabel];
        
//        self.unreadLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(42))];
//        self.unreadLabel.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
//        self.unreadLabel.font = K_16_FONT;
//        self.unreadLabel.numberOfLines = 0;
//        self.unreadLabel.textColor = KTEXT_COLOR;
//        self.unreadLabel.text = @"未读";
//        [self.contentView addSubview:self.unreadLabel];
//
//        self.unreadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
//        self.unreadImageView.image = KHeaderImage;
//        [self.contentView addSubview:self.unreadImageView];
//
//
//        self.readLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(80), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(42))];
//        self.readLabel.backgroundColor = [QCClassFunction stringTOColor:@"#ffba00"];
//        self.readLabel.font = K_16_FONT;
//        self.readLabel.numberOfLines = 0;
//        self.readLabel.textColor = KTEXT_COLOR;
//        self.readLabel.text = @"已读";
//        [self.contentView addSubview:self.readLabel];
//
//        self.readImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
//        self.readImageView.image = KHeaderImage;
//        [self.contentView addSubview:self.readImageView];
        
    }
    return self;
}
- (void)fillCellWithModel:(QCChatModel *)model {
    //  动态计算高度
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.uhead AppendingString:nil placeholderImage:@"header"];
    NSDictionary * dic = [QCClassFunction dictionaryWithJsonString:model.message];
    self.contentLabel.attributedText = [QCClassFunction stringToAttributeString:dic[@"message"]];

    CGFloat labelH = [self.contentLabel.attributedText boundingRectWithSize:CGSizeMake(KSCALE_WIDTH(221), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    
    if (labelH <= 24) {
        
        
        CGFloat labelW = [self.contentLabel.attributedText boundingRectWithSize:CGSizeMake(MAXFLOAT, KSCALE_WIDTH(42)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.width;

        
        if (labelW > 221) {
            self.labelView.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(241), KSCALE_WIDTH(42));
            self.contentLabel.frame = CGRectMake(KSCALE_WIDTH(77), KSCALE_WIDTH(10), KSCALE_WIDTH(221), KSCALE_WIDTH(42));
        }else{
            self.labelView.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), labelW + KSCALE_WIDTH(20), KSCALE_WIDTH(42));
            self.contentLabel.frame = CGRectMake(KSCALE_WIDTH(77), KSCALE_WIDTH(10), labelW, KSCALE_WIDTH(42));
        }
        
        self.labelH = KSCALE_WIDTH(42);

    }else{
        self.labelView.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(241), labelH + KSCALE_WIDTH(25));
        self.contentLabel.frame = CGRectMake(KSCALE_WIDTH(77), KSCALE_WIDTH(10), KSCALE_WIDTH(221), labelH + KSCALE_WIDTH(25));
        self.labelH = labelH + KSCALE_WIDTH(25);
    }
    

    model.cellH = [NSString stringWithFormat:@"%f",self.labelH + KSCALE_WIDTH(20)];
}

- (CGFloat)GETLabelH {
    return self.labelH;
}


@end
