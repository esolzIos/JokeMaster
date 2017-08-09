//
//  JMRegistrationViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMRegistrationViewController.h"
#import "JMHomeViewController.h"
#import "DZNPhotoEditorViewController.h"
#import "UIImagePickerController+Edit.h"
@interface JMRegistrationViewController ()
{
    AppDelegate *app;
    
    NSMutableArray *langArr,*flagArr;
    
    NSMutableDictionary *langDict;
    
        NSMutableArray *CountryArray;
    int rowSelected;
    NSString *  countrySelected,*countryImage,*langSelected;
    NSURLSession *session;
    BOOL countryOpen,langOpen;
    NSMutableArray *jsonArr;
}
@end

@implementation JMRegistrationViewController
@synthesize Nametxt,Emailtxt,Passwordtxt,ProfileImage,ProfileImageLabel,ConfirmPassword,mainscroll,Logintxtvw,LanguageView,LanguageLabel,LanguageBtn,SignUpBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // sign in text view design
      app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *titleText=AMLocalizedString(@"Back to Log in", nil);
    
    [_gobackBtn setTitle:titleText forState:UIControlStateNormal];
    
    //  set the different range
    
    NSRange range1 = [_gobackBtn.titleLabel.text rangeOfString:AMLocalizedString(@"Log in", nil) ];
    
    
    // to set alignment
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.alignment = NSTextAlignmentCenter;
    
    UIFont *font1 = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:13.0f]];
    UIFont *font2 = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:16.0f]];
    //    set the attributes to different ranges
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:_gobackBtn.titleLabel.text];
    
    [attributedText setAttributes: @{NSFontAttributeName :font1,
                                     
                                     NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph} range:NSMakeRange(0,_gobackBtn.titleLabel.text.length)];
    
    [attributedText addAttributes:@{NSFontAttributeName :font2, NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph} range:range1];
    
    
    [_gobackBtn setAttributedTitle:attributedText forState:UIControlStateNormal];

    
    
    
//    UIFont *font1 = [UIFont fontWithName:@"ComicSansMS-Bold" size:15];
//    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
//    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:AMLocalizedString(@"Back to",nil) attributes: arialDict];
//    [aAttrString1 addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor whiteColor]
//                         range:NSMakeRange(0, [aAttrString1 length])];
//    
//    UIFont *font2 = [UIFont fontWithName:@"ComicSansMS-Bold" size:20];
//    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject:font2 forKey:NSFontAttributeName];
//    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",AMLocalizedString(@"Log in",nil)] attributes: arialDict2];
//    [aAttrString2 addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor whiteColor]
//                         range:NSMakeRange(0, [aAttrString2 length])];
//    
//    [aAttrString1 appendAttributedString:aAttrString2];
//    Logintxtvw.attributedText = aAttrString1;
//    Logintxtvw.textAlignment = NSTextAlignmentCenter;
//    
//    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTextView:)];
//    [Logintxtvw addGestureRecognizer:tapRecognizer1];
    
    
    // place holder design
    Emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    Nametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Name",nil) attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    Passwordtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Password",nil)attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    ConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Confirm Password",nil) attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    
//    ProfileImageLabel.frame=CGRectMake(ProfileImageLabel.frame.origin.x, ProfileImage.frame.origin.y+ProfileImage.frame.size.height/2-ProfileImageLabel.frame.size.height/2, ProfileImageLabel.frame.size.width, ProfileImageLabel.frame.size.height);
    
    
    ProfileImageLabel.text= AMLocalizedString(@"Upload Profile Picture",nil);
    LanguageLabel.text=AMLocalizedString(@"Language",nil);
    [SignUpBtn setTitle:AMLocalizedString(@"SIGN UP",nil) forState:UIControlStateNormal];
    
    
    [self setRoundCornertoView:ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [ProfileImageLabel setFont:[UIFont fontWithName:ProfileImageLabel.font.fontName size:[self getFontSize:ProfileImageLabel.font.pointSize]]];
    

      [LanguageLabel setFont:[UIFont fontWithName:LanguageLabel.font.fontName size:[self getFontSize:LanguageLabel.font.pointSize]]];
    
      [_countryLbl setFont:[UIFont fontWithName:_countryLbl.font.fontName size:[self getFontSize:_countryLbl.font.pointSize]]];
    
        [Nametxt setFont:[UIFont fontWithName:Nametxt.font.fontName size:[self getFontSize:Nametxt.font.pointSize]]];
    
        [Emailtxt setFont:[UIFont fontWithName:Emailtxt.font.fontName size:[self getFontSize:Emailtxt.font.pointSize]]];
    
        [Passwordtxt setFont:[UIFont fontWithName:Passwordtxt.font.fontName size:[self getFontSize:Passwordtxt.font.pointSize]]];
    
        [ConfirmPassword setFont:[UIFont fontWithName:ConfirmPassword.font.fontName size:[self getFontSize:ConfirmPassword.font.pointSize]]];
    
    
      [_popTitle setFont:[UIFont fontWithName:_popTitle.font.fontName size:[self getFontSize:_popTitle.font.pointSize]]];
    
        [SignUpBtn.titleLabel setFont:[UIFont fontWithName:SignUpBtn.titleLabel.font.fontName size:[self getFontSize:SignUpBtn.titleLabel.font.pointSize]]];
    
    _popTitle.layer.shadowColor = [[UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:0.3] CGColor];
    _popTitle.layer.shadowOffset = CGSizeMake(-2.0f,3.0f);
    _popTitle.layer.shadowOpacity = 1.0f;
    _popTitle.layer.shadowRadius = 1.0f;
    
    
    urlobj=[[UrlconnectionObject alloc] init];
    
    
    langDict=[[NSMutableDictionary alloc]init];
    
    CountryArray=[[NSMutableArray alloc]init];

    
    
    langArr=[[NSMutableArray alloc] init];
 
    
    //    engArr=[[NSMutableArray alloc] initWithObjects:@"UNITED STATES",@"UNITED KINGDOM",@"INDIA", nil];
    //
    //     hindiArr=[[NSMutableArray alloc] initWithObjects:@"INDIA",@"PAKISTAN", nil];
    //
    //      hebrewArr=[[NSMutableArray alloc] initWithObjects:@"ISRAEL", nil];
    //
    //    [langDict setObject:engArr forKey:@"en"];
    //
    //    [langDict setObject:hebrewArr forKey:@"he"] ;
    //
    //     [langDict setObject:hindiArr forKey:@"hi"] ;
    //
    [LanguageLabel setText:AMLocalizedString(@"App interface language", nil)];
   
     [_countryLbl setText:AMLocalizedString(@"Country", nil)];
    
    [_goBtn setTitle:AMLocalizedString(@"GO",nil) forState:UIControlStateNormal] ;
    
    [_languagePicker setDelegate:self];
    
    
//    langSelected=[[NSUserDefaults standardUserDefaults ]objectForKey:@"langId"];
//    countrySelected= [[NSUserDefaults standardUserDefaults ]objectForKey:@"countryId"];
//    
//    countryImage=[[NSUserDefaults standardUserDefaults ]objectForKey:@"flag"];
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    
    [_selectBtn setTitle:AMLocalizedString(@"Select", nil)  forState:UIControlStateNormal];
    
    [_cancelBttn setTitle:AMLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    [mainscroll setContentSize:CGSizeMake(FULLWIDTH, 630.0/480.0*FULLHEIGHT)];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
}

-(void)appendPushView
{
    [self addPushView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidAppear:(BOOL)animated
{
    [self loadData];
}
-(void)loadData
{
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
                [_gifImage setHidden:YES];
                [_noVideoView setHidden:NO];
                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                [_loaderBtn setHidden:NO];
                
                
                // [_GoButton setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                

                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    //    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        [_loaderView setHidden:YES];
                        
                        jsonArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                     
                        
                        
                        
                        // [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in jsonArr) {
                            
                            [langArr addObject:Dict];
              
                   
                            
                        }
                        
   
                        
                        [self getCountries];
                        
                    }
                    
                    
                    else{
                        
                        //                        if (langArr.count==0) {
                        //
                        //                            [SVProgressHUD dismiss];
                        //                        }
                        //                        else{
                        //                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                        }
                        //
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
        //   [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
    
    
    
    
}

-(void)getCountries
{
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@Signup/getcountry?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
                [_gifImage setHidden:YES];
                [_noVideoView setHidden:NO];
                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                [_loaderBtn setHidden:NO];
                
                
                // [_GoButton setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                [_goBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    //    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        [_loaderView setHidden:YES];
                        
                        jsonArr=[[jsonResponse objectForKey:@"countryData"] copy];
                        
                        
                          [_goBtn setUserInteractionEnabled:YES];
                        
                        
                        // [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in jsonArr) {
                            
                            [CountryArray addObject:Dict];
                            
                            
                            
                        }
                        
                        
                        
                        if (CountryArray.count>0) {
                    
            
                            
                            [_popTable reloadData];
                            
               
                        }
                        else{
                            
                            [_goBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
            
                        
                    }
                    
                    
                    else{
                        
                        //                        if (langArr.count==0) {
                        //
                        //                            [SVProgressHUD dismiss];
                        //                        }
                        //                        else{
                        //                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                        }
                        //
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
        //   [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
    
    
    
    
}

#pragma mark - Sign up tap
- (IBAction)SignUpTapped:(id)sender
{
    
    
    [UIView animateWithDuration:0.0f animations:^{
        [Nametxt resignFirstResponder];
        [Emailtxt resignFirstResponder];
        [Passwordtxt resignFirstResponder];
        [ConfirmPassword resignFirstResponder];
        
        
        
    } completion:^(BOOL finished) {
        
        [mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        
        if([self textFieldBlankorNot:Nametxt.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//
//                                          message:AMLocalizedString(@"Enter Name", nil)
//
//
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
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Name", nil)];
            
            
        }
        else if ([self textFieldBlankorNot:Emailtxt.text]==YES)
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
        else if ([self validateEmailWithString:Emailtxt.text]==NO)
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
//        else if ([LanguageLabel.text isEqualToString:AMLocalizedString(@"Language",nil)])
//        {
////            UIAlertController * alert=   [UIAlertController
////                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
////                                          message:AMLocalizedString(@"Select Language",nil)
////                                          preferredStyle:UIAlertControllerStyleAlert];
////            
////            UIAlertAction* ok = [UIAlertAction
////                                 actionWithTitle:AMLocalizedString(@"OK",nil)
////                                 style:UIAlertActionStyleDefault
////                                 handler:^(UIAlertAction * action)
////                                 {
////                                     [alert dismissViewControllerAnimated:YES completion:nil];
////                                     
////                                     
////                                     
////                                     
////                                 }];
////            
////            [alert addAction:ok];
////            [self presentViewController:alert animated:YES completion:nil];
//            
//            
//                         [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Select Language",nil)];
//        }
        else if ([self textFieldBlankorNot:Passwordtxt.text]==YES)
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
        else if (Passwordtxt.text.length<6)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Password Should be at least 6 characters",nil)
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
            
                      [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Password Should be at least 6 characters",nil)];
        }
        else if ([self textFieldBlankorNot:ConfirmPassword.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Confirm Password",nil)
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
            
               [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Confirm Password",nil)];
        }
        
        else if (![Passwordtxt.text isEqualToString:ConfirmPassword.text])
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Password and confirm password should be same.",nil)
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
            
               [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Password and confirm password should be same.",nil)];
        }
      else if (langSelected.length==0)
      {
              [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"App interface Language required",nil)];
      
      }
      else if (countrySelected.length==0)
      {
          [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Please select your country",nil)];
          
      }
        else
        {
           // [self SignUpApi];
            [self SignUpAPI1];
            
        }
    
    }];

}

#pragma mark - textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    [textField becomeFirstResponder];
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         if (IsIphone4)
                         {
                             if (textField==Passwordtxt)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==ConfirmPassword)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
                             }
                             
                             
                         }
                         else if (IsIphone5)
                         {
                             if (textField==Passwordtxt)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==ConfirmPassword)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
                             }
                             
                         }
                         else
                         {
                             if (textField==Passwordtxt)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,60.0f) animated:YES];
                             }
                             else if (textField==ConfirmPassword)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,130.0f) animated:YES];
                             }
                             
                         }
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         [textField resignFirstResponder];
                         [mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    return YES;
}
#pragma mark - upload profile image
- (IBAction)ProfileImageUploadTapped:(id)sender
{
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"Camera",nil),AMLocalizedString(@"Photo Library",nil), nil];
    [actionsheet showInView:self.view];
}
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
     picker.allowsEditing=YES;
    
       picker.cropMode=DZNPhotoEditorViewControllerCropModeSquare;
    
    //  PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (buttonIndex) {
            
        case 0:
            
            
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                [self openCamera];
            }
            else {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:AMLocalizedString(@"OK",nil) otherButtonTitles:nil];
//                [alert show];
                
                         [SVProgressHUD showInfoWithStatus:@"No Camera Available."];
            }
            break;
            
        case 1:
            
            
            picker.allowsEditing = NO;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            //   picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            [self presentViewController:picker animated:YES completion:^{
                
                
            }];
            
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark - image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
//    imgData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage],0.9895);
//    DebugLog(@"Size of Image(bytes):%lu",(unsigned long)[imgData length]);
    
    
 //   AttachImage=info[UIImagePickerControllerOriginalImage];
    ProfileImage.image=info[UIImagePickerControllerEditedImage];
    
    ProfileImage.contentMode = UIViewContentModeScaleAspectFill;
    
  //  ProfileImage.layer.cornerRadius=ProfileImage.frame.size.height/2;
    
    ProfileImage.clipsToBounds=YES;
    
 //   [ProfileImage setUserInteractionEnabled:YES];
    
    
    
    //  AttachmentImage.image=[self compressImage:AttachmentImage.image];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
       
        
    }];
    
  
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    
}
#pragma mark - open camera
-(void)openCamera
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
    
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:picker animated:YES completion:NULL];
    
    
    
}
#pragma mark - Language btn tapped
- (IBAction)LanguageTapped:(id)sender
{
    [Nametxt resignFirstResponder];
    [Emailtxt resignFirstResponder];
    [Passwordtxt resignFirstResponder];
    [ConfirmPassword resignFirstResponder];
    
    if (langArr.count>0) {
        
         countryOpen=NO;
        langOpen=YES;
         [_popTitle setText:@"APP INTERFACE LANGUAGE"];
        [_PopView setHidden:NO];
        [_popTable reloadData];
        
        
    }

    
    
//    [_pickerView setHidden:NO];
//
//    [_languagePicker reloadAllComponents];
//
//
//    [_languagePicker selectRow:rowSelected inComponent:0 animated:NO];

}
#pragma mark -  title picker cancel
-(void)CategoryCancel
{
    [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
    LanguageBtn.selected=NO;
    
    [OverlayView removeFromSuperview];
    [tipImage removeFromSuperview];
    [Langview removeFromSuperview];
    
}

#pragma mark -  picker delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return langArr.count;
    
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    // NSString *text = nil;
    // Reuse the label if possible, otherwise create and configure a new one
    if ((pickerLabel == nil) || ([pickerLabel class] != [UILabel class])) { //newlabel
        CGRect frame = CGRectMake(0.0, 0.0, 270, 32.0);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:14]];
        [pickerLabel setText:[[langArr objectAtIndex:row]objectForKey:@"name"] ];
    }
    pickerLabel.textColor = [UIColor whiteColor];
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 50.0/480.0*FULLHEIGHT;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [[langArr objectAtIndex:row]objectForKey:@"name"] ;
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowSelected=(int)row;
    
    
    
}

#pragma mark - Back Button Click
- (IBAction)backClicked:(id)sender {
    
        [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -signup api call
-(void)SignUpAPI1
{
    NSString *urlString = [NSMutableString stringWithFormat:@"%@index.php/Signup?register_type=1&name=%@&email=%@&password=%@&language=&device_token=%@&device_type=2&mode=%@&language=%@&country=%@",GLOBALAPI,[Nametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Emailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Passwordtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"],langSelected,countrySelected];
    
        urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *strEncoded;
    
    UIImage *secondImage = [UIImage imageNamed:@"no-image"];
    
    NSData *imgData = UIImagePNGRepresentation(ProfileImage.image);
    NSData *imgData1 = UIImagePNGRepresentation(secondImage);
    
    BOOL isCompare =  [imgData1 isEqual:imgData];
    if (!isCompare)
    {
        //             AttachmentImage.image=[self compressImage:AttachmentImage.image];
        //
        //            imgData = UIImageJPEGRepresentation(AttachmentImage.image, 1.0);
        //  DebugLog(@"Size of Image(bytes):%lu",(unsigned long)[imgData length]);
        
        
        strEncoded = [self encodeToBase64String:ProfileImage.image];
       
    }
    else
    {
        strEncoded =@"";
    }
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
    self.view.userInteractionEnabled = NO;
    [self checkLoader];
    [urlobj globalImage:urlString ImageString:strEncoded ImageField:@"userimage" typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed)
    {
        NSLog(@"event result----- %@", result);
        DebugLog(@" Status Code:%ld",urlobj.statusCode);
        
        self.view.userInteractionEnabled = YES;
        [self checkLoader];
        
        if (urlobj.statusCode==200)
        {
            if ([[result objectForKey:@"status"] boolValue]==YES)
            {
                
                [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Registration successful.",nil)];
//                AlertView = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                       message:@"Registration successful."
//                                                      delegate:self
//                                             cancelButtonTitle:nil
//                                             otherButtonTitles:nil];
//                
//                [AlertView show];
                
                [[NSUserDefaults standardUserDefaults] setObject:[[result objectForKey:@"Details"] valueForKey:@"user_id"] forKey:@"UserId"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result objectForKey:@"Details"] valueForKey:@"name"] forKey:@"Name"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result objectForKey:@"Details"] valueForKey:@"image"] forKey:@"Image"];
                
                DebugLog(@"%@",[[result objectForKey:@"Details"] valueForKey:@"user_id"]);
                
                app.userId=[[result objectForKey:@"Details"] valueForKey:@"user_id"];
                app.userName=[[result objectForKey:@"Details"] valueForKey:@"name"];
                app.userImage=[[result objectForKey:@"Details"] valueForKey:@"image"];
                
                app.isLogged=true;
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
               
                          [[NSUserDefaults standardUserDefaults ]setObject:[[result objectForKey:@"Details"]valueForKey:@"language"] forKey:@"langname"];
                
                [[NSUserDefaults standardUserDefaults]setObject:[[result objectForKey:@"Details"]valueForKey:@"short_name"] forKey:@"language"];
                
                [[NSUserDefaults standardUserDefaults]setObject:[[result objectForKey:@"Details"]valueForKey:@"languageid"] forKey:@"langmode"];
                
                   [[NSUserDefaults standardUserDefaults]setObject:[[result objectForKey:@"Details"]valueForKey:@"languageid"] forKey:@"langId"];
                
                
                LocalizationSetLanguage([[result objectForKey:@"Details"]valueForKey:@"short_name"]);
                
                [[NSUserDefaults standardUserDefaults]setObject:[[result objectForKey:@"Details"]valueForKey:@"country"] forKey:@"userCountry"];

                
                
                // (success message) dismiss delay of 1 sec
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
            }
            else
            {
               [SVProgressHUD showInfoWithStatus:[result objectForKey:@"message"]];
//                [[[UIAlertView alloc]initWithTitle:@"Error!" message:[result objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            }
            
        }
        else if (urlobj.statusCode==500 || urlobj.statusCode==400)
        {
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
//            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
//            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        }
    }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
//        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark -signup api call-- not used
-(void)SignUpApi
{
   
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSMutableString *urlString;
          
            
          
             //   urlString=[NSMutableString stringWithFormat:@"%@index.php/Signup",GLOBALAPI];
                
                
                urlString=[NSMutableString stringWithFormat:@"%@index.php/Signup?register_type=1&name=%@&email=%@&password=%@&language=%@&country=&device_token=%@&device_type=1&mode=%@",GLOBALAPI,[Nametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Emailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Passwordtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[LanguageLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
            
            NSString *strEncoded,*requestBody;
            
            UIImage *secondImage = [UIImage imageNamed:@"no-image"];
            
            NSData *imgData = UIImagePNGRepresentation(ProfileImage.image);
            NSData *imgData1 = UIImagePNGRepresentation(secondImage);
            
            BOOL isCompare =  [imgData1 isEqual:imgData];
            if (!isCompare)
            {
                //             AttachmentImage.image=[self compressImage:AttachmentImage.image];
                //
                //            imgData = UIImageJPEGRepresentation(AttachmentImage.image, 1.0);
              //  DebugLog(@"Size of Image(bytes):%lu",(unsigned long)[imgData length]);
                
                
                strEncoded = [self encodeToBase64String:ProfileImage.image];
                requestBody= [NSString stringWithFormat:@"userimage=%@",strEncoded];
            }
            else
            {
                requestBody= [NSString stringWithFormat:@"userimage="];
            }
           
            
            DebugLog(@"post string: %@",urlString);
            DebugLog(@"requestBody string: %@",requestBody);
            
            [urlobj getSessionJsonResponseWithUploadImage :(NSString *)urlString Image :(NSString *)requestBody  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Registration successful.",nil)];
//                         AlertView = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                                message:@"Registration successful."
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:nil];
//                         
//                         [AlertView show];
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"user_id"] forKey:@"UserId"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"name"] forKey:@"Name"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"image"] forKey:@"Image"];
                         
                         app.userId=[[responseDict objectForKey:@"Details"] valueForKey:@"user_id"];
                         app.userName=[[responseDict objectForKey:@"Details"] valueForKey:@"name"];
                         app.userImage=[[responseDict objectForKey:@"Details"] valueForKey:@"image"];
                         
                         
                         // (success message) dismiss delay of 1 sec
                         [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         //                [[[UIAlertView alloc]initWithTitle:@"Error!" message:[result objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                 }
                 else
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 }
                 
                 
             } failure:^(NSError *error) {
                 
                 [self checkLoader];
                 self.view.userInteractionEnabled = YES;
                 NSLog(@"Failure");
//                 [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 
                 [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 
             }];
            
            
        }];
    }
    else
    {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark -After registration go to Home screen
-(void)GotoNextPageAfterSuccess
{
    
       app.isLogged=true;
    [AlertView dismissWithClickedButtonIndex:0 animated:NO];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
    JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

- (IBAction)countryClicked:(id)sender {
    

    if (CountryArray.count>0) {
        
        langOpen=NO;
        countryOpen=YES;
        [_popTitle setText:@"CHOOSE YOUR COUNTRY"];
        [_popTable reloadData];
        [_PopView setHidden:NO];
        
    }
 
    
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (langOpen) {
        return [langArr count];
    }
    else if (countryOpen)
    {
        return [CountryArray count];
    }
    else
        return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"CountryCell";
    
    CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //  cell.CheckImage.tag=indexPath.row+500;
    //  cell.CheckButton.tag=indexPath.row;
    //  [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsIphone5 || IsIphone4)
    {
        return 50;
    }
    else
    {
        return 60;
    }
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(CountryCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (countryOpen) {
  
    if ([countrySelected isEqualToString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryId"]])
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"tick"];
        
        
        
    }
    else
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
    }
    
    
           [cell.CountryImage setHidden:NO];
        
    [cell.CountryImage sd_setImageWithURL:[NSURL URLWithString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"world"]];
    
    [cell.CountryLabel setText:AMLocalizedString([[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryName"] uppercaseString], nil) ];
    
        [cell.CountryLabel setFont:[UIFont fontWithName:cell.CountryLabel.font.fontName size:[self getFontSize:11.0]]];
        
    
    }
    else if (langOpen)
    {
        if ([langSelected isEqualToString:[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
        {
            
            cell.CheckImage.image = [UIImage imageNamed:@"tick"];
            
            
            
        }
        else
        {
            
            cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
        }
        
        
        [cell.CountryImage setHidden:YES];
        
        
        [cell.CountryLabel setText:AMLocalizedString([[[langArr objectAtIndex:indexPath.row]objectForKey:@"name"] uppercaseString], nil) ];
        
        [cell.CountryLabel setFont:[UIFont fontWithName:cell.CountryLabel.font.fontName size:[self getFontSize:11.0]]];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  CountryCell *cCell=[_CountryTable cellForRowAtIndexPath:indexPath];
    
    if (countryOpen) {
   
    if (![countrySelected isEqualToString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryId"]])
    {
        
        countrySelected=[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryId"];
        
        countryImage=[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"image"];
        
           [_countryLbl setText:AMLocalizedString([[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryName"], nil)];
    }
    else
    {
        countrySelected=@"";
        countryImage=@"";
    }
    
    
    [_popTable reloadData];
    
        
    }
    else if (langOpen){

        
    
        if (![langSelected isEqualToString:[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
        {
            
                    langSelected=[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"];
        [LanguageLabel setText:AMLocalizedString([[langArr objectAtIndex:indexPath.row]objectForKey:@"name"], nil)];
    }
    else
    {
        langSelected=@"";
    
    }
    
    
    [_popTable reloadData];
    

    }
}
- (IBAction)selectClicked:(id)sender {
    
    [LanguageLabel setText:AMLocalizedString([[langArr objectAtIndex:rowSelected]objectForKey:@"name"], nil)];
    
    langSelected=[[langArr objectAtIndex:rowSelected] objectForKey:@"id"];
    


    
    
    [_pickerView setHidden:YES];
}
- (IBAction)cancelClicked:(id)sender {
    
    [_pickerView setHidden:YES];
}
- (IBAction)popChoosed:(id)sender
{

    
    
    [_PopView setHidden:YES];
    
    
}
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_noVideoView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
    langArr=[[NSMutableArray alloc] init];

      CountryArray=[[NSMutableArray alloc]init];
    [self loadData];
    
    
}
- (IBAction)goBackClicked:(id)sender {
    
     [_PopView setHidden:YES];
}
@end
