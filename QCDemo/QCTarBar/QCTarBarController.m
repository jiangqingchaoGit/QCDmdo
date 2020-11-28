//
//  QCTarBarController.m
//  QCXinFenXiang
//
//  Created by pf-001 on 2018/8/25.
//  Copyright © 2018年 pf-001. All rights reserved.
//

#import "QCTarBarController.h"
#import "QCHomeViewController.h"
#import "QCReleaseViewController.h"
#import "QCMessageViewController.h"
#import "QCBookViewController.h"
#import "QCPersonViewController.h"
@interface QCTarBarController ()<UITabBarControllerDelegate>

@end

@implementation QCTarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
    
    
}




//这里设置两个视图控制器的代码是重复的，为了便于观察理解，我没有抽取，大家日常写代码的时候请注意养成良好的代码习惯。
- (void)setupChildControllers {
    
    if (@available(iOS 10.0, *)) {
        //  没有被选中的颜色
        self.tabBar.unselectedItemTintColor = [QCClassFunction stringTOColor:@"#404040"];
    } else {
        
    }
    //  选中时的颜色
    self.tabBar.tintColor = [QCClassFunction stringTOColor:@"#ffba00"];
    self.delegate = self;
    QCHomeViewController * homeViewController = [[QCHomeViewController alloc] init];
    BaseNavigationController * homeViewNav = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    homeViewNav.tabBarItem.title = @"多多";
    homeViewNav.tabBarItem.image = [UIImage imageNamed:@"t_home"];
    homeViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"t_home_s"];
    
    QCMessageViewController * messageViewController = [[QCMessageViewController alloc] init];
    BaseNavigationController * messageViewNav = [[BaseNavigationController alloc] initWithRootViewController:messageViewController];
    messageViewNav.tabBarItem.title = @"消息";
    messageViewNav.tabBarItem.image = [UIImage imageNamed:@"t_message"];
    messageViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"t_message_s"];
    
    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:@"消息" image:nil tag:1];
    [item setBadgeValue:@""];
    
    QCBookViewController * bookViewController = [[QCBookViewController alloc] init];
    BaseNavigationController * bookViewNav = [[BaseNavigationController alloc] initWithRootViewController:bookViewController];
    bookViewNav.tabBarItem.title = @"通讯录";
    bookViewNav.tabBarItem.image = [UIImage imageNamed:@"t_box"];
    bookViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"t_ box_s"];
    

    
    QCPersonViewController * personViewController = [[QCPersonViewController alloc] init];
    BaseNavigationController * personViewNav = [[BaseNavigationController alloc] initWithRootViewController:personViewController];
    personViewNav.tabBarItem.title = @"我";
    personViewNav.tabBarItem.image = [UIImage imageNamed:@"t_me"];
    personViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"t_me_s"];
    self.viewControllers = @[homeViewNav,messageViewNav,bookViewNav,personViewNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    
    if ( [viewController.tabBarItem.title isEqualToString:@"消息"] || [viewController.tabBarItem.title isEqualToString:@"通讯录"]  || [viewController.tabBarItem.title isEqualToString:@"我"]) {
        
        if ([QCClassFunction Read:@"token"] == nil) {
            QCLoginViewController * loginViewController = [QCLoginViewController new];
            BaseNavigationController * loginNav = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
            loginNav.modalPresentationStyle=UIModalPresentationCustom;
            [self presentViewController:loginNav animated:YES completion:nil];
            return NO;
        }
        
        
        
    }
    
    return  YES;
}




@end
