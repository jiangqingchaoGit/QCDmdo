//
//  QCSelfPictureCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSelfPictureCell.h"
#import <UIImage+GIF.h>

@implementation QCSelfPictureCell

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
        
        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(218), KSCALE_WIDTH(10), KSCALE_WIDTH(90), KSCALE_WIDTH(120))];
        self.pictureImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.pictureImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.pictureImageView];
        
        self.pictureButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 50, 30, 30)];
        self.pictureButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.pictureButton];
        
        self.canButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        self.canButton.backgroundColor = [UIColor redColor];
        [QCClassFunction filletImageView:self.canButton withRadius:KSCALE_WIDTH(16)];
        [self.contentView addSubview:self.canButton];
    
        self.loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCALE_WIDTH(32), KSCALE_WIDTH(32))];
        [self.contentView addSubview:self.loadingImageView];
        
        
    }
    return self;
}

- (void)fillCellWithModel:(QCChatModel *)model {
    NSArray * arr = [model.message componentsSeparatedByString:@"|"];
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:K_HEADIMAGE AppendingString:nil placeholderImage:@"header"];
    self.pictureImageView.image =  [QCClassFunction Base64StrToUIImage:arr[0]];

    
    if ([arr[1] floatValue] > [arr[2] floatValue]) {
        
        self.pictureImageView.frame = CGRectMake(KSCALE_WIDTH(218), KSCALE_WIDTH(10), KSCALE_WIDTH(90), [model.cellH floatValue] - KSCALE_WIDTH(20));
        self.canButton.frame = CGRectMake(KSCALE_WIDTH(181), [model.cellH floatValue] / 2.0 - KSCALE_WIDTH(16), KSCALE_WIDTH(32), KSCALE_WIDTH(32));
        self.loadingImageView.frame = CGRectMake(KSCALE_WIDTH(181), [model.cellH floatValue] / 2.0 - KSCALE_WIDTH(16), KSCALE_WIDTH(32), KSCALE_WIDTH(32));

    } else if ([arr[1] floatValue] == [arr[2] floatValue]){

        self.pictureImageView.frame = CGRectMake(KSCALE_WIDTH(188), KSCALE_WIDTH(10), KSCALE_WIDTH(120), [model.cellH floatValue] - KSCALE_WIDTH(20));
        
        self.canButton.frame = CGRectMake(KSCALE_WIDTH(151), [model.cellH floatValue] / 2.0 - KSCALE_WIDTH(16), KSCALE_WIDTH(32), KSCALE_WIDTH(32));
        self.loadingImageView.frame = CGRectMake(KSCALE_WIDTH(151), [model.cellH floatValue] / 2.0 - KSCALE_WIDTH(16), KSCALE_WIDTH(32), KSCALE_WIDTH(32));

    }else{
        self.pictureImageView.frame = CGRectMake(KSCALE_WIDTH(158), KSCALE_WIDTH(10), KSCALE_WIDTH(150), [model.cellH floatValue] - KSCALE_WIDTH(20));
        
        self.canButton.frame = CGRectMake(KSCALE_WIDTH(121), [model.cellH floatValue] / 2.0 - KSCALE_WIDTH(16), KSCALE_WIDTH(32), KSCALE_WIDTH(32));
        self.loadingImageView.frame = CGRectMake(KSCALE_WIDTH(121), [model.cellH floatValue] / 2.0 - KSCALE_WIDTH(16), KSCALE_WIDTH(32), KSCALE_WIDTH(32));

    }
    
    self.pictureButton.frame = self.pictureImageView.frame;
    
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
}
@end
