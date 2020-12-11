//
//  QCHelpViewDetailsController.m
//  QCDemo
//
//  Created by JQC on 2020/12/8.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHelpViewDetailsController.h"
#import <WebKit/WebKit.h>
@interface QCHelpViewDetailsController ()

@property (nonatomic, strong) WKWebView * webView;

@end

@implementation QCHelpViewDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createWebView];
}



- (void)createWebView {
    
    self.view.backgroundColor = KBACK_COLOR;

    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(KSCALE_WIDTH(20), 0, KSCALE_WIDTH(335), KSCREEN_HEIGHT - KNavHight)];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;

    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [self.webView loadHTMLString:[headerString stringByAppendingString:self.contentStr] baseURL:nil];

    
    [self.view addSubview:self.webView];
}






@end
