//
//  QCOtherVoiceCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOtherVoiceCell.h"

@implementation QCOtherVoiceCell

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

        self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(241), KSCALE_WIDTH(42))];
        self.voiceButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        [QCClassFunction filletImageView:self.voiceButton withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.voiceButton];
        
        self.voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.voiceImageView.image = [UIImage imageNamed:@"voice_r"];
        self.voiceImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.voiceImageView];
        
        self.voiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(110), KSCALE_WIDTH(10), KSCALE_WIDTH(66), KSCALE_WIDTH(42))];
        self.voiceLabel.font = K_14_FONT;
        self.voiceLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.voiceLabel];
        
    }
    return self;
}


- (void)fillCellWithModel:(QCChatModel *)model {
    
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];

    float longV  = [self audioDurationFromURL:[arr firstObject]];
    self.voiceLabel.text = [NSString stringWithFormat:@"%.0f''",longV];

    if (longV > 30) {
        self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(174) * (longV + 20) / (longV + 30) , KSCALE_WIDTH(42));


    }else{
        self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(174) * (longV + 20) / 50 , KSCALE_WIDTH(42));

    }
    
}

- (NSTimeInterval)audioDurationFromURL:(NSString *)url {
    AVURLAsset *audioAsset = nil;
    NSDictionary *dic = @{AVURLAssetPreferPreciseDurationAndTimingKey:@(YES)};
    if ([url hasPrefix:@"http://"]) {
        audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:dic];
    }else {
        audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:url] options:dic];
    }
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
}

@end
