//
//  QCComplaintsListCell.m
//  QCDemo
//
//  Created by JQC on 2020/12/11.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCComplaintsListCell.h"

@implementation QCComplaintsListCell

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
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
        self.contentLabel.font = K_14_FONT;
        self.contentLabel.textColor = KTEXT_COLOR;
        [self.contentView addSubview:self.contentLabel];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(255), KSCALE_WIDTH(10), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
        self.statusLabel.font = K_14_FONT;
        self.statusLabel.textColor = [QCClassFunction stringTOColor:@"#FFBA00"];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.statusLabel];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(40), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
        self.typeLabel.text = @"存在涉黄行为";
        self.typeLabel.font = K_14_FONT;
        self.typeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        [self.contentView addSubview:self.typeLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(255), KSCALE_WIDTH(40), KSCALE_WIDTH(100), KSCALE_WIDTH(30))];
        self.timeLabel.text = @"2010-10-10";
        self.timeLabel.font = K_10_FONT;
        self.timeLabel.textColor = [QCClassFunction stringTOColor:@"#666666"];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(79), KSCALE_WIDTH(335), KSCALE_WIDTH(1))];
        lineView.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
        [self.contentView addSubview:lineView];
    }
    return self;
}
- (void)fillCellWithModel:(QCComplaintsListModel *)model {
    self.contentLabel.text = [NSString stringWithFormat:@"投诉对象:%@",model.targer_name];
    self.typeLabel.text = [NSString stringWithFormat:@"投诉类型:%@",model.type_name];

    switch ([model.status intValue]) {
        case 1:
            self.statusLabel.text = @"待处理";
            break;
        case 2:
            self.statusLabel.text = @"处理中";

            break;
        case 3:
            self.statusLabel.text = @"已处理";

            break;
        case 4:
            self.statusLabel.text = @"已撤销";

            break;
            
        default:
            break;
    }
}

@end
