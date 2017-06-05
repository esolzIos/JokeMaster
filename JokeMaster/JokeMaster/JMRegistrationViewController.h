//
//  JMRegistrationViewController.h
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"

@interface JMRegistrationViewController : JMGlobalMethods
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *ProfileImageLabel;
@property (weak, nonatomic) IBOutlet UITextField *Nametxt;
@property (weak, nonatomic) IBOutlet UITextField *Emailtxt;
@property (weak, nonatomic) IBOutlet UITextField *Passwordtxt;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPassword;

@property (weak, nonatomic) IBOutlet UIView *LanguageView;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
- (IBAction)SignUpTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *Logintxtvw;

@end
