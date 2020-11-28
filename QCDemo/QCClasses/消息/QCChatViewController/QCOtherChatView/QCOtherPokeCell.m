//
//  QCOtherPokeCell.m
//  QCDemo
//
//  Created by JQC on 2020/11/24.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCOtherPokeCell.h"

@implementation QCOtherPokeCell

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
        
        self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(83), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.pictureImageView.image = [UIImage imageNamed:@"cuo_s"];
        [QCClassFunction filletImageView:self.pictureImageView withRadius:KSCALE_WIDTH(5)];
        [self.contentView addSubview:self.pictureImageView];
        
        
        self.cuoButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(83), KSCALE_WIDTH(10), KSCALE_WIDTH(42), KSCALE_WIDTH(42))];
        self.cuoButton.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.cuoButton];
        
    }
    return self;
}


- (void)fillCellWithModel:(QCChatModel *)model {
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.uhead AppendingString:nil placeholderImage:@"header"];
    

}

@end
