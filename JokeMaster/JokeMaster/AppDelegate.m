//
//  AppDelegate.m
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "AppDelegate.h"
#import "JMGlobalHeader.h"
//  AppDelegate.m
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "JMPlayVideoViewController.h"
#import "JMProfileViewController.h"

#import "iVersion.h"


@interface AppDelegate ()
{
    NSString *CurrentViewController;
}
@end

@implementation AppDelegate

+ (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iVersion sharedInstance].checkPeriod=0;
    [iVersion sharedInstance].checkAtLaunch=YES;

    [iVersion sharedInstance].applicationBundleID = @"com.esolz.JokeMaster";
    
    //configure iVersion. These paths are optional - if you don't set
    //them, iVersion will just get the release notes from iTunes directly (if your app is on the store)
//    [iVersion sharedInstance].remoteVersionsPlistURL = @"http://charcoaldesign.co.uk/iVersion/versions.plist";
//    [iVersion sharedInstance].localVersionsPlistPath = @"versions.plist";
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
[GIDSignIn sharedInstance].clientID = @"257838552176-cik6p18idkqgrgecuss42mcmn66gd1lk.apps.googleusercontent.com";
    
    [Fabric with:@[[Crashlytics class]]];

       _badgeCount=0;
      [UIApplication sharedApplication].applicationIconBadgeNumber = _badgeCount;
    [self registerForRemoteNotifications];
    
    
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
//    {
//        // use registerUserNotificationSettings
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        
//        [application registerForRemoteNotifications];
//        
//        //        alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Launch Finish" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        //                [alert show];
//    }
//    else
//    {
//        // use registerForRemoteNotifications
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//        
//       
//        
//    }
//    
//    
//#else
//    {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
//    }
//#endif

    


    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] length]==0)
    {
        
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        
        NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
        
NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:language];
        
        NSString *languageCode = [languageDic objectForKey:@"kCFLocaleLanguageCodeKey"];
        
        DebugLog(@"country %@ and language %@",countryCode,languageCode);
        
        if ([languageCode isEqualToString:@"he"]) {
            
            LocalizationSetLanguage(@"he");

                     [[NSUserDefaults standardUserDefaults]setObject:@"he" forKey:@"language"];
            [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"langmode"];
        }
       else if ([languageCode isEqualToString:@"zh"]) {
           LocalizationSetLanguage(@"zh");
           
                  [[NSUserDefaults standardUserDefaults]setObject:@"zh" forKey:@"language"];
           [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"langmode"];
       }
       else if ([languageCode isEqualToString:@"es"]) {
           LocalizationSetLanguage(@"es");
           
                    [[NSUserDefaults standardUserDefaults]setObject:@"es" forKey:@"language"];
           [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:@"langmode"];
       }
       else if ([languageCode isEqualToString:@"hi"]) {
           LocalizationSetLanguage(@"hi");
           
           [[NSUserDefaults standardUserDefaults]setObject:@"hi" forKey:@"language"];
           [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"langmode"];
       }
        else{
        LocalizationSetLanguage(@"en");
           [[NSUserDefaults standardUserDefaults]setObject:@"en" forKey:@"language"];
               [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"langmode"];
            
        }
     
    }
    else
    {
        NSString *lang=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"language"]];
        LocalizationSetLanguage(lang);
        
    }


    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"]) {
        
            _isLogged=true;
        _userId=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"];
        _userName=[[NSUserDefaults standardUserDefaults] valueForKey:@"Name"];
        _userImage=[[NSUserDefaults standardUserDefaults] valueForKey:@"Image"];

           };
   
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        
        [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
        [[UIView appearanceWhenContainedIn:[UIAlertView class], nil] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
        
        
        
    }
    
    return YES;
}

- (void)registerForRemoteNotifications {
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    
    handled = [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}
//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = _badgeCount;
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [UIApplication sharedApplication].applicationIconBadgeNumber = _badgeCount;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushCount" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushCount" object:nil];
}





- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"JokeMaster"];
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
#pragma mark - Push Notification

//
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

//
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    DebugLog(@"didReceiveRemoteNotification %@",userInfo);
    
   
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        _pushDict=[userInfo objectForKey:@"aps"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceivedPush" object:nil];
        
    }
    else if (state == UIApplicationStateInactive || state == UIApplicationStateBackground)
    {
        
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        
        
        
        _pushDict=[userInfo objectForKey:@"aps"];
        
        
        
        
        
        
        if ( [[_pushDict objectForKey:@"type"]intValue]==1) {
            
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
            //
            JMPlayVideoViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
            VC.VideoId=[_pushDict valueForKey:@"videoid"];
            
            [navigationController pushViewController:VC animated:YES];
            
        }
        else
            if ( [[_pushDict objectForKey:@"type"]intValue]==2) {
                
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
                //
                JMProfileViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
                VC.ProfileUserId=[_pushDict valueForKey:@"followingid"];
                
                
                
                [navigationController pushViewController:VC animated:YES];
                
            }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReadPush" object:nil];
        

        
    }
    
    
}
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
//
//{
//    NSLog(@"didReceiveRemoteNotification %@",userInfo);
//    
//    //handle the actions
//    
//    
//    
//    NSLog(@"handle action");
//    
//    if ([identifier isEqualToString:@"declineAction"])
//    {
//        
//    }
//    
//    else if ([identifier isEqualToString:@"answerAction"])
//    {
//        
//    }
//    
//}
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    
//    NSString *deviceToken1 = [[[[deviceToken description]
//                                
//                                stringByReplacingOccurrencesOfString:@"<"withString:@""]
//                               
//                               stringByReplacingOccurrencesOfString:@">" withString:@""]
//                              
//                              stringByReplacingOccurrencesOfString: @" " withString: @""];
//    
//    
//    if ([deviceToken1 length] == 0 || [deviceToken1 isKindOfClass:[NSNull class]] || [deviceToken1 isEqual:@"<null>"] || deviceToken1==nil || [deviceToken1 isEqual:@"(null)"])
//    {
//        // deviceToken1 = @"cb8143a8becd78c317b8e0c722c9177a4b9579ab25f5e2f5f4fe806dc2937a3e";
//        deviceToken1 = @"";
//        [[NSUserDefaults standardUserDefaults] setObject:deviceToken1 forKey:@"deviceToken"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:deviceToken1 forKey:@"deviceToken"];
//    }
//    
//    DebugLog(@"device token here: %@",deviceToken1);
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
////        UIAlertView *pushResponse = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"DeviceToken:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
////        [pushResponse show];
//    
//    
//}
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//    DebugLog(@"error in did fail to regidter remote notification %@",error.description);
//    //    [[NSUserDefaults standardUserDefaults] setObject:@"cb8143a8becd78c317b8e0c722c9177a4b9579ab25f5e2f5f4fe806dc2937a3e" forKey:@"deviceToken"];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"deviceToken"];
//    
//}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
    
    UIViewController *topMostViewControllerObj = [self topViewController];
    CurrentViewController = NSStringFromClass([topMostViewControllerObj class]);
    
    
    NSLog(@"display controller%@",CurrentViewController);
    
    
    if ([CurrentViewController isEqualToString:@"JMPlayVideoViewController"])
    {
        return UIInterfaceOrientationMaskAll;
    }
    else return UIInterfaceOrientationMaskPortrait;
}
- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
       UIViewController* presentedViewController = rootViewController.presentedViewController;
       return [self topViewControllerWithRootViewController:presentedViewController];
 //       UINavigationController* navigationController = (UINavigationController*)rootViewController;
//        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else {
        return rootViewController;
    }
}
//Called when a notification is delivered to a foreground app.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0){
    
    
    NSLog(@"device token : %@",deviceToken);
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    _userDeviceToken=[NSString stringWithFormat:@"%@",token];
    
    if(_userDeviceToken.length==0 || [_userDeviceToken isKindOfClass:[NSNull class]])
    {
        _userDeviceToken=@"1234456789987654321";
    }
        [[NSUserDefaults standardUserDefaults] setObject:_userDeviceToken forKey:@"deviceToken"];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0)
{
    
    _userDeviceToken=@"1234456789987654321";
    
            [[NSUserDefaults standardUserDefaults] setObject:_userDeviceToken forKey:@"deviceToken"];
}

//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    
    //  [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",notification.request.content.userInfo]];
    
    //  _badgeCount++;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    _pushDict=[notification.request.content.userInfo objectForKey:@"aps"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceivedPush" object:nil];
    
    // completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    
    
    //    UIApplication *application = [UIApplication sharedApplication];
    //
    //
    //    if (application.applicationState == UIApplicationStateActive)
    //    {
    
    
    
    //    }
    //    else if (application.applicationState == UIApplicationStateBackground || application.applicationState == UIApplicationStateInactive)
    //    {
    
    //   _badgeCount++;
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    
    
    _pushDict=[response.notification.request.content.userInfo objectForKey:@"aps"];
    
    
    
    
    
    
    if ( [[_pushDict objectForKey:@"type"]intValue]==1) {
        

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
//
        JMPlayVideoViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
        VC.VideoId=[_pushDict valueForKey:@"videoid"];

        [navigationController pushViewController:VC animated:YES];
        
    }
    else
        if ( [[_pushDict objectForKey:@"type"]intValue]==2) {
            
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
            //
            JMProfileViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
            VC.ProfileUserId=[_pushDict valueForKey:@"followingid"];
            

            
            [navigationController pushViewController:VC animated:YES];
            
        }

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReadPush" object:nil];
        
 //   }

    completionHandler();
}

@end
