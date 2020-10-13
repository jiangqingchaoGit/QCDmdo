//
//  AppDelegate.h
//  QCDemo
//
//  Created by JQC on 2020/10/13.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

