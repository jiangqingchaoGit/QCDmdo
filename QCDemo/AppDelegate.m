//
//  AppDelegate.m
//  QCDemo
//
//  Created by JQC on 2020/10/13.
//  Copyright © 2020 JQC. All rights reserved.
//

#import "AppDelegate.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMCommon/UMCommon.h>
#import <WXApi.h>

#import "QCBookViewController.h"
#import "QCMessageViewController.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self GETURL];
    
    [WXApi registerApp:@"wxee57a3177d3643b4" universalLink:@"https://universal-links.xianduoduo123.com/"];

    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxee57a3177d3643b4" appSecret:@"5ae16e3a812bbe1c7051b6ebe8a0da26" redirectURL:@"https://universal-links.xianduoduo123.com/"];
    [UMConfigure initWithAppkey:@"5b92186af29d9806c800021c" channel:@"AppStore"];

    

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    QCTarBarController  *tab = [[QCTarBarController alloc]init];
    self.window.rootViewController=tab;
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[QCDataBase shared] createFMDB];

    
    return YES;
}

- (void)GETURL {
    
    

    [QCAFNetWorking QCGET:@"https://app-testoss.xianduoduo123.com/oss.txt" parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [QCClassFunction Save:responseObject[@"aesdatakey"] Key:@"AESKEY"];
        NSArray * domainArr = responseObject[@"domain"];
        NSArray * wsArr = responseObject[@"ws"];

        [QCClassFunction Save:responseObject[@"domain"][domainArr.count / 3] Key:@"HTTPURL"];
        [QCClassFunction Save:responseObject[@"ws"][wsArr.count / 3] Key:@"WBURL"];



        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

// 支持所有iOS系统 URL回调方法


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];

    if (!result) {
         // 其他如支付等SDK的回调
    }
    return result;

}



- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {


    if (![[UMSocialManager defaultManager] handleUniversalLink:userActivity options:nil]) {
          // 其他SDK的回调

         return [WXApi handleOpenUniversalLink:userActivity delegate:self];
      }
      return YES;
}






#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer  API_AVAILABLE(ios(10.0)){
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    
    @synchronized (self) {
        
        if (_persistentContainer == nil) {
            if (@available(iOS 10.0, *)) {
                _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"QCDemo"];
            } else {
                // Fallback on earlier versions
            }
            if (@available(iOS 10.0, *)) {
                [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                    if (error != nil) {
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        
                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                        abort();
                    }
                }];
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-  (void)applicationWillEnterForeground:(UIApplication *)application {

    NSLog(@"应用程序将要进入活动状态，即将进入前台运行");
    [QCClassFunction loginWithWebsocket];
    
    QCAssociatedModel * model = [[QCAssociatedModel alloc] init];
    NSArray * arr = [[QCDataBase shared] queryAssociatedModel:model];
    
    UITabBarItem * item = [[QCClassFunction getCurrentViewController].tabBarController.tabBar.items objectAtIndex:2];
    if (arr.count == 0) {
        item.badgeValue = nil;

    }else{
        [item setBadgeValue:[NSString stringWithFormat:@"%ld",arr.count]];
        
        if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCBookViewController class]]) {
            QCBookViewController * bookViewController = (QCBookViewController *)[QCClassFunction getCurrentViewController];
            
            
            [bookViewController GETDATA];
            
        }else{

        }
        
    }
    
    
    QCListModel * listModel = [[QCListModel alloc] init];
    NSMutableArray * dataArr = [[QCDataBase shared] queryListModel:listModel];

    NSInteger count = 0;
    for (QCListModel * model in dataArr) {
        count = count + [model.count integerValue];
    }
    
    UITabBarItem * item1 = [[QCClassFunction getCurrentViewController].tabBarController.tabBar.items objectAtIndex:1];
    if (count == 0) {
        item1.badgeValue = nil;

    }else{
        item1.badgeValue = [NSString stringWithFormat:@"%ld",count];

    }
    
    if ([[QCClassFunction getCurrentViewController] isKindOfClass:[QCMessageViewController class]]) {
        QCMessageViewController * messageViewController = (QCMessageViewController *)[QCClassFunction getCurrentViewController];
        
        
        [messageViewController GETDATA];
        
    }else{

    }
    

    
}


@end
