//
//  QCChangeGroupViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/27.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChangeGroupViewController.h"
//  一键换群
#import "QCChangeGroupCell.h"
@interface QCChangeGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIButton * changeButton;
@property (nonatomic, strong) UITextView * contentTextView;
@end

@implementation QCChangeGroupViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self createTableView];
    [self createHeaderView];
}

#pragma mark - tapAction


#pragma mark - initUI

- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationItem.title = @"VIP专享";
  
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:KSCREEN_BOUNDS style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    if(@available(iOS 11.0,*)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    [self.tableView registerClass:[QCChangeGroupCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    
}
- (void)createHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(60))];
    self.headerView.backgroundColor = KBACK_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(9), KSCALE_WIDTH(52), KSCALE_WIDTH(52))];
    self.headerImageView.image = KHeaderImage;
    [QCClassFunction filletImageView:self.headerImageView withRadius:KSCALE_WIDTH(26)];
    [self.headerView addSubview:self.headerImageView];

    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(10), KSCALE_WIDTH(200), KSCALE_WIDTH(50))];
    self.contentLabel.font = K_16_FONT;
    self.contentLabel.textColor = KTEXT_COLOR;
    self.contentLabel.text = @"特权剩余：365天";
    [self.headerView addSubview:self.contentLabel];

    self.changeButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(283), KSCALE_WIDTH(19), KSCALE_WIDTH(72), KSCALE_WIDTH(32))];
    self.changeButton.backgroundColor = [QCClassFunction stringTOColor:@"#F2F2F2"];
    self.changeButton.titleLabel.font = K_12_FONT;
    [self.changeButton setTitle:@"一键换群" forState:UIControlStateNormal];
    [self.changeButton setTitleColor:[QCClassFunction stringTOColor:@"#BCBCBC"] forState:UIControlStateNormal];
    [QCClassFunction filletImageView:self.changeButton withRadius:KSCALE_WIDTH(6)];
    [self.headerView addSubview:self.changeButton];
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), KSCALE_WIDTH(70), KSCALE_WIDTH(335), KSCALE_WIDTH(100))];
    self.contentTextView.layer.borderWidth = 1;
    self.contentTextView.layer.borderColor = [QCClassFunction stringTOColor:@"#6B6B6B"].CGColor;
    self.contentTextView.userInteractionEnabled = NO;
    self.contentTextView.textContainerInset = UIEdgeInsetsMake(KSCALE_WIDTH(15),KSCALE_WIDTH(5), KSCALE_WIDTH(15), KSCALE_WIDTH(5));
    self.contentTextView.text = @"之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”之前使用人脸身份证校验时，一直返回code=-1提示“照片质量太低”";
    [QCClassFunction filletImageView:self.contentTextView withRadius:KSCALE_WIDTH(8)];
    [self.headerView addSubview:self.contentTextView];
    
    CGFloat width = CGRectGetWidth(self.contentTextView.frame);
    CGFloat height = CGRectGetHeight(self.contentTextView.frame);
    CGSize newSize = [self.contentTextView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = self.contentTextView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
    self.contentTextView.frame= newFrame;

    
    self.headerView.frame = CGRectMake(KSCALE_WIDTH(0), KSCALE_WIDTH(0), KSCALE_WIDTH(335), KSCALE_WIDTH(90) + fmax(height, newSize.height));
    



        
}




#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(70);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCChangeGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
}




@end
