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
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)  NSString *userId,*userName,*userImage,*userTypeId,*authToken,*password ;
@property(strong,nonatomic) NSString *userDeviceToken,*userDesignation;
@property(nonatomic) int badgeCount;
@property(nonatomic) BOOL isLogged,socialLogin;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

