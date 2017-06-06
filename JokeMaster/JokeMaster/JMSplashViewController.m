//
//  JMSplashViewController.m
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMSplashViewController.h"
#import "JMLoginViewController.h"
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
    JMLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMLogin"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
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
