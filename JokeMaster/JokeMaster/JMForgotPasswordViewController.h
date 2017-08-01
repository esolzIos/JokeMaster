//
//  JMForgotPasswordViewController.h
//  JokeMaster
//
//  Created by priyanka on 14/07/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "UrlconnectionObject.h"
@interface JMForgotPasswordViewController : JMGlobalMethods
{
    UrlconnectionObject *urlobj;
}
@property (weak, nonatomic) IBOutlet UIScrollView *EmailScroll;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailSubmit;
- (IBAction)EmailSubmitClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *PasswordScroll;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
- (IBAction)PasswordSubmitClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPasswordSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnBackToLogin;
- (IBAction)BackToLogin:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *gobackView;
@property (strong, nonatomic) IBOutlet UIButton *goBackBtn;
- (IBAction)goBackClicked:(id)sender;

@end
