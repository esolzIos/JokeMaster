//
//  JMForgotPasswordViewController.h
//  JokeMaster
//
//  Created by priyanka on 14/07/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"

@interface JMForgotPasswordViewController : JMGlobalMethods
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


@end
