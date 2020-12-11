//
//  QCMessageCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCMessageCell.h"

@implementation QCMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
        [self.contentView addSubview:self.headerImageView];
        
        self.headerButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
        self.headerButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.headerButton];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(57), KSCALE_WIDTH(10), KSCALE_WIDTH(20), KSCALE_WIDTH(20))];
        self.numberLabel.font = K_10_FONT;
        self.numberLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FF5E5E"];
        self.numberLabel.textColor = KBACK_COLOR;
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        [QCClassFunction filletImageView:self.numberLabel withRadius:KSCALE_WIDTH(10)];
        [self.contentView addSubview:self.numberLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(15), KSCALE_WIDTH(90), KSCALE_WIDTH(21))];
        self.nameLabel.font = K_16_FONT;
        self.nameLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.nameLabel];
        
//        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(160), KSCALE_WIDTH(17.5), KSCALE_WIDTH(25), KSCALE_WIDTH(16))];
//        self.tipLabel.text = @"官方";
//        self.tipLabel.font = K_8_FONT;
//        self.tipLabel.textColor = [QCClassFunction stringTOColor:@"#282828"];
//        self.tipLabel.textAlignment = NSTextAlignmentCenter;
//        self.tipLabel.layer.borderWidth = KSCALE_WIDTH(1);
//        self.tipLabel.layer.borderColor = [QCClassFunction stringTOColor:@"#282828"].CGColor;

        [QCClassFunction filletImageView:self.tipLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.tipLabel];
        
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(36), KSCALE_WIDTH(290), KSCALE_WIDTH(26))];
//        self.contentLabel.text = @"请问你的水果什么时候发货？";
        self.contentLabel.font = K_12_FONT;
        self.contentLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(300), KSCALE_WIDTH(15), KSCALE_WIDTH(60), KSCALE_WIDTH(21))];
        self.timeLabel.font = K_10_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#BCBCBC"];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];

        
    }
    return self;
}

- (void)fillCellWithModel:(QCListModel *)model {
    
    
    if ([model.count isEqualToString:@"0"]) {
        self.numberLabel.hidden = YES;
    }else{
        self.numberLabel.hidden = NO;
    }
    
    self.numberLabel.text = model.count;
    if ([model.count intValue] > 99) {
        self.numberLabel.text = @"99";
    }else{
    }
    
    self.timeLabel.text = [QCClassFunction getDateDisplayString:[model.time integerValue]];
    
    if ([model.cType isEqualToString:@"0"]) {
        [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.uhead AppendingString:nil placeholderImage:K_HEADIMAGE];
        self.nameLabel.text = model.unick;

    }else {
        [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.ghead AppendingString:nil placeholderImage:K_HEADIMAGE];
        self.nameLabel.text = model.gname;

    }
    
    
    
    switch ([model.mtype integerValue]) {
        case 0:
            
        {
            NSDictionary * dic = [QCClassFunction dictionaryWithJsonString:model.message];
            self.contentLabel.text = dic[@"message"];
        }


            break;
        case 1:
            self.contentLabel.text = @"[图片]";

            break;
        case 2:
            self.contentLabel.text = @"[语音]";

            break;
        case 3:
            self.contentLabel.text = @"[红包]";

            break;
        case 4:
            self.contentLabel.text = @"[视频]";

            break;
        case 5:
            self.contentLabel.text = @"[转账]";

            break;
        case 6:
            self.contentLabel.text = @"[名片]";
            break;
            
        case 7:
            self.contentLabel.text = @"[戳一戳]";


            break;
        case 8:
            self.contentLabel.text = @"[语音]";

            break;
        case 9:
            self.contentLabel.text = @"[红包]";

            break;
        case 10:

            break;
        case 11:
            self.contentLabel.text = @"[全员禁言]";

            
            break;
        case 12:
            self.contentLabel.text = @"[名片]";
            break;
            
            

        case 13:
            self.contentLabel.text = @"[红包]";
            break;

        case 14:
            self.contentLabel.text = @"[转账]";
            
            break;
        case 15:
            self.contentLabel.text = @"[转账]";
            break;
            
        case 16:
            self.contentLabel.text = @"[转账]";
            break;

        case 17:
            self.contentLabel.text = @"[转账]";
            break;
        case 18:
            self.contentLabel.text = @"[红包]";
            break;
            

        case 20:
            self.contentLabel.text = model.message;

            break;
            
        default:
            break;
    }

}

@end
