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
        self.tabBar.unselectedItemTintColor = [QCClassFunction stringTOColor:@"#999999"];
    } else {

    }
        //  选中时的颜色
    self.tabBar.tintColor = KTEXT_COLOR;
    self.delegate = self;
    QCHomeViewController * homeViewController = [[QCHomeViewController alloc] init];
    BaseNavigationController * homeViewNav = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    homeViewNav.tabBarItem.title = @"集市";
    homeViewNav.tabBarItem.image = [UIImage imageNamed:@"select"];
    homeViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"select_s"];
    
    QCReleaseViewController * releaseViewController = [[QCReleaseViewController alloc] init];
    BaseNavigationController * releaseViewNav = [[BaseNavigationController alloc] initWithRootViewController:releaseViewController];
    releaseViewNav.tabBarItem.title = @"发布";
    releaseViewNav.tabBarItem.image = [UIImage imageNamed:@"select"];
    releaseViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"select_s"];
    
    QCMessageViewController * messageViewController = [[QCMessageViewController alloc] init];
    BaseNavigationController * messageViewNav = [[BaseNavigationController alloc] initWithRootViewController:messageViewController];
    messageViewNav.tabBarItem.title = @"消息";
    messageViewNav.tabBarItem.image = [UIImage imageNamed:@"select"];
    messageViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"select_s"];
    
    QCBookViewController * bookViewController = [[QCBookViewController alloc] init];
    BaseNavigationController * bookViewNav = [[BaseNavigationController alloc] initWithRootViewController:bookViewController];
    bookViewNav.tabBarItem.title = @"通讯录";
    bookViewNav.tabBarItem.image = [UIImage imageNamed:@"select"];
    bookViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"select_s"];
    
    QCPersonViewController * personViewController = [[QCPersonViewController alloc] init];
    BaseNavigationController * personViewNav = [[BaseNavigationController alloc] initWithRootViewController:personViewController];
    personViewNav.tabBarItem.title = @"我";
    personViewNav.tabBarItem.image = [UIImage imageNamed:@"select"];
    personViewNav.tabBarItem.selectedImage = [UIImage imageNamed:@"select_s"];
    self.viewControllers = @[homeViewNav,releaseViewNav,messageViewNav,bookViewNav,personViewNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
//    if ([kFetchNSUserDefaults(@"token") isEqualToString:@"0"] || kFetchNSUserDefaults(@"token") == nil) {
//
//    }
    
    if ( [viewController.tabBarItem.title isEqualToString:@"收入"] || [viewController.tabBarItem.title isEqualToString:@"发布"]) {
        QCLoginViewController * loginViewController = [QCLoginViewController new];
        BaseNavigationController * loginNav = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
        loginNav.modalPresentationStyle=UIModalPresentationCustom;
        [self presentViewController:loginNav animated:YES completion:nil];
        return NO;
        
    }
    
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
