//
//  QCOtherVedioCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/16.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOtherVedioCell.h"

@implementation QCOtherVedioCell

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
        
        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(90), KSCALE_WIDTH(120))];
        self.pictureImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.pictureImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.pictureImageView];
        
        self.vedioButton = [[UIButton alloc] initWithFrame:CGRectMake(97, 50, 30, 30)];
        [self.vedioButton setImage:KHeaderImage forState:UIControlStateNormal];
        [self.contentView addSubview:self.vedioButton];
        
        
    }
    return self;
}

- (void)fillCellWithModel:(QCChatModel *)model {
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.uhead AppendingString:nil placeholderImage:@"header"];
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];
    self.pictureImageView.image = [self getVideoFirstViewImage:[NSURL URLWithString:arr[0]]];
    
    if ([arr[1] floatValue] > [arr[2] floatValue]) {
        
        self.pictureImageView.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(90), [model.cellH floatValue] - KSCALE_WIDTH(20));

    } else if ([arr[1] floatValue] == [arr[2] floatValue]){

        self.pictureImageView.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(120), [model.cellH floatValue] - KSCALE_WIDTH(20));

    }else{
        self.pictureImageView.frame = CGRectMake(KSCALE_WIDTH(67), KSCALE_WIDTH(10), KSCALE_WIDTH(150), [model.cellH floatValue] - KSCALE_WIDTH(20));

    }
    

    
    
}

- (UIImage*)getVideoFirstViewImage:(NSURL *)path {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
    
}

@end
