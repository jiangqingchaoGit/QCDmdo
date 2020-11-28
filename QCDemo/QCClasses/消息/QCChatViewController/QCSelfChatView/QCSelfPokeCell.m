//
//  QCSelfPokeCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/24.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCSelfPokeCell.h"
#import <UIImage+GIF.h>

@implementation QCSelfPokeCell

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
        
        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(260), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.pictureImageView.image = [UIImage imageNamed:@"cuo"];
        [QCClassFunction filletImageView:self.pictureImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.pictureImageView];
        
        self.cuoButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(260), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        [self.cuoButton setImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateNormal];
        self.cuoButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.cuoButton];
        
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
