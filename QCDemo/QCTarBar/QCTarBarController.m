//
//  QCTarBarController.m
//  QCXinFenXiang
//
//  Created by pf-001 on 2018/8/25.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import "QCTarBarController.h"



@interface QCTarBarController ()<UITabBarControllerDelegate>

@end

@implementation QCTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];

//    [self startLocation];

}


- (void)startLocation {
    
//    
//    [[QCMapInstance shared] startLocationIsNeedCity:YES WithCompletion:^(CLLocationCoordinate2D coor, NSString *city,NSString *cityCode) {
//        
//        
//        
//        if([city rangeOfString:@"市"].location !=NSNotFound) {
//            city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
//            
//        }else{
//            
//        }
//        
//        
//        
//        
//        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//            UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                NSLog(@"点击退出登录");
//
//
//            }];
//
//            UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                NSLog(@"点击了取消");
//
//            }];
//
//
//            [actionSheet addAction:alertT];
//
//            [actionSheet addAction:alertF];
//
//            [self presentViewController:actionSheet animated:YES completion:nil];
//
//
//
//
//        
//    }];
//    
    
    
    
}


//这里设置两个视图控制器的代码是重复的，为了便于观察理解，我没有抽取，大家日常写代码的时候请注意养成良好的代码习惯。
- (void)setupChildControllers {

    
    if (@available(iOS 10.0, *)) {
        //  没有被选中的颜色
//        self.tabBar.unselectedItemTintColor = [QCClassFunction stringTOColor:@"#999999"];
    } else {

    }
        //  选中时的颜色
//    self.tabBar.tintColor = KTEXT_COLOR;
//    self.delegate = self;
//    QCNewHomeViewController * homeViewController = [[QCNewHomeViewController alloc] init];
//    homeViewController.typeStr = @"1";
//    BaseNavigationController * homeViewNav = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
//    homeViewNav.tabBarItem.title = @"精选";
//    //设置图片
//    homeViewNav.tabBarItem.image = [UIImage imageNamed:@"select"];
//    //设置选中图片
//    homeViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"select_s"];
//
//    JFAllViewController * allViewController = [[JFAllViewController alloc] init];
//    BaseNavigationController * allNav = [[BaseNavigationController alloc] initWithRootViewController:allViewController];
//    allNav.tabBarItem.title = @"全部";
//    allNav.tabBarItem.image = [UIImage imageNamed:@"all"];
//    allNav.tabBarItem.selectedImage = [UIImage imageNamed:@"all_s"];
//    
//    QCTurnTicketViewController * turnTicketViewController = [[QCTurnTicketViewController alloc] init];
//    BaseNavigationController * turnTicketNav = [[BaseNavigationController alloc] initWithRootViewController:turnTicketViewController];
//    turnTicketNav.tabBarItem.title = @"转票";
//     turnTicketNav.tabBarItem.image = [UIImage imageNamed:@"turn"];
//    turnTicketNav.tabBarItem.selectedImage = [UIImage imageNamed:@"turn_s"];
//    
//    QCTheRaiseViewController * theRaiseViewController = [[QCTheRaiseViewController alloc] init];
//    BaseNavigationController * theRaiseNav = [[BaseNavigationController alloc] initWithRootViewController:theRaiseViewController];
//    theRaiseNav.tabBarItem.title = @"众筹";
//    theRaiseNav.tabBarItem.image = [UIImage imageNamed:@"raise"];
//    theRaiseNav.tabBarItem.selectedImage = [UIImage imageNamed:@"raise_s"];
//
//    JFMineController * personViewController = [[JFMineController alloc] init];
//    BaseNavigationController * personNav = [[BaseNavigationController alloc] initWithRootViewController:personViewController];
//    personNav.tabBarItem.title = @"我的";
//    personNav.tabBarItem.image = [UIImage imageNamed:@"person"];
//    personNav.tabBarItem.selectedImage = [UIImage imageNamed:@"person_s"];
//
//
//    self.viewControllers = @[homeViewNav,allNav,turnTicketNav,theRaiseNav,personNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
//    if ([kFetchNSUserDefaults(@"token") isEqualToString:@"0"] || kFetchNSUserDefaults(@"token") == nil) {
//        if ( [viewController.tabBarItem.title isEqualToString:@"收入"] || [viewController.tabBarItem.title isEqualToString:@"我的"]) {
//            QCLoginViewController * loginViewController = [QCLoginViewController new];
//            BaseNavigationController * loginNav = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
//
//            [self presentViewController:meNav animated:YES completion:nil];
//            return NO;
//            
//        }
//    }
    return  YES;
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
