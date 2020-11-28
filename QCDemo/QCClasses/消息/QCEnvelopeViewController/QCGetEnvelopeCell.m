//
//  QCGetEnvelopeCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/26.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGetEnvelopeCell.h"

@implementation QCGetEnvelopeCell

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
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(15), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        [QCClassFunction  filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(21)];
        [self.contentView addSubview:_headerImageView];
        
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(70), KSCALE_WIDTH(10), KSCREEN_WIDTH - KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
        _nickName.font = K_14_BFONT;
        _nickName.textColor = KTEXT_COLOR;
        _nickName.text = @"思绪云骞";
        [self.contentView addSubview:_nickName];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(70), KSCALE_WIDTH(60), KSCREEN_WIDTH - KSCALE_WIDTH(70), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(70), KSCALE_WIDTH(35), KSCREEN_WIDTH - KSCALE_WIDTH(100), KSCALE_WIDTH(20))];
        _timeLabel.font = K_12_FONT;
        _timeLabel.textColor = [QCClassFunction stringTOColor:@"#ffb333"];
        _timeLabel.text = @"10:10";

        [self.contentView addSubview:_timeLabel];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - KSCALE_WIDTH(100), KSCALE_WIDTH(10), KSCALE_WIDTH(85), KSCALE_WIDTH(20))];
        _moneyLabel.font = K_14_BFONT;
        _moneyLabel.textColor = KTEXT_COLOR;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.text = @"1.22元";
        [self.contentView addSubview:_moneyLabel];
        
        
        _luckButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - KSCALE_WIDTH(95), KSCALE_WIDTH(35), KSCALE_WIDTH(85), KSCALE_WIDTH(20))];
        _luckButton.backgroundColor = [UIColor clearColor];
        [_luckButton setTitle:@"  手气最佳" forState:UIControlStateNormal];
        [_luckButton setImage:[UIImage imageNamed:@"皇冠"] forState:UIControlStateNormal];
        [_luckButton setTitleColor:[QCClassFunction stringTOColor:@"#ffb333"] forState:UIControlStateNormal];
        _luckButton.titleLabel.font = K_14_BFONT;
        _luckButton.hidden = YES;
        [self.contentView addSubview:_luckButton];

        
        
    }
    return self;
}

- (void)fillCellWithModel:(QCGetEnvelopeModel *)model {

    
    self.nickName.text = [QCClassFunction URLDecodedString:model.nick];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"personImage"]];
    self.timeLabel.text = [QCClassFunction ConvertStrToTime:model.addtime withType:@"HH:ss"];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.price];
//    if ([model.is_max isEqualToString:@"0"]) {
//        _luckButton.hidden = YES;
//        _rapImageView.hidden = YES;
//
//
//    }
//    if ([model.t isEqualToString:@"1"]) {
//        _luckButton.hidden = YES;
//        _rapImageView.hidden = NO;
//    }
//    if ([model.t isEqualToString:@"2"]) {
//        _luckButton.hidden = NO;
//        _rapImageView.hidden = YES;
//    }
//    if ([model.t isEqualToString:@"3"]) {
//        _luckButton.hidden = NO;
//        _rapImageView.hidden = NO;
//    }
    self.luckButton.hidden = YES;
    self.rapImageView.hidden = YES;


}

@end
