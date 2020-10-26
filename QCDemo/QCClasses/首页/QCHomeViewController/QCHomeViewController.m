//
//  QCHomeViewController.m
//  QCDemo
//
//  Created by JQC on 2020/10/14.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "QCHomeViewController.h"
#import "QCLoginViewController.h"
#import "QCWebSocket.h"
#import <CommonCrypto/CommonDigest.h>

@interface QCHomeViewController ()

@property (nonatomic, strong) UILabel *  textLabel;
@end

@implementation QCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KBACK_COLOR;
//    [[QCWebSocket shared] connectServer];

    [[QCMapInstance shared] startLocationIsNeedCity:YES WithCompletion:^(CLLocationCoordinate2D coor, NSString *city, NSString *cityCode) {
        NSLog(@"%@",city);
    }];


}
- (void)buttonAction:(UIButton *)sender {
    

    

}














@end
