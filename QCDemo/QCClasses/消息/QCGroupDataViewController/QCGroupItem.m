//
//  QCGroupItem.m
//  QCDemo
//
//  Created by JQC on 2020/10/22.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCGroupItem.h"

@implementation QCGroupItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(60), KSCALE_WIDTH(60))];
        self.headerImageView.image = KHeaderImage;
        [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(30)];
        [self.contentView addSubview:self.headerImageView];
        
        self.identityLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(40), KSCALE_WIDTH(18))];
        self.identityLabel.font = K_12_FONT;
        self.identityLabel.textColor = KBACK_COLOR;
        self.identityLabel.backgroundColor = [QCClassFunction stringTOColor:@"#FFCC00"];
        self.identityLabel.textAlignment = NSTextAlignmentCenter;
        [QCClassFunction filletImageView:self.identityLabel withRadius:KSCALE_WIDTH(4)];
        [self.contentView addSubview:self.identityLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(64), KSCALE_WIDTH(60), KSCALE_WIDTH(20))];
        self.nameLabel.font = K_12_FONT;
        self.nameLabel.textColor = [QCClassFunction stringTOColor:@"#6B6B6B"];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLabel];
        



    }
    return self;
}

- (void)fillCellWithModel:(QCGroupDataModel *)model {
    self.identityLabel.text = @"";
    self.identityLabel.hidden = YES;
    if ([model.user_type isEqualToString:@"3"]) {
        self.identityLabel.text = @"群主";
        self.identityLabel.hidden = NO;

    }
    if ([model.user_type isEqualToString:@"2"]) {
        self.identityLabel.text = @"管理员";
        self.identityLabel.hidden = NO;

    }
    if ([model.user_type isEqualToString:@"1"]) {
        self.identityLabel.text = @"";
        self.identityLabel.hidden = YES;
    }
    self.nameLabel.text = model.nick_name;
    [QCClassFunction sd_imageView:self.headerImageView ImageURL:model.head AppendingString:@"" placeholderImage:@"header"];

}
@end
