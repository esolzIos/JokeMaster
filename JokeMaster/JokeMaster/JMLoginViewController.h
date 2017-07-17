//
//  JMLoginViewController.h
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMRegistrationViewController.h"
@interface JMLoginViewController : JMGlobalMethods
{
    UrlconnectionObject *urlobj;
}
@property (strong, nonatomic) IBOutlet UIView *emailView;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;
@property (strong, nonatomic) IBOutlet UIView *passView;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *fbView;
@property (strong, nonatomic) IBOutlet UIButton *fbBtn;
- (IBAction)fbClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *googleView;
@property (strong, nonatomic) IBOutlet UIButton *googleBtn;
- (IBAction)googleClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *infoTxt;
@property (strong, nonatomic) IBOutlet UIButton *signupBtn;
- (IBAction)signUpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
- (IBAction)ForgotPasswordClick:(id)sender;

@end
