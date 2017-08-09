//
//  JMForgotPasswordViewController.m
//  JokeMaster
//
//  Created by priyanka on 14/07/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMForgotPasswordViewController.h"

@interface JMForgotPasswordViewController ()

@end

@implementation JMForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     _txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _txtCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Security Code",nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Password",nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Confirm Password",nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
     [_btnBackToLogin setTitle:AMLocalizedString(@"Back to Log in", nil) forState:UIControlStateNormal];
    
       [_btnPasswordSubmit setTitle:AMLocalizedString(@"SUBMIT", nil) forState:UIControlStateNormal];
    
     [_btnEmailSubmit setTitle:AMLocalizedString(@"SUBMIT", nil) forState:UIControlStateNormal];
    
    
    
    _btnBackToLogin.titleLabel.font=[UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:11.0f]];
    
    urlobj=[[UrlconnectionObject alloc] init];
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
#pragma mark - Send Email Click
- (IBAction)EmailSubmitClick:(id)sender
{
    [UIView animateWithDuration:0.0f animations:^{
        [_txtEmail resignFirstResponder];
        
        
        
        
    } completion:^(BOOL finished) {
        
        [_EmailScroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        
       if ([self textFieldBlankorNot:_txtEmail.text]==YES)
        {
           
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Email Address",nil)];
        }
        else if ([self validateEmailWithString:_txtEmail.text]==NO)
        {
            
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Valid Email Address",nil)];
        }
        else
        {
            
            [self EmailSentApi];
           
            
        }
        
    }];
}
#pragma mark - Send Password Click
- (IBAction)PasswordSubmitClick:(id)sender
{
    [UIView animateWithDuration:0.0f animations:^{
        [_txtCode resignFirstResponder];
        [_txtPassword resignFirstResponder];
        [_txtConfirmPassword resignFirstResponder];
        
        
        
        
    } completion:^(BOOL finished) {
        
        [_PasswordScroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        
        if ([self textFieldBlankorNot:_txtCode.text]==YES)
        {
            
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Security Code", nil)];
        }
        else if ([self textFieldBlankorNot:_txtPassword.text]==YES)
        {
            
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Password", nil)];
        }
        else if (_txtPassword.text.length<6)
        {
          
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Password Should be at least 6 characters",nil)];
        }
        else if ([self textFieldBlankorNot:_txtConfirmPassword.text]==YES)
        {
            
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Confirm Password",nil)];
        }
        else if (![_txtPassword.text isEqualToString:_txtConfirmPassword.text])
        {
            
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Password and confirm password should be same.",nil)];
        }
        else
        {
            
            [self PasswordUpdateApi];
            
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
                             if (textField==_txtCode)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==_txtPassword)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==_txtConfirmPassword)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             
                             
                         }
                         else if (IsIphone5)
                         {
                             if (textField==_txtCode)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==_txtPassword)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==_txtConfirmPassword)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             
                         }
                         else
                         {
                             if (textField==_txtCode)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==_txtPassword)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==_txtConfirmPassword)
                             {
                                 [_PasswordScroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
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
                         [_EmailScroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                         [_PasswordScroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    return YES;
}
#pragma mark -Email api call
-(void)EmailSentApi
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
            
            
            urlString=[NSMutableString stringWithFormat:@"%@index.php/Useraction/forgotpassword?email=%@&mode=%@",GLOBALAPI,[_txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
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
                        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"A Security Code sent to your Email",nil)];
                        
                         _EmailScroll.hidden=YES;
                         _PasswordScroll.hidden=NO;
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
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        //        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark -Password Update api call
-(void)PasswordUpdateApi
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
            
            NSString *Code = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                          NULL,
                                                                                                          (CFStringRef)_txtCode.text ,
                                                                                                          NULL,
                                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                          kCFStringEncodingUTF8 ));
            
            NSString *Password = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                   NULL,
                                                                                                   (CFStringRef)_txtPassword.text ,
                                                                                                   NULL,
                                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8 ));
            
           
            
               urlString=[NSMutableString stringWithFormat:@"%@index.php/Useraction/updatepassword?code=%@&password=%@&mode=%@",GLOBALAPI,[Code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
//            urlString=[NSMutableString stringWithFormat:@"%@index.php/Useraction/updatepassword?code=%@&password=%@&mode=%@",GLOBALAPI,[_txtCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            DebugLog(@"Password Chng %@",urlString);
            
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
                         
                         [SVProgressHUD showInfoWithStatus:@"Password Updated Successfully."];
                         [self POPViewController];
                         
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
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        //        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark - Back To Login
- (IBAction)BackToLogin:(id)sender
{
    [self POPViewController];
}
- (IBAction)goBackClicked:(id)sender {
    
    _EmailScroll.hidden=NO;
    _PasswordScroll.hidden=YES;
}
@end
