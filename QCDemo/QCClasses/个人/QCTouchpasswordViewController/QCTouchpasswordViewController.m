//
//  QCTouchpasswordViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/29.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCTouchpasswordViewController.h"
#import "RSHandlePWDView.h"
@interface QCTouchpasswordViewController ()<RSHandlePWDViewDelegate>
@property (nonatomic, strong) RSHandlePWDView * handlePWDView;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, assign) BOOL isHave;

@end

@implementation QCTouchpasswordViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BaseNavigationController * navigationController = (BaseNavigationController *)[QCClassFunction currentNC];
    navigationController.panGestureRecognizer.enabled = NO;
    navigationController.edgePanGestureRecognizer.enabled = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BaseNavigationController * navigationController = (BaseNavigationController *)[QCClassFunction currentNC];
    navigationController.panGestureRecognizer.enabled = YES;
    navigationController.edgePanGestureRecognizer.enabled = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


#pragma mark - initUI
- (void)initUI {
    self.view.backgroundColor = KBACK_COLOR;
    self.title = @"设置手势密码";
    self.isHave = NO;
    self.handlePWDView = [[RSHandlePWDView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(60), KSCALE_WIDTH(100), KSCALE_WIDTH(255), KSCALE_WIDTH(255))];
    self.handlePWDView.delegate = self;
    [self.view addSubview:self.handlePWDView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(85), KSCALE_WIDTH(400), KSCALE_WIDTH(200), KSCALE_WIDTH(30))];
    self.contentLabel.font = K_20_FONT;
    self.contentLabel.textColor = KTEXT_COLOR;
    self.contentLabel.text = @"绘制图案";

    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.contentLabel];

    

    
    
}
- (void)handlePWDView:(RSHandlePWDView*)handleView inputComplate:(NSArray*)complateResult {
    
    NSLog(@"%@",complateResult);
    if (self.isHave) {
        //  上传
    }else{
//        重复
        self.isHave = YES;
        self.contentLabel.text = @"请确认图案";


        
    }
    
}

@end
