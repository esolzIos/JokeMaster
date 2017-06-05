//
//  JMRegistrationViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMRegistrationViewController.h"

@interface JMRegistrationViewController ()

@end

@implementation JMRegistrationViewController
@synthesize Nametxt,Emailtxt,Passwordtxt,ProfileImage,ProfileImageLabel,ConfirmPassword,mainscroll,Logintxtvw,LanguageView,LanguageLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIFont *font1 = [UIFont fontWithName:@"comicbd_1.ttf" size:14];
//    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
//    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Back to ",nil) attributes: arialDict];
//    [aAttrString1 addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor whiteColor]
//                         range:NSMakeRange(0, [aAttrString1 length])];
//    
//    UIFont *font2 = [UIFont fontWithName:@"comicbd_1.ttf" size:17];
//    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject:font2 forKey:NSFontAttributeName];
//    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Log in",nil) attributes: arialDict2];
//    [aAttrString2 addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor whiteColor]
//                         range:NSMakeRange(0, [aAttrString2 length])];
//    
//    [aAttrString1 appendAttributedString:aAttrString2];
//    Logintxtvw.attributedText = aAttrString1;
//    Logintxtvw.textAlignment = NSTextAlignmentCenter;
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

- (IBAction)SignUpTapped:(id)sender {
}
@end
