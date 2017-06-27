//
//  JMSplashViewController.m
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMSplashViewController.h"
#import "JMLanguageViewController.h"
#import "JMHomeViewController.h"
#import "JMChooseCountryViewController.h"
@interface JMSplashViewController ()
{
    NSURLSession *session;
    AppDelegate *app;
}
@end

@implementation JMSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self performSelector:@selector(LoadHome) withObject:nil afterDelay:3.0];
    // Do any additional setup after loading the view.
}

-(void)LoadHome
{
 
 
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"langId"] length]>0) {
        
     
    
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"countryId"] length]>0) {
            
            
            
            
            JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
            
            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
        }
        else{
            JMChooseCountryViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMChooseCountryViewController"];
            
            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
        }
    }
    else{
    
        JMLanguageViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMLanguage"];
        
        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
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

@end
