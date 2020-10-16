//
//  BaseNavigationController.m
//  smartHome_brc
//
//  Created by ra on 2018/7/12.
//  Copyright © 2018年 com.gridlink. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  https://www.jianshu.com/p/ba88a4309003
    // Do any additional setup after loading the view.
    
//    self.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationBar.translucent = YES;
    self.navigationBar.tintColor = [UIColor blackColor];
//    [QCClassFunction setStatusBarBackgroundColor:[UIColor clearColor]];


    self.navigationBar.titleTextAttributes=
  @{NSForegroundColorAttributeName:[UIColor blackColor],
    NSFontAttributeName:K_16_FONT};

   // [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar"] forBarMetrics:UIBarMetricsDefault];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.navigationBar.translucent = NO;
    }
    
    // 屏幕边缘滑动(只能在屏幕的边缘才能触发该手势，不能在屏幕的任意一点触发该手势)
    self.edgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)self.interactivePopGestureRecognizer;
    
    // 滑动手势（禁用系统自带的屏幕边缘滑动手势，使用自定义的滑动手势目的就是达到触摸屏幕上的任意一点向右滑动都能实现返回的效果）
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.edgePanGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    self.panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    // 禁用系统的屏幕边缘滑动手势
//    panGestureRecognizer.enabled = NO;
//    edgePanGestureRecognizer.enabled = NO;
}
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)sender{
    [self  popViewControllerAnimated:YES];

}
// 是否允许触发手势，如果是根视图控制器则不需要
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.childViewControllers.count > 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//重写这个方法，在跳转后自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置返回按钮
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setImage:[UIImage imageNamed:@"back_s"] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.backButton.frame =CGRectMake(0, 0, 20, 20);

        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    //处理了push后隐藏底部UITabBar的情况，并解决了iPhonX上push时UITabBar上移的问题。
    CGRect rect = self.tabBarController.tabBar.frame;
    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    self.tabBarController.tabBar.frame = rect;
}


#pragma mark - 点击事件
- (void)back{
    [self  popViewControllerAnimated:YES];
}


@end
