//
//  QCChatViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/20.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCChatViewController.h"
#import "QCChatCell.h"
#import "QCChatFooterView.h"
@interface QCChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) QCChatFooterView * footerView;
@end

@implementation QCChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createFooterView];
    
}

#pragma mark - tapAction
- (void)giveAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        
        CGRect frame1 = self.tableView.frame;
        frame1.origin = CGPointMake( 0, - 240);
        self.tableView.frame = frame1;
        
        CGRect frame = self.footerView.frame;
        frame.origin = CGPointMake( 0, KSCREEN_HEIGHT - KNavHight - 50 - 240);
        self.footerView.frame = frame;
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
    
    
}
#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
}
- (void)createTableView {
    
}

- (void)createFooterView {
    
//    self.footerView = [[QCChatFooterView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT - KSCALE_WIDTH(58) - KNavHight, KSCREEN_WIDTH, KSCALE_WIDTH(308))];
    
    self.footerView = [[QCChatFooterView alloc] initWithFrame:CGRectMake(0, 150, KSCREEN_WIDTH, KSCALE_WIDTH(308))];

    [self.view addSubview:self.footerView];
    
    
    

    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KSCALE_WIDTH(72);
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCChatCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
}




@end
