//
//  QCEnvelopeCell.m
//  QCDream
//
//  Created by JQC on 2019/2/22.
//  Copyright © 2019 JQC. All rights reserved.
//

#import "QCEnvelopeCell.h"

@implementation QCEnvelopeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        [self.contentView addSubview:_headerImageView];
        
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, KSCREEN_WIDTH - 100, 20)];
        _nickName.font = K_14_BFONT;
        _nickName.textColor = KTEXT_COLOR;
        _nickName.text = @"思绪云骞";
        [self.contentView addSubview:_nickName];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(70, 60, KSCREEN_WIDTH - 70, 1)];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, KSCREEN_WIDTH - 100, 20)];
        _timeLabel.font = K_12_FONT;
        _timeLabel.textColor = [QCClassFunction stringTOColor:@"#ffb333"];
        _timeLabel.text = @"10:10";

        [self.contentView addSubview:_timeLabel];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 100, 10, 85, 20)];
        _moneyLabel.font = K_14_BFONT;
        _moneyLabel.textColor = KTEXT_COLOR;
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.text = @"1.22元";
        [self.contentView addSubview:_moneyLabel];
        
        
        _luckButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 95, 35, 85, 20)];
        _luckButton.backgroundColor = [UIColor clearColor];
        [_luckButton setTitle:@"  手气最佳" forState:UIControlStateNormal];
        [_luckButton setImage:[UIImage imageNamed:@"皇冠"] forState:UIControlStateNormal];
        [_luckButton setTitleColor:[QCClassFunction stringTOColor:@"#ffb333"] forState:UIControlStateNormal];
        _luckButton.titleLabel.font = K_14_BFONT;
        _luckButton.hidden = YES;
        [self.contentView addSubview:_luckButton];
        
        _rapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 130, 18, 34, 24)];
        _rapImageView.image = [UIImage imageNamed:@"boom"];
        _rapImageView.hidden = YES;
        [self.contentView addSubview:_rapImageView];
        
        
    }
    return self;
}

- (void)fillCellWithModel:(QCEnveolpListModel *)model {

    
    _nickName.text = [QCClassFunction URLDecodedString:model.n];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.u] placeholderImage:[UIImage imageNamed:@"personImage"]];
    _timeLabel.text = [model.ct componentsSeparatedByString:@" "][1];
    _moneyLabel.text = [NSString stringWithFormat:@"%@分",model.m];
    if ([model.t isEqualToString:@"0"]) {
        _luckButton.hidden = YES;
        _rapImageView.hidden = YES;
        
        
    }
    if ([model.t isEqualToString:@"1"]) {
        _luckButton.hidden = YES;
        _rapImageView.hidden = NO;
    }
    if ([model.t isEqualToString:@"2"]) {
        _luckButton.hidden = NO;
        _rapImageView.hidden = YES;
    }
    if ([model.t isEqualToString:@"3"]) {
        _luckButton.hidden = NO;
        _rapImageView.hidden = NO;
    }


}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
