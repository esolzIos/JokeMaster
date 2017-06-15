//
//  JMGlobalMethods.m
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import <QuartzCore/QuartzCore.h>
#import "JMHeaderView.h"
#import "AppDelegate.h"
#import <SystemConfiguration/SCNetworkReachability.h>

@interface JMGlobalMethods ()<UITabBarControllerDelegate,UITabBarDelegate,UISearchBarDelegate,UIGestureRecognizerDelegate>
{
    
    NSURLSession *session;
    UIView *headerView, *footerView ,*refreshView,*pushView;
    NSString *CurrentViewController;
    BOOL loading;
    
    AppDelegate *app;
    
    
}



@end

@implementation JMGlobalMethods
@synthesize HeaderView,MainView;
@synthesize headerLbl,footerTabBar,favImage,myQueue,searchBar,footerLoadView,footerReloadView,profileBtn,profileView,chatBtn,chatView,notifyBtn,notifyView,pushTitle,pushDesc,pushBtn,pushInnerView,badgeLbl;
@synthesize managedObjectCon = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}




-(void)viewDidAppear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendAfterPush) name:@"ReceivedPush" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readAfterPush) name:@"ReadPush" object:nil];
    
    
    // Current View Controller
    
    UIViewController *topMostViewControllerObj = [self topViewController];
    CurrentViewController = NSStringFromClass([topMostViewControllerObj class]);
    NSLog(@"controller=%@",CurrentViewController);
    
    if ([CurrentViewController isEqualToString:@"JMHomeViewController"]||[CurrentViewController isEqualToString:@"JMProfileViewController"])
    {
        // leftmenurowindex=2;
        
        HeaderView.logoImage.hidden=NO;
        HeaderView.menuView.hidden=NO;
        
        HeaderView.RecentUploadImage.hidden=YES;
        HeaderView.BackView.hidden=YES;
        
        [HeaderView.MenuButton addTarget:self action:@selector(menuClicked) forControlEvents:UIControlEventTouchUpInside];
        
 
        
        
        
    }
    else if ([CurrentViewController isEqualToString:@"JMRecentlyUploadedViewController"])
    {
        // leftmenurowindex=2;
        
        HeaderView.logoImage.hidden=YES;
        HeaderView.menuView.hidden=YES;
        
        HeaderView.RecentUploadImage.hidden=NO;
        HeaderView.BackView.hidden=NO;
        
        [HeaderView.BackButton addTarget:self action:@selector(BackClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else if ([CurrentViewController isEqualToString:@"JMJokesCategoryVideoListViewController"] || [CurrentViewController isEqualToString:@"JMFavouriteViewController"])
    {
        // leftmenurowindex=2;
        
        HeaderView.logoImage.hidden=YES;
        HeaderView.menuView.hidden=YES;
        
        HeaderView.RecentUploadImage.hidden=NO;
        HeaderView.BackView.hidden=NO;
        
        [HeaderView.BackButton addTarget:self action:@selector(BackClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
}

//-(void)readAfterPush
//{
//
//
//
//    if([self networkAvailable])
//    {
//
//
//
//        [SVProgressHUD showWithStatus:@"Please Wait"];
//
//
//        //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        //
//
//        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@badgecountminus_control",GLOBALAPI]];
//
//
//
//
//        // configure the request
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        [request setHTTPMethod:@"POST"];
//
//
//
//        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//
//        NSString *sendData = @"authtoken=";
//        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.authToken]];
//
//
//        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//        NSMutableData *theBodyData = [NSMutableData data];
//
//        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//
//
//        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
//
//        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//
//        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"error = %@", error);
//
//                return;
//            }
//
//            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                NSError *jsonError;
//                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//
//
//
//
//
//                if (jsonError) {
//                    // Error Parsing JSON
//
//                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                    NSLog(@"response = %@",responseString);
//
//                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
//
//                } else {
//                    // Success Parsing JSON
//                    // Log NSDictionary response:
//                    NSLog(@"result = %@",response);
//
//                    if ([[response objectForKey:@"status_code"]intValue]==406) {
//
//                        app.userId=@"";
//
//                        app.authToken=@"";
//
//                        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//
//
//
//                        ADLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADLogin"];
//                        VC.forcedToLogin=true;
//                        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//                    }
//                    else
//
//                        if ([[response objectForKey:@"status_code"]intValue]==200) {
//
//                            [SVProgressHUD dismiss];
//
//                            app.badgeCount=[[response objectForKey:@"batchcount"]intValue];
//
//                            if (app.badgeCount>0) {
//
//                                [badgeLbl setHidden:NO];
//                                [badgeLbl setText:[NSString stringWithFormat:@"%d", app.badgeCount]];
//
//
//                            }
//                            else{
//                                [badgeLbl setHidden:YES];
//                            }
//
//
//
//                        }
//
//                        else{
//
//
//                        }
//
//
//
//
//                }
//
//
//            }
//
//
//        }];
//
//
//        [task resume];
//
//
//    }
//
//    else{
//
//
//        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//
//
//
//    }
//
//
//}

-(void)appendAfterPush
{
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    
    NSString *class=[NSString stringWithFormat:@"%@",[self.navigationController.visibleViewController class]];
    
    if ([class isEqualToString:@"ADChatViewController"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chatReceived" object:nil];
        
        
    }
    else
    {
        
        
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pushReceived" object:nil];
        
        
        
        
        
        
    }
    
}

//-(void)addPushView:(UIView *)mainView
//{
//    [pushView removeFromSuperview];
//
//    pushView= [[[NSBundle mainBundle] loadNibNamed:@"extendedView" owner:self options:nil] objectAtIndex:3];
//
//
//    [ pushView setFrame:CGRectMake(0, -70.0/480.0*FULLHEIGHT, FULLWIDTH,70.0/480.0*FULLHEIGHT)];
//
//
//
//    pushTitle=(UILabel *)[pushView viewWithTag:1];
//    [pushTitle setFont:[UIFont fontWithName:pushTitle.font.fontName size:[self getFontSize:pushTitle.font.pointSize]]];
//
//    pushDesc=(UILabel *)[pushView viewWithTag:2];
//    [pushDesc setFont:[UIFont fontWithName:pushDesc.font.fontName size:[self getFontSize:pushDesc.font.pointSize]]];
//
//    pushBtn=(UIButton *)[pushView viewWithTag:3];
//    [pushBtn addTarget:self action:@selector(pushClicked) forControlEvents:UIControlEventTouchUpInside];
//
//    pushInnerView=(UIView *)[pushView viewWithTag:4];
//    [self setRoundCornertoView:pushInnerView withBorderColor:[UIColor blackColor] WithRadius:0.05];
//
//    [pushTitle setText:[app.pushDict objectForKey:@"sendername"]];
//    [pushDesc setText:[app.pushDict objectForKey:@"alert"]];
//
//    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [pushView addGestureRecognizer:recognizer];
//
//    UISwipeGestureRecognizer * recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
//    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [pushView addGestureRecognizer:recognizer2];
//
//
//    [mainView addSubview:pushView];
//
//
//
//
//
//
//    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        [ pushView setFrame:CGRectMake(0, 0, FULLWIDTH,70.0/480.0*FULLHEIGHT)];
//    } completion:^(BOOL finished) {
//
//
//    }];
//
//
//    [self performSelector:@selector(hidePush) withObject:nil afterDelay:4];
//
//
//
//
//}

-(void)swipeLeft
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [ pushView setFrame:CGRectMake(-FULLWIDTH, 0, FULLWIDTH,70.0/480.0*FULLHEIGHT)];
    } completion:^(BOOL finished) {
        
        
        [pushView removeFromSuperview];
        
        [self checkPushCount];
    }];
}
-(void)swipeRight
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [ pushView setFrame:CGRectMake(FULLWIDTH, 0, FULLWIDTH,70.0/480.0*FULLHEIGHT)];
    } completion:^(BOOL finished) {
        
        
        [pushView removeFromSuperview];
        [self checkPushCount];
    }];
}
-(void)hidePush
{
    
    CGRect cRect=pushView.frame;
    
    if (cRect.origin.x==0) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [ pushView setFrame:CGRectMake(0, -70.0/480.0*FULLHEIGHT, FULLWIDTH,70.0/480.0*FULLHEIGHT)];
        } completion:^(BOOL finished) {
            
            
            
            [pushView removeFromSuperview];
            [self checkPushCount];
            
        }];
    }
}




//-(void)pushClicked
//{
//
//    [pushView removeFromSuperview];
//    //  app.badgeCount--;
//
//
//    if([self networkAvailable])
//    {
//
//
//
//        [SVProgressHUD showWithStatus:@"Please Wait"];
//
//
//        //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        //
//
//        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@badgecountminus_control",GLOBALAPI]];
//
//
//
//
//        // configure the request
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        [request setHTTPMethod:@"POST"];
//
//
//
//        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//
//        NSString *sendData = @"authtoken=";
//        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.authToken]];
//
//
//        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//        NSMutableData *theBodyData = [NSMutableData data];
//
//        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//
//
//        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
//
//        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//
//        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"error = %@", error);
//
//                return;
//            }
//
//            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                NSError *jsonError;
//                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//
//
//
//
//
//                if (jsonError) {
//                    // Error Parsing JSON
//
//                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                    NSLog(@"response = %@",responseString);
//
//                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
//
//                } else {
//                    // Success Parsing JSON
//                    // Log NSDictionary response:
//                    NSLog(@"result = %@",response);
//
//                    if ([[response objectForKey:@"status_code"]intValue]==406) {
//
//                        app.userId=@"";
//
//                        app.authToken=@"";
//
//                        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//
//
//
//                        ADLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADLogin"];
//                        VC.forcedToLogin=true;
//                        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//                    }
//                    else
//
//                        if ([[response objectForKey:@"status_code"]intValue]==200) {
//
//                            [SVProgressHUD dismiss];
//
//                            app.badgeCount=[[response objectForKey:@"batchcount"]intValue];
//
//                            if (app.badgeCount>0) {
//
//                                [badgeLbl setHidden:NO];
//                                [badgeLbl setText:[NSString stringWithFormat:@"%d", app.badgeCount]];
//
//
//                            }
//                            else{
//                                [badgeLbl setHidden:YES];
//                            }
//
//                            if ( [[app.pushDict objectForKey:@"type"]intValue]==3) {
//
//                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                                                     bundle: nil];
//
//                                ADChatViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"ADChat"];
//                                VC.userId=[app.pushDict objectForKey:@"senderid"];
//                                VC.userName=[[app.pushDict objectForKey:@"sendername"] capitalizedString];
//                                //  VC.userImage=[pushDict objectForKey:@"profile_image"];
//
//                                [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//
//                            }
//
//                            else if ([[app.pushDict objectForKey:@"type"]intValue]==2) {
//
//
//                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                                                     bundle: nil];
//
//                                ADUserProfileViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"ADProfile"];
//                                VC.profileId=[app.pushDict objectForKey:@"senderid"];
//                                //  VC.userImage=[pushDict objectForKey:@"profile_image"];
//                                VC.isFromList=true;
//                                [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//
//                            }   else
//                            {
//                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
//                                                                                     bundle: nil];
//
//                                ADEventDetailViewController *VC=[storyboard instantiateViewControllerWithIdentifier:@"ADEventDetail"];
//                                VC.eventId=[app.pushDict objectForKey:@"eventid"];
//                                //  VC.userImage=[pushDict objectForKey:@"profile_image"];
//
//                                [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//
//
//                            }
//
//
//                        }
//
//                        else{
//
//
//                        }
//
//
//
//
//                }
//
//
//            }
//
//
//        }];
//
//
//        [task resume];
//
//
//    }
//
//    else{
//
//
//        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//
//
//
//    }
//
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    //    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    //    [self.view addGestureRecognizer:recognizer];
    //
    //    UISwipeGestureRecognizer * recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    //    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    //    [self.view addGestureRecognizer:recognizer2];
    //
    
    myQueue=[[NSOperationQueue alloc]init];
    
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self
    //selector:@selector(handleNotification:)
    //    name:SVProgressHUDWillAppearNotification
    //  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self
    //selector:@selector(handleNotification:)
    //   name:SVProgressHUDWillDisappearNotification
    //  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    
    
    
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:1.0/255.0 green:1.0/255.0 blue:1.0/255.0  alpha:0.5]];
    
    
    //
    //    for (NSString* family in [UIFont familyNames])
    //    {
    //        NSLog(@"%@", family);
    //
    //        for (NSString* name in [UIFont fontNamesForFamilyName: family])
    //        {
    //            NSLog(@"  %@", name);
    //        }
    //    }
    
    // NSString *ipAdd=self.getIPAddress;
    
    //DebugLog(@" IP is :%@",self.getIPAddress);
    
    //  SWRevealViewController *revealViewController = self.revealViewController;
    //  if ( revealViewController )
    //  {
    // [self.sidebarButton setTarget: self.revealViewController];
    //  [self.sidebarButton setAction: @selector( revealToggle: )];
    //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // }
    // Do any additional setup after loading the view.
    
    
    
    
    
    
}

- (void)handleNotification:(NSNotification *)notification {
    //  NSLog(@"Notification recieved: %@", notification.name);
    
    if ([notification.name isEqualToString:@"SVProgressHUDDidAppearNotification"]) {
        loading=true;
        
    }
    else if ([notification.name isEqualToString:@"SVProgressHUDDidDisappearNotification"])
    {
        loading=false;
    }
    
    //NSLog(@"Status user info key: %@", notification.userInfo[SVProgressHUDStatusUserInfoKey]);
}



-(void)addSearchBar:(UIView *)mainView
{
    
    
    
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        
        [headerView removeFromSuperview];
        
        
        if (IDIOM==IPAD)
        {
            
            
            
        }
        else
        {
            headerView= [[[NSBundle mainBundle] loadNibNamed:@"extendedDesigns" owner:self options:nil] objectAtIndex:3];
        }
        
        [ headerView setFrame:CGRectMake(0, 10.0/480.0*self.view.frame.size.height, FULLWIDTH, mainView.frame.size.height-10.0/480.0*self.view.frame.size.height)];
        
        [mainView setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:203.0/255.0 alpha:1]];
        
        [mainView addSubview:headerView];
        
    } completion:^(BOOL finished){ }];
    
    
}

-(void)addHeader:(UIView *)mainView
{
    
    [headerView removeFromSuperview];
    
    
    
    headerView= [[[NSBundle mainBundle] loadNibNamed:@"JMHeaderView" owner:self options:nil] objectAtIndex:0];
    
    
    [ headerView setFrame:CGRectMake(0, 0, FULLWIDTH, mainView.frame.size.height)];
    
    
    
    headerLbl=(UILabel *)[headerView viewWithTag:10];
    [headerLbl setFont:[UIFont fontWithName:headerLbl.font.fontName size:[self getFontSize:headerLbl.font.pointSize]]];
    
    _backView=(UIView *)[headerView viewWithTag:4];
    _backImg=(UIImageView *)[headerView viewWithTag:14];
    _backBtn =(UIButton *)[headerView viewWithTag:24];
    
    profileView=(UIView *)[headerView viewWithTag:1];
    _profileImg=(UIImageView *)[headerView viewWithTag:11];
    profileBtn = (UIButton *)[headerView viewWithTag:21];
    
    chatView=(UIView *)[headerView viewWithTag:2];
    _chatImg=(UIImageView *)[headerView viewWithTag:12];
    chatBtn = (UIButton *)[headerView viewWithTag:22];
    
    notifyView=(UIView *)[headerView viewWithTag:3];
    _notifyImg=(UIImageView *)[headerView viewWithTag:13];
    notifyBtn = (UIButton *)[headerView viewWithTag:23];
    badgeLbl =(UILabel *)[headerView viewWithTag:999];
    
    _doneView=(UIView *)[headerView viewWithTag:6];
    _doneLbl=(UILabel *)[headerView viewWithTag:16];
    _doneBtn = (UIButton *)[headerView viewWithTag:26];
    
    _saveView=(UIView *)[headerView viewWithTag:7];
    _saveLbl=(UILabel *)[headerView viewWithTag:17];
    _saveBtn = (UIButton *)[headerView viewWithTag:27];
    
    _cancelview=(UIView *)[headerView viewWithTag:5];
    _cancelLbl=(UILabel *)[headerView viewWithTag:15];
    _cancelBtn = (UIButton *)[headerView viewWithTag:25];
    
    _writeView=(UIView *)[headerView viewWithTag:9];
    _writeImg=(UIImageView *)[headerView viewWithTag:19];
    _writeBtn = (UIButton *)[headerView viewWithTag:29];
    
    _moreView=(UIView *)[headerView viewWithTag:8];
    _moreImg=(UIImageView *)[headerView viewWithTag:18];
    _moreBtn = (UIButton *)[headerView viewWithTag:28];
    
    
    _editview=(UIView *)[headerView viewWithTag:101];
    _editLbl=(UILabel *)[headerView viewWithTag:102];
    _editBtn = (UIButton *)[headerView viewWithTag:103];
    
    _userView=(UIView *)[headerView viewWithTag:201];
    _userImg=(UIImageView *)[headerView viewWithTag:202];
    _userBttn = (UIButton *)[headerView viewWithTag:203];
    
    _trashView=(UIView *)[headerView viewWithTag:301];
    _trashImg=(UIImageView *)[headerView viewWithTag:302];
    _trashBtn = (UIButton *)[headerView viewWithTag:303];
    
    [self setRoundCornertoView:badgeLbl withBorderColor:[UIColor clearColor] WithRadius:0.5];
    
    //    if (app.badgeCount==0) {
    [badgeLbl setHidden:YES];
    //    }
    //    else
    //    {
    //        [badgeLbl setHidden:NO];
    //
    //    }
    
    [_doneLbl setFont:[UIFont fontWithName:_doneLbl.font.fontName size:[self getFontSize:_doneLbl.font.pointSize]]];
    
    [_cancelLbl setFont:[UIFont fontWithName:_cancelLbl.font.fontName size:[self getFontSize:_cancelLbl.font.pointSize]]];
    
    [_saveLbl setFont:[UIFont fontWithName:_saveLbl.font.fontName size:[self getFontSize:_saveLbl.font.pointSize]]];
    
    [_editLbl setFont:[UIFont fontWithName:_editLbl.font.fontName size:[self getFontSize:_editLbl.font.pointSize]]];
    
    
    //  [_profileImg setFrame:CGRectMake(_profileImg.frame.origin.x, _profileImg.frame.origin.y, _profileImg.frame.size.width/320.0*FULLWIDTH, _profileImg.frame.size.height/480.0*FULLHEIGHT)];
    
    // [_chatImg setFrame:CGRectMake(_chatImg.frame.origin.x, _chatImg.frame.origin.y, _chatImg.frame.size.width/320.0*FULLWIDTH, _chatImg.frame.size.height/480.0*FULLHEIGHT)];
    
    //  [_notifyImg setFrame:CGRectMake(_notifyImg.frame.origin.x, _notifyImg.frame.origin.y, _notifyImg.frame.size.width/320.0*FULLWIDTH, _notifyImg.frame.size.height/480.0*FULLHEIGHT)];
    
    
    NSString *class=[NSString stringWithFormat:@"%@",[self.navigationController.visibleViewController class]];
    
    if ([class isEqualToString:@"ADHomeViewController"]) {
        
        [headerLbl setText:@"HOME"];
        
        
        [_backView setHidden:YES];
        
        [profileView setHidden:NO];
        [notifyView setHidden:NO];
        [chatView setHidden:NO];
    }
    
    else if ([class isEqualToString:@"ADUserProfileViewController"]) {
        
        [headerLbl setText:@"PROFILE"];
        
        
        [_backView setHidden:NO];
        // [_moreView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        
        [chatView setHidden:YES];
    }
    
    else if ([class isEqualToString:@"ADUserListViewController"]) {
        
        [headerLbl setText:@"USERS"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
    }
    else if ([class isEqualToString:@"ADChatViewController"]) {
        
        [headerLbl setText:@"CHAT"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
    }
    else if ([class isEqualToString:@"ADFollowViewController"]) {
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
    }
    
    else if ([class isEqualToString:@"ADFeaturedViewController"] ) {
        
        [headerLbl setText:@"FEATURED"];
        
        
        [_backView setHidden:YES];
        
        [profileView setHidden:YES];
        [notifyView setHidden:NO];
        [chatView setHidden:YES];
        
        CGRect chatRect = chatView.frame;
        
        
        [notifyView setFrame:chatRect];
        
    } else if ([class isEqualToString:@"ADNotificationViewController"]) {
        
        [headerLbl setText:@"NOTIFICATION"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
        
        
        
    }
    else  if ([class isEqualToString:@"ADCreateEventViewController"] ) {
        [headerLbl setText:@"ADIT"];
        
        
        [_backView setHidden:YES];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
        
        [_doneView setHidden:NO];
        [_cancelview setHidden:NO];
        
        
    }
    else  if ([class isEqualToString:@"ADDetailsViewController"] ) {
        [headerLbl setText:@"EVENT DETAILS"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
        
    }
    
    else if ([class isEqualToString:@"ADSearchViewController"]) {
        
        [headerLbl setText:@"SEARCH"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:NO];
        [chatView setHidden:YES];
        
        CGRect chatRect = chatView.frame;
        
        
        [notifyView setFrame:chatRect];
        
    }
    else if ([class isEqualToString:@"ADSettingsViewController"]) {
        
        [headerLbl setText:@"SETTINGS"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
        [_saveView setHidden:NO];
        
        
        
    }
    else if ([class isEqualToString:@"ADMessageListViewController"]) {
        
        [headerLbl setText:@"MESSAGES"];
        
        
        [_backView setHidden:NO];
        
        //       CGRect backRect = _backView.frame;
        //
        //
        //       [chatView setFrame:backRect];
        //
        
        [profileView setHidden:YES];
        [notifyView setHidden:NO];
        [chatView setHidden:YES];
        [_writeView setHidden:NO];
        
        
        
    }
    else if ([class isEqualToString:@"ADEventsViewController"]) {
        
        [headerLbl setText:@"EVENTS"];
        
        
        [_backView setHidden:YES];
        
        [profileView setHidden:YES];
        [notifyView setHidden:NO];
        [chatView setHidden:YES];
        
        [_cancelview setHidden:YES];
        [_doneView setHidden:YES];
        
        CGRect chatRect = chatView.frame;
        
        
        [notifyView setFrame:chatRect];
        
    }
    else if ([class isEqualToString:@"ADEventDetailViewController"]) {
        
        [headerLbl setText:@"EVENT DETAILS"];
        
        
        [_backView setHidden:NO];
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
        
        [_cancelview setHidden:YES];
        [_doneView setHidden:YES];
        
        //       CGRect chatRect = chatView.frame;
        //
        //
        //       [notifyView setFrame:chatRect];
        
    }
    else{
        
        [profileView setHidden:YES];
        [notifyView setHidden:YES];
        [chatView setHidden:YES];
        
        [_backView setHidden:NO];
        
        if ([class isEqualToString:@"ADSignupViewController"]) {
            
            [headerLbl setText:@"Fill the details"];
        }
        else  if ([class isEqualToString:@"ADRegisterViewController"]) {
            
            [headerLbl setText:@"Sign Up"];
        }
    }
    
    
    if ([class isEqualToString:@"ADFeaturedViewController"]|| [class isEqualToString:@"ADHomeViewController"] || [class isEqualToString:@"ADSearchViewController"] ||  [class isEqualToString:@"ADMessageListViewController"]  ||  [class isEqualToString:@"ADEventsViewController"]) {
        
        [self checkPushCount];
        
        
        
    }
    
    
    [mainView addSubview:headerView];
    
    [profileBtn addTarget:self action:@selector(profileClicked) forControlEvents:UIControlEventTouchUpInside];
    [notifyBtn addTarget:self action:@selector(notifyClicked) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn addTarget:self action:@selector(chatClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_backBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [_writeBtn addTarget:self action:@selector(writeClicked) forControlEvents:UIControlEventTouchUpInside];
}


//-(void)checkPushCount
//{
//
//    badgeLbl =(UILabel *)[headerView viewWithTag:999];
//
//    if([self networkAvailable])
//    {
//
//
//
//        //  [SVProgressHUD show];
//
//
//        //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        //
//
//        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@batchcount_control",GLOBALAPI]];
//
//
//
//
//        // configure the request
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        [request setHTTPMethod:@"POST"];
//
//
//
//        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//
//        NSString *sendData = @"authtoken=";
//        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.authToken]];
//
//
//        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//        NSMutableData *theBodyData = [NSMutableData data];
//
//        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//
//
//        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
//
//        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//
//        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"error = %@", error);
//
//                return;
//            }
//
//            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                NSError *jsonError;
//                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//
//
//
//
//
//                if (jsonError) {
//                    // Error Parsing JSON
//
//                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                    NSLog(@"response = %@",responseString);
//
//                    //  [SVProgressHUD showInfoWithStatus:@"some error occured"];
//
//                } else {
//                    // Success Parsing JSON
//                    // Log NSDictionary response:
//                    NSLog(@"result = %@",response);
//
//                    if ([[response objectForKey:@"status_code"]intValue]==406) {
//
//                        app.userId=@"";
//
//                        app.authToken=@"";
//
//                        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//
//
//
//                        ADLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADLogin"];
//                        VC.forcedToLogin=true;
//                        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//                    }
//                    else
//
//                        if ([[response objectForKey:@"status_code"]intValue]==200) {
//
//                            // [SVProgressHUD dismiss];
//
//                            app.badgeCount=[[response objectForKey:@"batchcount"]intValue];
//
//                            if (app.badgeCount>0) {
//
//                                [badgeLbl setHidden:NO];
//                                [badgeLbl setText:[NSString stringWithFormat:@"%d", app.badgeCount]];
//
//
//                            }
//                            else{
//                                [badgeLbl setHidden:YES];
//                            }
//
//
//                        }
//
//                        else{
//
//
//                        }
//
//
//
//
//                }
//
//
//            }
//
//
//        }];
//
//
//        [task resume];
//
//
//    }
//
//    else{
//
//
//        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//
//
//
//    }
//
//}

//-(void)writeClicked
//{
//
//    ADUserListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADUser"];
//
//
//
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//}
//
//
//-(void)profileClicked
//{
//
//    ADUserProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADProfile"];
//
//    VC.isFromProfile=true;
//
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//
//}
//
//-(void)notifyClicked
//{
//    ADNotificationViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADNotification"];
//
//
//
//    if([self networkAvailable])
//    {
//
//
//
//        [SVProgressHUD showWithStatus:@"Please Wait"];
//
//
//        //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        //
//
//        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@batchcountclear_control",GLOBALAPI]];
//
//
//
//
//        // configure the request
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        [request setHTTPMethod:@"POST"];
//
//
//
//        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//
//        NSString *sendData = @"authtoken=";
//        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.authToken]];
//
//
//        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//        NSMutableData *theBodyData = [NSMutableData data];
//
//        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//
//
//        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
//
//        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//
//        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (error) {
//                NSLog(@"error = %@", error);
//
//                return;
//            }
//
//            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                NSError *jsonError;
//                NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//
//
//
//
//
//
//                if (jsonError) {
//                    // Error Parsing JSON
//
//                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                    NSLog(@"response = %@",responseString);
//
//                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
//
//                } else {
//                    // Success Parsing JSON
//                    // Log NSDictionary response:
//                    NSLog(@"result = %@",response);
//
//                    if ([[response objectForKey:@"status_code"]intValue]==406) {
//
//                        app.userId=@"";
//
//                        app.authToken=@"";
//
//                        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//                        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//
//
//
//                        ADLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADLogin"];
//                        VC.forcedToLogin=true;
//                        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//                    }
//                    else
//
//                        if ([[response objectForKey:@"status_code"]intValue]==200) {
//
//                            [SVProgressHUD dismiss];
//
//                            app.badgeCount=[[response objectForKey:@"batchcount"]intValue];
//
//                        }
//
//                        else{
//
//
//                        }
//
//
//
//
//                }
//
//
//            }
//
//
//        }];
//
//
//        [task resume];
//
//
//    }
//
//    else{
//
//
//        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//
//
//
//    }
//
//
//
//
//
//    [badgeLbl setHidden:YES];
//
//
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//}

//-(void)chatClicked
//{
//
//    ADMessageListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADmessageList"];
//
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//}

-(void)addRefreshView:(UIView *)mainView
{
    
    refreshView= [[[NSBundle mainBundle] loadNibNamed:@"extendedView" owner:self options:nil] objectAtIndex:2];
    
    [ refreshView setFrame:CGRectMake(0,0, 200.0/320.0*FULLWIDTH, 200.0/480.0*FULLHEIGHT)];
    
    _nodataLbl= (UILabel *)[refreshView viewWithTag:2];
    _refreshBtn = (UIButton *)[refreshView viewWithTag:1];
    _refreshImg = (UIImageView *)[refreshView viewWithTag:33];
    
    [_nodataLbl setFont:[UIFont fontWithName:_nodataLbl.font.fontName size:[self getFontSize:_nodataLbl.font.pointSize]]];
    
    
    
    [mainView addSubview:refreshView];
    
    
    
}

-(void)addFooter:(UIView *)mainView
{
    
    footerView= [[[NSBundle mainBundle] loadNibNamed:@"extendedView" owner:self options:nil] objectAtIndex:1];
    
    [ footerView setFrame:CGRectMake(0, 0, FULLWIDTH, mainView.frame.size.height)];
    
    
    _homeView = (UIView *)[footerView viewWithTag:111];
    _homeBtn = (UIButton *)[footerView viewWithTag:1];
    _homeImg=(UIImageView *)[footerView viewWithTag:11];
    
    _eventView = (UIView *)[footerView viewWithTag:222];
    _eventBtn = (UIButton *)[footerView viewWithTag:2];
    _eventImg=(UIImageView *)[footerView viewWithTag:22];
    
    _locationview = (UIView *)[footerView viewWithTag:333];
    _locationBtn = (UIButton *)[footerView viewWithTag:3];
    _locationImg=(UIImageView *)[footerView viewWithTag:33];
    
    _trophyView = (UIView *)[footerView viewWithTag:444];
    _trophyBtn = (UIButton *)[footerView viewWithTag:4];
    _trophyImg=(UIImageView *)[footerView viewWithTag:44];
    
    _searchView = (UIView *)[footerView viewWithTag:555];
    _searchBtn = (UIButton *)[footerView viewWithTag:5];
    _searchImg=(UIImageView *)[footerView viewWithTag:55];
    
    
    
    [_homeBtn addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_eventBtn addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_trophyBtn addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_searchBtn addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [mainView addSubview:footerView];
    
    
    
    
    
    NSString *class=[NSString stringWithFormat:@"%@",[self.navigationController.visibleViewController class]];
    
    if ([class isEqualToString:@"ADHomeViewController"] || [class isEqualToString:@"ADUserProfileViewController"]) {
        
        
        [_homeView setBackgroundColor:[UIColor whiteColor]];
        
        [_homeImg setImage:[UIImage imageNamed:@"homeIcon1"]];
        
        
        
    }
    else  if ([class isEqualToString:@"ADFeaturedViewController"] ) {
        
        
        [_trophyView setBackgroundColor:[UIColor whiteColor]];
        
        [_trophyImg setImage:[UIImage imageNamed:@"trophy1"]];
        
        
        
    }
    else  if ([class isEqualToString:@"ADEventsViewController"] ) {
        
        
        [_eventView setBackgroundColor:[UIColor whiteColor]];
        
        [_eventImg setImage:[UIImage imageNamed:@"eventIcon1"]];
        
        
        
    }
    else  if ([class isEqualToString:@"ADCreateEventViewController"] ) {
        
        
        [_locationview setBackgroundColor:[UIColor whiteColor]];
        
        [_locationImg setImage:[UIImage imageNamed:@"location1"]];
        
        
        
    }
    else  if ([class isEqualToString:@"ADSearchViewController"] ) {
        [_searchView setBackgroundColor:[UIColor whiteColor]];
        
        [_searchImg setImage:[UIImage imageNamed:@"search1"]];
        
    }
    else  if ([class isEqualToString:@"ADSettingsViewController"] ) {
        [_moreView setBackgroundColor:[UIColor whiteColor]];
        
        [_moreImg setImage:[UIImage imageNamed:@"more_fill"]];
        
    }
    
}

- (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)initFooterView
{
    footerLoadView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0/320.0*self.view.frame.size.width, 45.0/480.0*self.view.frame.size.height)];
    
    footerReloadView= [[[NSBundle mainBundle] loadNibNamed:@"extendedDesigns" owner:self options:nil] objectAtIndex:2];
    
    [footerReloadView setFrame:CGRectMake(0.0, 0.0, 320.0/320.0*self.view.frame.size.width, 45.0/480.0*self.view.frame.size.height)];
    
    UIImageView *loaderImg = (UIImageView *)[footerReloadView viewWithTag:50];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1.0 * 1.0 ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [loaderImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    
    
    
    [footerLoadView addSubview:footerReloadView];
    
    [footerLoadView setHidden:NO];
    
    
}

- (BOOL) checkforNumeric:(NSString*) numericstr
{
    NSString *strMatchnumeric=@"\\b([0-9%_.+\\-]+)\\b";
    NSPredicate *numerictest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchnumeric];
    if(![numerictest evaluateWithObject:numericstr])
    {
        return FALSE;
    }
    return TRUE;
}

//-(void)searchClicked
//{
//
//
//    //    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//    //        // iOS 7
//    //        [self prefersStatusBarHidden];
//    //        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    //    } else {
//    //        // iOS 6
//    //        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//    //    }
//    //
//
//
//    [self addSearchBar:[headerView superview]];
//
//
//    searchBar=(UISearchBar *)[[headerView superview] viewWithTag:50];
//
//    [searchBar setDelegate:self];
//
//
//    NSString *class=[NSString stringWithFormat:@"%@",[self.navigationController.visibleViewController class]];
//
//    if ([class isEqualToString:@"EIHomeViewController"]) {
//
//        [searchBar setPlaceholder:@"Search by Name or post text"];
//
//
//    }
//    else   if ([class isEqualToString:@"EIPeopleViewController"]) {
//
//        [searchBar setPlaceholder:@"Search by name"];
//    }
//
//    searchBar.showsCancelButton=YES;
//    [[UITextField appearanceWhenContainedIn:[searchBar class], nil] setDefaultTextAttributes:@{
//                                                                                               NSFontAttributeName: [UIFont fontWithName:RobotoMedium size:[self getFontSize:13.0]], }];
//
//    [searchBar becomeFirstResponder];
//
//
//}
-(void)addClicked
{
    
    UIViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"EIAddPost"];
    
    
    
    [self presentViewController:VC animated:YES completion:nil];
    
    // [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    
}







//- (void)tabClicked:(UIButton *)btn
//{
//
//    //    [_homeView setBackgroundColor:THEMECOLOUR];
//    //
//    //    [_homeImg setImage:[UIImage imageNamed:@"homeIcon"]];
//    //
//    //
//    //
//    //
//    //    [_eventView setBackgroundColor:THEMECOLOUR];
//    //
//    //    [_eventImg setImage:[UIImage imageNamed:@"eventIcon"]];
//    //
//    //    [_locationview setBackgroundColor:THEMECOLOUR];
//    //
//    //    [_locationImg setImage:[UIImage imageNamed:@"location"]];
//    //
//    //    [_trophyView setBackgroundColor:THEMECOLOUR];
//    //
//    //    [_trophyImg setImage:[UIImage imageNamed:@"trophy"]];
//    //
//    //
//    //    [_searchView setBackgroundColor:THEMECOLOUR];
//    //
//    //    [_searchImg setImage:[UIImage imageNamed:@"search"]];
//    //
//
//
//
//
//
//    NSString *class=[NSString stringWithFormat:@"%@",[self.navigationController.visibleViewController class]];
//
//
//
//
//    if (btn.tag==1) {
//
//
//
//        if (![class isEqualToString:@"ADHomeViewController"]) {
//
//
//
//
//            ADHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADHome"];
//            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//        }
//        //          [_homeView setBackgroundColor:[UIColor whiteColor]];
//        //        [_homeImg setImage:[UIImage imageNamed:@"homeIcon1"]];
//
//
//    }
//    else if (btn.tag==2) {
//
//        DebugLog(@"Two clicked");
//        if (![class isEqualToString:@"ADEventsViewController"]) {
//
//            ADEventsViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADEvents"];
//            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//        }
//
//        //         [_eventView setBackgroundColor:[UIColor whiteColor]];
//        //
//        //        [_eventImg setImage:[UIImage imageNamed:@"eventIcon1"]];
//
//
//    }
//    else if (btn.tag==3) {
//
//        if (![class isEqualToString:@"ADCreateEventViewController"]) {
//
//            ADCreateEventViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADCreate"];
//            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//        }
//
//
//        //        [_locationview setBackgroundColor:[UIColor whiteColor]];
//        //
//        //        [_locationImg setImage:[UIImage imageNamed:@"location1"]];
//    }
//    else if (btn.tag==4) {
//
//        DebugLog(@"Four clicked");
//
//        if (![class isEqualToString:@"ADFeaturedViewController"]) {
//
//            ADFeaturedViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADFeatured"];
//            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//        }
//        //
//        //        [_trophyView setBackgroundColor:[UIColor whiteColor]];
//        //
//        //        [_trophyImg setImage:[UIImage imageNamed:@"trophy1"]];
//
//    }
//    else if (btn.tag==5) {
//
//        DebugLog(@"Five clicked");
//
//        if (![class isEqualToString:@"ADSearchViewController"]) {
//
//
//            UIAlertController *alertController = [UIAlertController
//                                                  alertControllerWithTitle:@"What do you want to search?"
//                                                  message:nil
//                                                  preferredStyle:UIAlertControllerStyleActionSheet];
//
//
//
//
//
//
//
//            UIAlertAction *userAction = [UIAlertAction
//                                         actionWithTitle:NSLocalizedString(@"Users", @"OK action")
//                                         style:UIAlertActionStyleDefault
//                                         handler:^(UIAlertAction *action)
//                                         {
//
//
//                                             ADSearchViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADSearch"];
//
//
//                                             [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//
//                                         }];
//
//
//            [alertController addAction:userAction];
//
//            UIAlertAction *eventAction = [UIAlertAction
//                                          actionWithTitle:NSLocalizedString(@"Events", @"OK action")
//                                          style:UIAlertActionStyleDefault
//                                          handler:^(UIAlertAction *action)
//                                          {
//
//
//                                              ADSearchViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADSearch"];
//                                              VC.searchType=1;
//                                              [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//
//                                          }];
//
//
//            [alertController addAction:eventAction];
//
//            UIAlertAction *cancelAction = [UIAlertAction
//                                           actionWithTitle:@"Cancel"
//                                           style:UIAlertActionStyleCancel
//                                           handler:^(UIAlertAction *action)
//                                           {
//                                               DebugLog(@"Cancel action");
//
//
//
//
//                                           }];
//
//            [alertController addAction:cancelAction];
//
//            if (IDIOM==IPAD) {
//
//
//
//
//                UIPopoverPresentationController *popPresenter = [alertController
//                                                                 popoverPresentationController];
//                popPresenter.sourceView = _searchBtn;
//                popPresenter.sourceRect = _searchBtn.bounds;
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//            else{
//                [self presentViewController:alertController animated:YES completion:nil];
//
//            }
//
//
//
//
//
//        }
//
//
//        //        [_searchView setBackgroundColor:[UIColor whiteColor]];
//        //
//        //        [_searchImg setImage:[UIImage imageNamed:@"search1"]];
//    }
//
//    //    else if (btn.tag==6) {
//    //
//    //        DebugLog(@"Six clicked");
//    //
//    //        if (![class isEqualToString:@"ADSettingsViewController"]) {
//    //
//    //            ADSettingsViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADSettings"];
//    //            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//    //        }
//    //
//    //
//    ////        [_moreView setBackgroundColor:[UIColor whiteColor]];
//    ////
//    ////        [_moreImg setImage:[UIImage imageNamed:@"more_fill"]];
//    //    }
//}

//-(void)logOut
//{
//
//    NSLog(@"operation count %lu,",(unsigned long)myQueue.operationCount);
//
//    if ([myQueue operationCount] > 0) {
//        [myQueue cancelAllOperations];
//    }
//
//
//    @try {
//        [self resetCoreData];
//
//
//
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        if (appDelegate.authToken!=nil) {
//
//
//
//            dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//            dispatch_async(q, ^{
//
//
//
//
//                @try {
//
//
//                    NSString *urlString=[NSString stringWithFormat: @"%@app_logout?userid=%@",GLOBALAPI,appDelegate.authToken];
//
//                    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//                    DebugLog(@"push url%@",urlString);
//
//                    NSData *dataurl=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//
//                    if (dataurl!=nil) {
//
//
//                        NSDictionary *jsonDict=[[NSDictionary alloc]init];
//                        jsonDict=[NSJSONSerialization JSONObjectWithData:dataurl options:kNilOptions error:nil];
//
//
//
//
//
//                        // [self checkLoader];
//
//                        if (jsonDict!=nil) {
//
//                            dispatch_async(dispatch_get_main_queue(), ^{
//
//
//                                //             DebugLog(@"json  : %@",[jsonDict objectForKey:@"response"]);
//
//                                if ([[jsonDict objectForKey:@"response"] isEqualToString:@"Success"]) {
//
//
//                                    DebugLog(@"%@",[jsonDict objectForKey:@"message"]);
//
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//
//                                        appDelegate.badgeCount=0;
//                                        appDelegate.userDesignation=nil;
//                                        appDelegate.userDict=nil;
//                                        appDelegate.userEmail=nil;
//                                        appDelegate.authToken=nil;
//                                        appDelegate.userImage=nil;
//                                        appDelegate.userName=nil;
//                                        //appDelegate.userDeviceToken=nil;
//
//
//
//                                        [appDelegate managedObjectContext];
//
//
//                                    });
//
//                                }
//
//                                else
//                                {
//
//
//                                }
//                            });
//
//                        }
//                        else {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//
//                                appDelegate.badgeCount=0;
//                                appDelegate.userDesignation=nil;
//                                appDelegate.userDict=nil;
//                                appDelegate.userEmail=nil;
//                                appDelegate.authToken=nil;
//                                appDelegate.userImage=nil;
//                                appDelegate.userName=nil;
//                                //appDelegate.userDeviceToken=nil;
//
//
//
//                                [appDelegate managedObjectContext];
//
//                            });
//                        }
//
//                    }
//                    else{
//
//                        dispatch_async(dispatch_get_main_queue(), ^{
//
//                            appDelegate.badgeCount=0;
//                            appDelegate.userDesignation=nil;
//                            appDelegate.userDict=nil;
//                            appDelegate.userEmail=nil;
//                            appDelegate.authToken=nil;
//                            appDelegate.userImage=nil;
//                            appDelegate.userName=nil;
//                            // appDelegate.userDeviceToken=nil;
//
//
//
//                            [appDelegate managedObjectContext];
//
//                        });
//                    }
//
//
//                }
//                @catch (NSException *exception) {
//
//                    dispatch_async(dispatch_get_main_queue(), ^{
//
//                        appDelegate.badgeCount=0;
//                        appDelegate.userDesignation=nil;
//                        appDelegate.userDict=nil;
//                        appDelegate.userEmail=nil;
//                        appDelegate.authToken=nil;
//                        appDelegate.userImage=nil;
//                        appDelegate.userName=nil;
//                        //  appDelegate.userDeviceToken=nil;
//
//
//
//                        [appDelegate managedObjectContext];
//
//                    });
//
//
//
//                }
//
//            });
//
//        }
//
//
//
//
//    }
//    @catch (NSException *exception) {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        appDelegate.badgeCount=0;
//        appDelegate.userDesignation=nil;
//        appDelegate.userDict=nil;
//        appDelegate.userEmail=nil;
//        appDelegate.authToken=nil;
//        appDelegate.userImage=nil;
//        appDelegate.userName=nil;
//        // appDelegate.userDeviceToken=nil;
//
//
//
//        [appDelegate managedObjectContext];
//
//    }
//    @finally {
//
//
//
//    }
//
//
//    [[GIDSignIn sharedInstance] signOut];
//
//
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//
//    EILoginWelcomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"EIWelcome"];
//
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//
//}

-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.1f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:AnimationType]];
    [Transition setType:AnimationType];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] pushViewController:viewController animated:NO];
}
-(void)POPViewController
{
    CATransition *Transition=[CATransition animation];
    [Transition setDuration:0.1f];
    [Transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [Transition setType:kCAMediaTimingFunctionEaseOut];
    [[[[self navigationController] view] layer] addAnimation:Transition forKey:nil];
    [[self navigationController] popViewControllerAnimated:NO];
}
-(void)txtPadding:(UITextField *)text
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 30)];
    text.leftView = paddingView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
    
}
-(BOOL)textFieldBlankorNot:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:whitespace];
    
    if (trimmed.length==0) {
        return true;
    }
    return false;
}

-(NSString *)formatDatetime:(NSString *)date
{
    
    NSString *formattedTime;
    
    NSDate *now=[NSDate date];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    
    [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // [formatter2 setTimeZone:[NSTimeZone timeZoneWithName:@"Japan"]];
    
    NSString *nowS=[formatter2 stringFromDate:now];
    
    
    
    NSDate *dateJ = [formatter2 dateFromString:nowS];
    
    // NSLog(@"CURRENT DATE:%@",dateJ);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *Ddate = [formatter dateFromString:[NSString stringWithFormat:@"%@",date]];
    
    //NSLog(@"old DATE:%@ and %@",[[dataDict objectAtIndex:indexPath.row] objectForKey:@"record_date"] ,date);
    
    NSTimeInterval interval = [dateJ timeIntervalSinceDate:Ddate];
    
    int hours = (int)interval / 3600;
    
    // integer division to get the hours part
    
    int days=hours/24;
    
    int minutes = (interval - (hours*3600)) / 60; // interval minus hours part (in seconds) divided by 60 yields minutes
    
    // NSString *timeDiff = [NSString stringWithFormat:@"%d:%d:%02d",days, hours, minutes];
    
    // NSLog(@"%@",timeDiff);
    
    //
    
    if(days>7)
    {
        
        NSDateFormatter *formatter3 = [[NSDateFormatter alloc]init];
        
        [formatter3 setDateFormat:@"dd/MM/yyyy"];
        
        formattedTime=[formatter3 stringFromDate:Ddate ];
        
        
        //    if (days>=365) {
        //
        //        int year = days/365;
        //          if (year==1) {
        //       formattedTime =[NSString stringWithFormat:@"%d Year ago",year];
        //          }
        //          else{
        //            formattedTime =[NSString stringWithFormat:@"%d Years ago",year];
        //          }
        //
        //    }
        //
        //    else if ((days/30)>0) {
        //
        //         int month = days/30;
        //
        //        if (month==1) {
        //   formattedTime=[NSString stringWithFormat:@"%d Month ago",month];
        //        }
        //        else{
        //        formattedTime=[NSString stringWithFormat:@"%d Months ago",month];
        //        }
        //    }
    }
    else
    {
        if(days>0)
            
        {
            if (days>1) {
                
                formattedTime=[NSString stringWithFormat:@"%d Days ago",days];
                
                
            }
            else{ formattedTime=[NSString stringWithFormat:@"Yesterday"];
            }
            
            
        }
        
        else if (hours>0) {
            
            if (hours==1) {
                
                formattedTime=[NSString stringWithFormat:@"%d Hour ago",hours];
            }else{
                formattedTime=[NSString stringWithFormat:@"%d Hours ago",hours];
            }
            
            
        }
        
        else if (minutes>0) {
            
            if (minutes==1) {
                formattedTime=[NSString stringWithFormat:@"%d Minute ago",minutes];
            }
            else{
                formattedTime=[NSString stringWithFormat:@"%d Minutes ago",minutes];
            }
        }
        
        else
            
        {
            
            formattedTime=@"Just Now";
            
        }
        
        
    }
    return formattedTime;
    
}


-(void)showAlertwithTitle:(NSString *)title withMessage:(NSString *)message withAlertType:(UIAlertControllerStyle)alertStyle withOk:(BOOL)isOk withCancel:(bool)isCancel
{
    
    
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:alertStyle];
    
    if (isCancel) {
        
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           DebugLog(@"Cancel action");
                                       }];
        
        
        [alertController addAction:cancelAction];
    }
    
    if (isOk) {
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       DebugLog(@"OK action");
                                   }];
        
        
        [alertController addAction:okAction];
        
    }
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(BOOL)networkAvailable
{
    
    //    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    //
    //    if (networkStatus == NotReachable)
    //    {
    //        //NSLog(@"There IS Please check your Internet connection");
    //
    //        return NO;
    //
    //    }
    //    else
    //    {
    //        return YES;
    //
    //    }
    //
    //    return NO;
    
    
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef address;
    address = SCNetworkReachabilityCreateWithName(NULL, "www.apple.com" );
    Boolean success = SCNetworkReachabilityGetFlags(address, &flags);
    CFRelease(address);
    
    bool canReach = success
    && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (flags & kSCNetworkReachabilityFlagsReachable);
    
    return canReach;
    
}

-(BOOL)validateEmailWithString:(NSString*)email
{
    
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    
    //    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


-(void)showLoaderwithProgress:(float)progress
{
    
    [SVProgressHUD showProgress:progress status:@"Syncing User list"];
    
}

-(void)checkLoader
{
    
    if([SVProgressHUD isVisible])
    {
        
        [SVProgressHUD dismiss];
        
        
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Loading"];
    }
}

-(void)checkLoaderwithProgress:(float)progress
{
    
    DebugLog(@"progress: %f",progress);
    
    if(progress<1)
    {
        
        
        [SVProgressHUD showProgress:progress status:@"Syncing User list"];
        
        
        
    }
    else if(progress>=1)
    {
        [SVProgressHUD dismiss];
    }
    else{
        [SVProgressHUD dismiss];
        
    }
    
}

-(void)autoHide
{
    
    if([SVProgressHUD isVisible] ){
        
        [SVProgressHUD dismiss];
    }
}

- (NSString*)base64forData:(NSData*)theData
{
    
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

-(UIImage *)compressImage:(UIImage *)image{
    
    float actualHeight = image.size.height;
    
    float actualWidth = image.size.width;
    
    float maxHeight = 600.0;
    
    float maxWidth = 800.0;
    
    float imgRatio = actualWidth/actualHeight;
    
    float maxRatio = maxWidth/maxHeight;
    
    float compressionQuality = 0.4;//50 percent compression
    
    
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        
        if(imgRatio < maxRatio){
            
            //adjust width according to maxHeight
            
            imgRatio = maxHeight / actualHeight;
            
            actualWidth = imgRatio * actualWidth;
            
            actualHeight = maxHeight;
            
        }
        
        else if(imgRatio > maxRatio){
            
            //adjust height according to maxWidth
            
            imgRatio = maxWidth / actualWidth;
            
            actualHeight = imgRatio * actualHeight;
            
            actualWidth = maxWidth;
            
        }
        
        else{
            
            actualHeight = maxHeight;
            
            actualWidth = maxWidth;
            
        }
        
    }
    
    
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [image drawInRect:rect];
    
    UIImage *img1 = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(img1, compressionQuality);
    
    UIGraphicsEndImageContext();
    
    
    
    return [UIImage imageWithData:imageData];
    
}


- (CGSize)sizeOfTextView:(UITextView *)textView withText:(NSString *)text {
    
    CGSize maximumLabelSize = CGSizeMake(textView.frame.size.width, 2000);
    CGRect textRect=[text boundingRectWithSize:maximumLabelSize
                                       options:NSStringDrawingUsesFontLeading|NSLineBreakByWordWrapping|NSLineBreakByCharWrapping
                     |NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:textView.font}
                                       context:nil];
    return textRect.size;
}

- (CGSize)sizeOfLabelwithFont:(UIFont *)font withText:(NSString *)text {
    CGSize maximumLabelSize = CGSizeMake(180.0f*(self.view.frame.size.width/320), 999);
    CGRect textRect=[text boundingRectWithSize:maximumLabelSize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    return textRect.size;
    
    
}

-(void)setRoundCornertoView:(UIView *)viewname withBorderColor:(UIColor *)color WithRadius:(CGFloat)radius
{
    
    viewname.layer.cornerRadius=viewname.frame.size.height*radius;
    viewname.layer.borderColor=color.CGColor;
    viewname.layer.borderWidth=0.5;
    [viewname.layer setMasksToBounds:YES];
    
}

-(void)setBorderToView:(UIView *)viewName withColor:(UIColor *)color withBorderWidth:(CGFloat)width
{
    viewName.layer.borderWidth=width;
    viewName.layer.borderColor=color.CGColor;
    [viewName.layer setMasksToBounds:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)getFontSize:(CGFloat)size
{
    
    if (IsIphone5) {
        
        size+=1.0;
    }
    else
        if (IsIphone6) {
            
            size+=3.0;
        }
        else  if (IsIphone6plus) {
            
            size+=4.0;
        }
    
        else if (IsIpad)
        {
            size+=5.0;
        }
    return size;
}

//- (NSString *)getIPAddress {
//
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    // retrieve the current interfaces - returns 0 on success
//    success = getifaddrs(&interfaces);
//
//
//
//    // ifa->ifa_netmask; // subnet mask
//    // ifa->ifa_dstaddr; // broadcast address, NOT router address
//
//
//
//    if (success == 0) {
//        // Loop through linked list of interfaces
//        temp_addr = interfaces;
//        while(temp_addr != NULL) {
//            if(temp_addr->ifa_addr->sa_family == AF_INET) {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//
//                }
//
//            }
//
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    // Free memory
//    freeifaddrs(interfaces);
//
//
//
//
//    return address;
//
//}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.esolz.esolzInternal" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void) resetCoreData
{
    NSManagedObjectContext *managedObjectC = [self managedObjectContext];
    
    [ managedObjectC performBlock:^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"PeopleList" inManagedObjectContext:managedObjectC];
        [fetchRequest setEntity:entity];
        
        NSError *error;
        NSArray *items = [ managedObjectC executeFetchRequest:fetchRequest error:&error];
        
        DebugLog(@"count of data %lu",items.count );
        
        for (NSManagedObject *managedObject in items) {
            [managedObjectC deleteObject:managedObject];
            DebugLog(@"coredata object deleted");
        }
        if (![managedObjectC save:&error]) {
            DebugLog(@"Error deleting coredata - error:%@",error);
        }
    }];
    
    
    //
    //    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"esolzInternal.sqlite"];
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //
    //    [fileManager removeItemAtURL:storeURL error:NULL];
    //
    //    error = nil;
    //
    //    if([fileManager fileExistsAtPath:[NSString stringWithContentsOfURL:storeURL encoding:NSASCIIStringEncoding error:&error]])
    //    {
    //        [fileManager removeItemAtURL:storeURL error:nil];
    //    }
    //
    //
    //
    //    _managedObjectCon=nil;
    //    _persistentStoreCoordinator = nil;
    //
    //    //Make new persistent store for future saves   (Taken From Above Answer)
    //    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    //        // do something with the error
    //    }
    
    //[self checkLoader];
}

-(void)shakeAnimation:(UILabel*) label
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:5];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(label.center.x - 5,label.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(label.center.x + 5, label.center.y)]];
    [label.layer addAnimation:shake forKey:@"position"];
    
    
}

-(NSString*)getPressedWordWithRecognizer:(UIGestureRecognizer*)recognizer
{
    UITextView *textView = (UITextView *)recognizer.view;
    //get location
    CGPoint location = [recognizer locationInView:textView];
    UITextPosition *tapPosition = [textView closestPositionToPoint:location];
    UITextRange *textRange = [textView.tokenizer rangeEnclosingPosition:tapPosition withGranularity:UITextGranularityWord inDirection:UITextLayoutDirectionRight];
    
    return [textView textInRange:textRange];
}
- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}
#pragma - mark menu click
-(void)menuClicked
{
    if(MainView.center.x==self.view.frame.size.width/2)
    {
        
        
        
        [leftmenu removeFromSuperview];
        leftmenu = [JMLeftMenuView leftmenu];
        leftmenu.SideDelegate=self;
        
        //        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:leftmenurowindex inSection:0];
        //        LeftMenuCell * cell = [leftmenu.LeftTable cellForRowAtIndexPath:indexpath];
        //        [[leftmenu.LeftTable cellForRowAtIndexPath:indexpath] setBackgroundColor:UIColorFromRGB(0x636F7C)];
        //
        //        if (leftmenurowindex==0)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"Add Property-1"];
        //        }
        //        if (leftmenurowindex==1)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"wallet-2"];
        //        }
        //        else if (leftmenurowindex==2)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"Explore"];
        //        }
        //        else if (leftmenurowindex==3)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"LocationSelected"];
        //        }
        //        else if (leftmenurowindex==4)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"ConnectSelected"];
        //        }
        //        else if (leftmenurowindex==5)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"New Campaign-1"];
        //        }
        //        else if (leftmenurowindex==6)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"star-1"];
        //        }
        //        else if (leftmenurowindex==7)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"like-2"];
        //        }
        //        else if (leftmenurowindex==8)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"Combined Shape Copy-1"];
        //        }
        //        else if (leftmenurowindex==9)
        //        {
        //            cell.menuImg.image = [UIImage imageNamed:@"Log out-1"];
        //        }
        
        
        
        
        
        leftmenu.frame = CGRectMake(-[[UIScreen mainScreen] bounds].size.width/4*3, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
        
        [self.view addSubview:leftmenu];
        
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            MainView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width+[[UIScreen mainScreen] bounds].size.width/4*1,self.view.center.y);
            
            leftmenu.frame = CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
            
            tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod:)];
            [MainView addGestureRecognizer:tapRecognizer];
            MainView.tag=2;
            
            
            
        } completion:^(BOOL finished) {
            
            
        }];
        
    }
    else
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
            
            leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [leftmenu removeFromSuperview];
            [UIView commitAnimations];
            [MainView removeGestureRecognizer:tapRecognizer];
        }];
        
        
    }
    
}
#pragma - mark tap gesture on view controller when left menu is opened
-(void)gestureHandlerMethod:(UITapGestureRecognizer*)sender
{
    if(sender.view.tag==2)
    {
        if(MainView.center.x==self.view.frame.size.width/2)
        {
            
            
        }
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                
                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
                
                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
                
                
            } completion:^(BOOL finished) {
                
                [leftmenu removeFromSuperview];
                [MainView removeGestureRecognizer:tapRecognizer];
                [UIView commitAnimations];
            }];
            
            
        }
        
    }
}
#pragma - mark current/ top view controller check
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
    } else {
        return rootViewController;
    }
}
#pragma - mark Back click
-(void)BackClicked
{
    
    [self POPViewController];
    
}
#pragma - mark left menu row click action- custom delegate
-(void)action_method:(NSInteger )sender
{
    
        if (sender==3)
        {
            if ([CurrentViewController isEqualToString:@"JMHomeViewController"])
            {
                [UIView animateWithDuration:0.5 animations:^{
    
    
                    MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
    
                    leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
    
    
                } completion:^(BOOL finished) {
    
                    [leftmenu removeFromSuperview];
                    [UIView commitAnimations];
                    [MainView removeGestureRecognizer:tapRecognizer];
                }];
            }
            else
            {
    
                JMGlobalMethods *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//                if (userid.length==0)
//                {
//                    [[NSUserDefaults standardUserDefaults] setObject:@"DLAddPropertyViewController" forKey:@"DestinationPage"];
//                    GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                    [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//                }
//                else
//                {
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AddPropertyDictionary"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//                    GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLAddPropertyViewController"];
//                    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//                }
            }
        }
    if (sender==1)
    {
        if ([CurrentViewController isEqualToString:@"JMFavouriteViewController"])
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                
                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
                
                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
                
                
            } completion:^(BOOL finished) {
                
                [leftmenu removeFromSuperview];
                [UIView commitAnimations];
                [MainView removeGestureRecognizer:tapRecognizer];
            }];
        }
        else
        {
            
            JMGlobalMethods *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMFavouriteViewController"];
            [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
            //                if (userid.length==0)
            //                {
            //                    [[NSUserDefaults standardUserDefaults] setObject:@"DLAddPropertyViewController" forKey:@"DestinationPage"];
            //                    GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
            //                    [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
            //                }
            //                else
            //                {
            //                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AddPropertyDictionary"];
            //                    [[NSUserDefaults standardUserDefaults] synchronize];
            //
            //                    GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLAddPropertyViewController"];
            //                    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
            //                }
        }
    } if (sender==5)
    {
        if ([CurrentViewController isEqualToString:@"JMProfileViewController"])
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                
                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
                
                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
                
                
            } completion:^(BOOL finished) {
                
                [leftmenu removeFromSuperview];
                [UIView commitAnimations];
                [MainView removeGestureRecognizer:tapRecognizer];
            }];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Temp" bundle: nil];
            
            JMGlobalMethods *VC=[storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
            [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
            //                if (userid.length==0)
            //                {
            //                    [[NSUserDefaults standardUserDefaults] setObject:@"DLAddPropertyViewController" forKey:@"DestinationPage"];
            //                    GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
            //                    [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
            //                }
            //                else
            //                {
            //                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AddPropertyDictionary"];
            //                    [[NSUserDefaults standardUserDefaults] synchronize];
            //
            //                    GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLAddPropertyViewController"];
            //                    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
            //                }
        }
    }

        else if (sender==7)
        {
            NSString *deviceToken;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            deviceToken=[prefs valueForKey:@"deviceToken"];
            
            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:deviceToken  forKey:@"deviceToken"];
            
            LocalizationSetLanguage(@"en");
            
            
            JMGlobalMethods *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMLogin"];
            [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
        }
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  //  NSString *userid=[prefs valueForKey:@"UserId"];
    
    //  NSLog(@"##### test mode...%ld",(long)sender.tag);
//    if (sender==0)
//    {
//        if ([CurrentViewController isEqualToString:@"DLAddPropertyViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            
//            if (userid.length==0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"DLAddPropertyViewController" forKey:@"DestinationPage"];
//                GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//            }
//            else
//            {
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AddPropertyDictionary"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                
//                GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLAddPropertyViewController"];
//                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            }
//        }
//    }
//    else if (sender==1)
//    {
//        if ([CurrentViewController isEqualToString:@"DLWalletViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            
//            if (userid.length==0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"DLWalletViewController" forKey:@"DestinationPage"];
//                GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//            }
//            else
//            {
//                GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLWalletViewController"];
//                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            }
//        }
//    }
//    else if (sender==2)
//    {
//        if ([CurrentViewController isEqualToString:@"DLExploreViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLExploreViewController"];
//            [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//        }
//    }
//    else if (sender==3)
//    {
//        if ([CurrentViewController isEqualToString:@"DLNearbyViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLNearbyViewController"];
//            [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            
//        }
//    }
//    else if (sender==4)
//    {
//        if ([CurrentViewController isEqualToString:@"DLAdvanceSearchViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLAdvanceSearchViewController"];
//            [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//        }
//    }
//    else if (sender==6)
//    {
//        if ([CurrentViewController isEqualToString:@"DLMyPropertiesViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            
//            if (userid.length==0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"DLMyPropertiesViewController" forKey:@"DestinationPage"];
//                GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//            }
//            else
//            {
//                GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLMyPropertiesViewController"];
//                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            }
//        }
//    }
//    else if (sender==5)
//    {
//        if ([CurrentViewController isEqualToString:@"DLPostPropertiesViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            
//            if (userid.length==0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"DLPostPropertiesViewController" forKey:@"DestinationPage"];
//                GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//            }
//            else
//            {
//                GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLPostPropertiesViewController"];
//                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            }
//        }
//    }
//    else if (sender==7)
//    {
//        if ([CurrentViewController isEqualToString:@"DLMyFavouritesViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            
//            if (userid.length==0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"DLMyFavouritesViewController" forKey:@"DestinationPage"];
//                GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//            }
//            else
//            {
//                GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLMyFavouritesViewController"];
//                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            }
//        }
//    }
//    
//    else if (sender==100)
//    {
//        if ([CurrentViewController isEqualToString:@"DLProfileViewController"])
//        {
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//                MainView.center = CGPointMake(self.view.center.x,self.view.center.y);
//                
//                leftmenu.frame = CGRectMake(-leftmenu.frame.size.width, 0,[[UIScreen mainScreen] bounds].size.width/4*3, self.view.frame.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                [leftmenu removeFromSuperview];
//                [UIView commitAnimations];
//                [MainView removeGestureRecognizer:tapRecognizer];
//            }];
//        }
//        else
//        {
//            
//            
//            if (userid.length==0)
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:@"DLProfileViewController" forKey:@"DestinationPage"];
//                GlobalViewController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//                [self PushViewController:obj WithAnimation:kCAMediaTimingFunctionEaseIn];
//            }
//            else
//            {
//                GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLProfileViewController"];
//                [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//            }
//        }
//    }
//    else if (sender==9)
//    {
//        NSString *deviceToken;
//        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//        deviceToken=[prefs valueForKey:@"deviceToken"];
//        
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:deviceToken  forKey:@"deviceToken"];
//        
//        LocalizationSetLanguage(@"en");
//        
//        
//        GlobalViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"DLLoginViewController"];
//        [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
//    }
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

