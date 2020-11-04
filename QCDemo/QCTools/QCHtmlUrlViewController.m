//
//  QCHtmlUrlViewController.m
//  QCWarehouseRawDemo
//
//  Created by JQC on 2019/2/13.
//  Copyright © 2019 JQC. All rights reserved.
//

#import "QCHtmlUrlViewController.h"
#import <WebKit/WebKit.h>
@interface QCHtmlUrlViewController ()
@property (nonatomic, strong) WKWebView * webView;

@end

@implementation QCHtmlUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KBACK_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"详情";
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - (KNavHight))];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://i.meituan.com/awp/hfe/block/a945391288b790d558b7/78716/index.html?utm_term=80298.cps.26710505&utm_campaign=AffProg&utm_medium=wandie&urpid=80298.160439379748.26710505.0&appkey=9c5a0683c2b77738a1d24cfbd445aa88%3A1&source=wandie&_rdt=1&utm_source=&utm_content=&noguide=1"]];
    
    
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
    
    
    
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
