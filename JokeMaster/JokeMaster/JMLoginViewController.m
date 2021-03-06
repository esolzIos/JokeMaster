//
//  JMLoginViewController.m
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMLoginViewController.h"
#import "JMHomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "JMChooseCountryViewController.h"
#import "JMLanguageViewController.h"
@import SafariServices;
@interface JMLoginViewController ()<UITextFieldDelegate,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,GIDSignInDelegate,SFSafariViewControllerDelegate>
{
    FBSDKLoginManager *fbM;
        AppDelegate *app;
    NSString *registerType;
}
@end

@implementation JMLoginViewController
@synthesize userEmail,password;
- (void)viewDidLoad {
    [super viewDidLoad];
    
      app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    fbM=[[FBSDKLoginManager alloc]init];
    
    [fbM logOut];
    
    [userEmail setFont:[UIFont fontWithName:userEmail.font.fontName size:[self getFontSize:userEmail.font.pointSize]]];
    [password setFont:[UIFont fontWithName:password.font.fontName size:[self getFontSize:password.font.pointSize]]];
    [_loginBtn.titleLabel setFont:[UIFont fontWithName:_loginBtn.titleLabel.font.fontName size:[self getFontSize:_loginBtn.titleLabel.font.pointSize]]];
    
    [_fbBtn.titleLabel setFont:[UIFont fontWithName:_fbBtn.titleLabel.font.fontName size:[self getFontSize:_fbBtn.titleLabel.font.pointSize]]];
    
    [_googleBtn.titleLabel setFont:[UIFont fontWithName:_googleBtn.titleLabel.font.fontName size:[self getFontSize:_googleBtn.titleLabel.font.pointSize]]];
    
    [_infoTxt setFont:[UIFont fontWithName:_infoTxt.font.fontName size:[self getFontSize:_infoTxt.font.pointSize]]];
    
    userEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Email", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Password", nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    [_loginBtn setTitle:AMLocalizedString(@"LOG IN", nil) forState:UIControlStateNormal];
    
    [_btnForgotPassword setTitle:AMLocalizedString(@"Forgot Password?", nil) forState:UIControlStateNormal];
    
    [_fbBtn setTitle:AMLocalizedString(@"Facebook", nil) forState:UIControlStateNormal];
    
    [_googleBtn setTitle:AMLocalizedString(@"Google", nil) forState:UIControlStateNormal];
    
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
    
    _btnForgotPassword.titleLabel.font=[UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:11.0f]];
    
    urlobj=[[UrlconnectionObject alloc] init];
    
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
#pragma mark -Login Clicked
- (IBAction)loginClicked:(id)sender {
    
    [UIView animateWithDuration:0.0f animations:^{
        
        [userEmail resignFirstResponder];
        [password resignFirstResponder];
        
        
        
        
    } completion:^(BOOL finished) {
        
        
        
        if ([self textFieldBlankorNot:userEmail.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Email Address",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Email Address",nil)];
        }
        else if ([self validateEmailWithString:userEmail.text]==NO)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Valid Email Address",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
                        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Valid Email Address",nil)];
        }
        else if ([self textFieldBlankorNot:password.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Password", nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
                  [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Password", nil)];
        }
        else
        {
            
            [self LogInApi];
            
            
        }
        
    }];
    
    
}
#pragma mark -facebook Clicked
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
                 
                 NSString *fbAccessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
                 
                 DebugLog(@"Details:%@ %@",(NSDictionary *)result,fbAccessToken);
              
                 

                 
                 
                 
                 [self SocialLoginApi:[result objectForKey:@"name"] :[result objectForKey:@"email"] :[result objectForKey:@"id"] :fbAccessToken :[[[result objectForKey:@"picture"] objectForKey:@"data"] valueForKey:@"url"]:@"2"];
             }];
        }
        
    }];
    
}
#pragma mark -google Clicked
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
        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Check your Internet connection",nil)];
        
    }
    
    
}
#pragma mark -sign up button Clicked
- (IBAction)signUpClicked:(id)sender
{
    JMRegistrationViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMRegistrationViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
#pragma mark -text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}
#pragma mark -facebook delegate
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
             
             //             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
             //             JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
             //
             //             [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
             
             //  fbDict=[result copy];
             
             // [self checkLogin];
             
             
         }];
    }
    
}

#pragma mark -google delegate
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    DebugLog(@"error info: %lu",(unsigned long)error.userInfo);
    
    DebugLog(@"error: %lu",(unsigned long)error.userInfo.debugDescription.length);
    
    if (error==NULL) {
        
        
        
        // Perform any operations on signed in user here.
        
        
        NSString *email = user.profile.email;
        
        //  NSString *email = @"vikas@esolzmail.com";
        
        
        
        NSString *userId = user.userID;                  // For client-side use only!
        NSString *idToken = user.authentication.idToken; // Safe to send to the server
        NSString *fullName = user.profile.name;
        //        NSString *givenName = user.profile.givenName;
        //        NSString *familyName = user.profile.familyName;
        
        NSString *imageurl;
        if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
        {
            //  NSUInteger dimension = round(thumbSize.width * [[UIScreen mainScreen] scale]);
            NSURL *imageURL = [user.profile imageURLWithDimension:200];
            imageurl=[imageURL absoluteString];
            NSLog(@"User image %@",imageURL);
        }
        else {
            NSLog(@"error---%@", error.localizedDescription);
            imageurl=@"";
        }
        
        DebugLog(@"user email: %@ %@ %@ %@ %@",email,userId,idToken,fullName,user.profile);
        
        

        
        
        [self SocialLoginApi:fullName :email :userId :idToken :imageurl :@"3"];
    }
    
    else{
        
        if (error.userInfo.debugDescription.length==71) {
            
            //user hit cancel in google login
            
            //  [self checkLoader];
            
            [_googleBtn setUserInteractionEnabled:YES];
            
        }
        else  if (error.userInfo.debugDescription.length==50) {
            
               [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
            
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
#pragma mark -Login api call
-(void)LogInApi
{
    
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.view.userInteractionEnabled = NO;
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSMutableString *urlString;
            
            
            urlString=[NSMutableString stringWithFormat:@"%@index.php/Signup/login?email=%@&password=%@&device_token=%@&device_type=2&mode=%@",GLOBALAPI,[userEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
//                [[[UIAlertView alloc]initWithTitle:@"Error!" message:[NSString stringWithFormat:@"%@",urlString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"user_id"] forKey:@"UserId"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"name"] forKey:@"Name"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"image"] forKey:@"Image"];
                         
                         app.userId=[[responseDict objectForKey:@"Details"] valueForKey:@"user_id"];
                         app.userName=[[responseDict objectForKey:@"Details"] valueForKey:@"name"];
                         app.userImage=[[responseDict objectForKey:@"Details"] valueForKey:@"image"];
                         app.isLogged=true;
                         
                         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
                         
                           [[NSUserDefaults standardUserDefaults ]setObject:[[responseDict objectForKey:@"Details"]valueForKey:@"language"] forKey:@"langname"];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"Details"]valueForKey:@"short_name"] forKey:@"language"];
                         
                                                  [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"Details"]valueForKey:@"languageid"] forKey:@"langmode"];
                         
                         LocalizationSetLanguage([[responseDict objectForKey:@"Details"]valueForKey:@"short_name"]);
                         
                         if([[[responseDict objectForKey:@"Details"]valueForKey:@"short_name"] isEqualToString:@"he"])
                         {
                             
                             [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rightToleft"];
                             
                             app.storyBoard = [UIStoryboard storyboardWithName:@"Hebrew" bundle:nil];
                             
                         }
                         else{
                             [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"rightToleft"];
                             
                             app.storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         }
                         
//                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"Details"]valueForKey:@"short_name"] forKey:@"langName"];

                         
                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"Details"]valueForKey:@"country"] forKey:@"userCountry"];
                         
                         JMHomeViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
                         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
                         
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         //                         [[[UIAlertView alloc]initWithTitle:@"Error!" message:[responseDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                 }
                 else
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 }
                 
                 
             } failure:^(NSError *error) {
                 
                 [self checkLoader];
                 self.view.userInteractionEnabled = YES;
                 NSLog(@"Failure");
                 
                 [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 //                 [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 
             }];
            
            
        }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
        
        //        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}

- (IBAction)ForgotPasswordClick:(id)sender
{
    JMLoginViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMForgotPasswordViewController"];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

- (IBAction)gobackClicked:(id)sender {
    
       
             [_goBackBtn setUserInteractionEnabled:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -Social Login api call
-(void)SocialLoginApi: (NSString *)name :(NSString *)email :(NSString *)sid :(NSString *)accessToken :(NSString *)imageurl :(NSString *)type
{
    
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.view.userInteractionEnabled = NO;
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Signup/socialSignup?register_type=%@&name=%@&email=%@&facebook_id=%@&facebook_token=%@&device_token=%@&device_type=2&mode=%@",GLOBALAPI,type,[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[sid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[accessToken stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            NSString *postString1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                          NULL,
                                                                                                          (CFStringRef)imageurl,
                                                                                                          NULL,
                                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                          kCFStringEncodingUTF8 ));
            
            NSString *postString=[NSString stringWithFormat:@"userimage=%@",postString1];
            
            
            //  [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
            [urlobj getSessionJsonResponse:urlString withPostData:postString typerequest:(NSString *)@"array" success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"userinfo"] valueForKey:@"id"] forKey:@"UserId"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"userinfo"] valueForKey:@"name"] forKey:@"Name"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"userinfo"] valueForKey:@"image"] forKey:@"Image"];
                         
                         app.userId=[[responseDict objectForKey:@"userinfo"] valueForKey:@"id"];
                         app.userName=[[responseDict objectForKey:@"userinfo"] valueForKey:@"name"];
                         app.userImage=[[responseDict objectForKey:@"userinfo"] valueForKey:@"image"];
                         app.isLogged=true;
                         
                         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
                         
                                   [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"short_name"] forKey:@"language"];
                         
                                          [[NSUserDefaults standardUserDefaults ]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"language"] forKey:@"langname"];
                         
                       [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"languageid"] forKey:@"langmode"];
                         
                                    [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"languageid"] forKey:@"langId"];
                         
                         LocalizationSetLanguage([[responseDict objectForKey:@"userinfo"]valueForKey:@"short_name"]);
                         
                         if([[[responseDict objectForKey:@"userinfo"]valueForKey:@"short_name"] isEqualToString:@"he"])
                         {
                             
                             [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rightToleft"];
                             
                             app.storyBoard = [UIStoryboard storyboardWithName:@"Hebrew" bundle:nil];
                             
                         }
                         else{
                             [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"rightToleft"];
                             
                             app.storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         }
                         
               [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"country"] forKey:@"userCountry"];
                         
                         JMHomeViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
                         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
                         
                     }
                     else
                     {
                         if ([[responseDict objectForKey:@"user_exist"] isEqualToString:@"0"])
                         {
                             
                             JMLanguageViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMLanguageViewController"];
                             
                             NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
                             [dict setObject:name forKey:@"name"];
                             [dict setObject:email forKey:@"email"];
                             [dict setObject:sid forKey:@"sid"];
                             [dict setObject:accessToken forKey:@"idToken"];
                             [dict setObject:imageurl forKey:@"userimage"];
                             [dict setObject:type forKey:@"regtype"];
                             VC.userDict=dict;
                             
                             VC.fromLogin=YES;
                             
                             [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
                             
                             
                             
                         }
                         else{
                             [_googleBtn setUserInteractionEnabled:YES];
                             [_fbBtn setUserInteractionEnabled:YES];
                         
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                             
                         }
                         //                         [[[UIAlertView alloc]initWithTitle:@"Error!" message:[responseDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 
                 else
                 {
                                          [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       [self checkLoader];
                                         [_googleBtn setUserInteractionEnabled:YES];
                                       [_fbBtn setUserInteractionEnabled:YES];
                                       
                                       NSLog(@"Failure");
                                       //                                       [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                                       
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       
                                   }
             ];
        }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
        //        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}

@end
