//
//  QCSelfVoiceCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSelfVoiceCell.h"
#import <UIImage+GIF.h>

@implementation QCSelfVoiceCell

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
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(318), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(21)];
        [self.contentView addSubview:self.headerImageView];
        
        self.imageViewButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(318), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.imageViewButton.backgroundColor = KCLEAR_COLOR;
        [self.contentView addSubview:self.imageViewButton];

        self.voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(241), KSCALE_WIDTH(42))];

        self.voiceButton.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        [QCClassFunction filletImageView:self.voiceButton withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.voiceButton];
        
        self.canButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        self.canButton.backgroundColor = [UIColor redColor];
        [QCClassFunction filletImageView:self.canButton withRadius:KSCALE_WIDTH(16)];
        [self.contentView addSubview:self.canButton];
    
        self.loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        [self.contentView addSubview:self.loadingImageView];
        
        
        self.voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(266), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.voiceImageView.image = [UIImage imageNamed:@"voice_l"];
        self.voiceImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.voiceImageView];
        
        self.voiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(200), KSCALE_WIDTH(10), KSCALE_WIDTH(66), KSCALE_WIDTH(42))];
        self.voiceLabel.font = K_14_FONT;
        self.voiceLabel.textColor = KTEXT_COLOR;
        self.voiceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.voiceLabel];
        
    }
    return self;
}

- (void)fillCellWithModel:(QCChatModel *)model {
    
    
    self.canButton.frame = CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(15), KSCALE_WIDTH(32), KSCALE_WIDTH(32));
    self.loadingImageView.frame = CGRectMake(KSCALE_WIDTH(30), KSCALE_WIDTH(15), KSCALE_WIDTH(32), KSCALE_WIDTH(32));
    
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
    
    NSString *filepath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"加载修改.gif" ofType:nil];
    NSData *imagedata = [NSData dataWithContentsOfFile:filepath];
    UIImage * image = [UIImage sd_imageWithGIFData:imagedata];
    self.loadingImageView.image = image;

    
    float longV  = [self audioDurationFromURL:model.message];
    self.voiceLabel.text = [NSString stringWithFormat:@"%.0f''",longV];

    if (longV > 30) {
        self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(308) - KSCALE_WIDTH(174) * (longV + 20) / (longV + 30), KSCALE_WIDTH(10), KSCALE_WIDTH(174) * (longV + 20) / (longV + 30) , KSCALE_WIDTH(42));


    }else{
        self.voiceButton.frame = CGRectMake(KSCALE_WIDTH(308) - KSCALE_WIDTH(174) * (longV + 20) / 50, KSCALE_WIDTH(10), KSCALE_WIDTH(174) * (longV + 20) / 50 , KSCALE_WIDTH(42));

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
