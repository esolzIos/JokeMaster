//
//  JMUploadVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMUploadVideoViewController.h"

@interface JMUploadVideoViewController ()

@end

@implementation JMUploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
            [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    // Do any additional setup after loading the view.
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

- (IBAction)Test:(id)sender
{
    DebugLog(@"testtttt");
}
- (IBAction)uploadClicked:(id)sender {
}
- (IBAction)cameraClicked:(id)sender {
}
- (IBAction)galleryClicked:(id)sender {
}
@end
