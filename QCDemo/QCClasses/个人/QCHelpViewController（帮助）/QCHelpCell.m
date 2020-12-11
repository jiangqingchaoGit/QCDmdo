//
//  QCHelpCell.m
//  QCDemo
//
//  Created by JQC on 2020/10/28.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHelpCell.h"

@implementation QCHelpCell

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

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(0), KSCALE_WIDTH(309), KSCALE_WIDTH(55))];
        self.titleLabel.font = K_16_FONT;
        self.titleLabel.textColor = [QCClassFunction stringTOColor:@"#000000"];
        [self.contentView addSubview:self.titleLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(33), KSCALE_WIDTH(55), KSCALE_WIDTH(309), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}


- (void)fillCellWithModel:(QCHelpModel *)model {
    self.titleLabel.text = model.title;

}
@end
