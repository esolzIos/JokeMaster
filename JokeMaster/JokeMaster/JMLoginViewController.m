//
//  JMLoginViewController.m
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMLoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

#import "JMLanguageViewController.h"
@import SafariServices;
@interface JMLoginViewController ()<UITextFieldDelegate,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,GIDSignInDelegate,SFSafariViewControllerDelegate>
{
    FBSDKLoginManager *fbM;
}
@end

@implementation JMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
fbM=[[FBSDKLoginManager alloc]init];
    
    [fbM logOut];
    
    [_userEmail setFont:[UIFont fontWithName:_userEmail.font.fontName size:[self getFontSize:_userEmail.font.pointSize]]];
     [_password setFont:[UIFont fontWithName:_password.font.fontName size:[self getFontSize:_password.font.pointSize]]];
     [_loginBtn.titleLabel setFont:[UIFont fontWithName:_loginBtn.titleLabel.font.fontName size:[self getFontSize:_loginBtn.titleLabel.font.pointSize]]];
     [_infoTxt setFont:[UIFont fontWithName:_infoTxt.font.fontName size:[self getFontSize:_infoTxt.font.pointSize]]];
    
    _userEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Email", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    _password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Password", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    
    [_loginBtn setTitle:AMLocalizedString(@"LOG IN", nil) forState:UIControlStateNormal];
    
    [_infoTxt setText:AMLocalizedString(@"or login with", nil)];
    

//    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    [style setAlignment:NSTextAlignmentCenter];
//    [style setLineBreakMode:NSLineBreakByWordWrapping];
//    
//UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
//    NSDictionary *dict1 =@{NSFontAttributeName :font1,NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:style}; // Added line
//    
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Don't have an account? Sign up" attributes:dict1];
//    [_signupBtn setAttributedTitle:attributedText forState:UIControlStateNormal];
//    [[_signupBtn titleLabel] setNumberOfLines:0];
//    [[_signupBtn titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    
    // to set alignment
    
    NSString *titleText=AMLocalizedString(@"Don't have an account? Sign Up", nil);
    
    [_signupBtn setTitle:titleText forState:UIControlStateNormal];
    
    //  set the different range
    
    NSRange range1 = [_signupBtn.titleLabel.text rangeOfString:AMLocalizedString(@"Sign Up", nil) ];
    
    
    // to set alignment
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.alignment = NSTextAlignmentCenter;
    
    UIFont *font1 = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:13.0f]];
      UIFont *font2 = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:16.0f]];
    //    set the attributes to different ranges
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:_signupBtn.titleLabel.text];
    
    [attributedText setAttributes: @{NSFontAttributeName :font1,
                                     
                                     NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph} range:NSMakeRange(0,_signupBtn.titleLabel.text.length)];
    
    [attributedText addAttributes:@{NSFontAttributeName :font2, NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph} range:range1];
    
    
    [_signupBtn setAttributedTitle:attributedText forState:UIControlStateNormal];
    
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:@{@"fields": @"id,first_name,last_name,name,picture.width(720).height(720),gender,birthday,email,location"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 DebugLog(@"Details:%@",(NSDictionary *)result);
                 
             }
             else
             {
                                 DebugLog(@"error:%@",error);
             }
             
         }];
        
    }
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginClicked:(id)sender {
    
    JMLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMRecentlyUploadedViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)fbClicked:(id)sender {
    
    fbM = [[FBSDKLoginManager alloc] init];
        [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [fbM logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        // no error, so get user info
        if (!error && !result.isCancelled)
        {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:@{@"fields": @"id,first_name,last_name,name,picture.width(720).height(720),gender,birthday,email,location"}]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result, NSError *error) {
                 if (error) {
                     NSLog(@"Login error: %@", [error localizedDescription]);
                     return;
                 }
                 
                    DebugLog(@"Details:%@",(NSDictionary *)result);

             }];
        }
        
    }];
    
}
- (IBAction)googleClicked:(id)sender {
    
    [_googleBtn setUserInteractionEnabled:NO];
    
   
    
    if ([self networkAvailable]) {
        

        
      //  NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        
      //  DebugLog(@"use data - id: %@ and email : %@",[userData objectForKey:@"userID"],[userData objectForKey:@"userEmail"]);
        
//        if ([userData objectForKey:@"userID"]!=nil && [[userData objectForKey:@"userEmail"] length]>0 ) {
//            
//            [self autoLogin:[userData objectForKey:@"userEmail"]];
//            
//        }
//        
//        else{
        
            
            
            [[GIDSignIn sharedInstance] setDelegate:self];
            [[GIDSignIn sharedInstance] setUiDelegate: self];
        
                   [[GIDSignIn sharedInstance] signOut];
        
            [[GIDSignIn sharedInstance] signIn];
            
            //    [GIDSignIn sharedInstance].shouldFetchBasicProfile = NO;
//            [GIDSignIn sharedInstance].allowsSignInWithBrowser = NO;
//            [GIDSignIn sharedInstance].allowsSignInWithWebView = YES;
        
            
            //
            //            NSString *email = @"bhaswar.mukherjee@esolzmail.com";
            //
            //            DebugLog(@"user email: %@",email);
            //
            //
            //
            //            [self autoLogin:email];
            ////
       // }
        
    } else{
        //  [self showAlertwithTitle:@"No internet" withMessage:@"Please check your Internet connection" withAlertType:UIAlertControllerStyleAlert withOk:YES withCancel:NO];
        [_googleBtn setUserInteractionEnabled:YES];
        [SVProgressHUD showInfoWithStatus:@"Please check your Internet connection"];
        
    }

    
}
- (IBAction)signUpClicked:(id)sender
{
    JMRegistrationViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMRegistrationViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    
    
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        loginButton.hidden=YES;
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:@{@"fields": @"id,first_name,last_name,name,picture.width(720).height(720),gender,birthday,email,location"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                      id result, NSError *error) {
             if (error) {
                 NSLog(@"Login error: %@", [error localizedDescription]);
                 return;
             }
             //             NSLog(@"Gathered the following info from your logged in user:
             //                   %@ email: %@ birthday: %@,
             //                   profilePhotoURL: %@”, result, result[@”email”], result[@”birthday"],
             //                   result[@”picture”][@”data”][@”url"]);
             
             DebugLog(@"Details:%@",(NSDictionary *)result);
             
           //  fbDict=[result copy];
             
            // [self checkLogin];
             
             
         }];
    }
    
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    DebugLog(@"error info: %lu",(unsigned long)error.userInfo);
    
    DebugLog(@"error: %lu",(unsigned long)error.userInfo.debugDescription.length);
    
    if (error==NULL) {
        
        
        
        // Perform any operations on signed in user here.
        
        
        NSString *email = user.profile.email;
        
        //  NSString *email = @"vikas@esolzmail.com";
        
        DebugLog(@"user email: %@",email);
        
        NSString *userId = user.userID;                  // For client-side use only!
        NSString *idToken = user.authentication.idToken; // Safe to send to the server
        NSString *fullName = user.profile.name;
        NSString *givenName = user.profile.givenName;
        NSString *familyName = user.profile.familyName;

        
     //   [self autoLogin:email];
        
    }
    
    else{
        
        if (error.userInfo.debugDescription.length==71) {
            
            //user hit cancel in google login
            
            //  [self checkLoader];
            
            [_googleBtn setUserInteractionEnabled:YES];
            
        }
        else  if (error.userInfo.debugDescription.length==50) {
            
            [SVProgressHUD showInfoWithStatus:@"Google did not respond"];
            
            [_googleBtn setUserInteractionEnabled:YES];
            
        }
        else{
            
            [[GIDSignIn sharedInstance] signIn];
        }
    }
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    [_googleBtn setUserInteractionEnabled:YES];
    // Perform any operations when the user disconnects from app here.
    // ...
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
