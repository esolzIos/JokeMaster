//
//  AppDelegate.h
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LocalizationSystem.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>
@property () BOOL restrictRotation;
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)  NSString *userId,*userName,*userImage,*userTypeId,*authToken,*password ;
@property(strong,nonatomic) NSString *userDeviceToken,*userDesignation;
@property(nonatomic) int badgeCount;
@property(nonatomic) BOOL isLogged,socialLogin;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property(nonatomic) NSDictionary *pushDict;
- (void)saveContext;


@end

