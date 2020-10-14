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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [WXApi registerApp:@"wxee57a3177d3643b4" universalLink:@"https://universal-links.xianduoduo123.com/"];

    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxee57a3177d3643b4" appSecret:@"5ae16e3a812bbe1c7051b6ebe8a0da26" redirectURL:@"https://your_domain/app11111/"];
    [UMConfigure initWithAppkey:@"5b92186af29d9806c800021c" channel:@"AppStore"];


    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    QCTarBarController  *tab = [[QCTarBarController alloc]init];
    self.window.rootViewController=tab;
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


// 支持所有iOS系统 URL回调方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    
    if (!result) {
         // 其他如支付等SDK的回调
    }
    return result;
    
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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

@end
