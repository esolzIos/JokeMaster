//
//  JMLanguageViewController.m
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMLanguageViewController.h"
#import "JMChooseCountryViewController.h"
@interface JMLanguageViewController ()

@end

@implementation JMLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_languageLbl setFont:[UIFont fontWithName:_languageLbl.font.fontName size:[self getFontSize:_languageLbl.font.pointSize]]];
    [_chooseBtn.titleLabel setFont:[UIFont fontWithName:_chooseBtn.titleLabel.font.fontName size:[self getFontSize:_chooseBtn.titleLabel.font.pointSize]]];

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

- (IBAction)chooseClicked:(id)sender {
    

}
- (IBAction)goClicked:(id)sender {
    JMChooseCountryViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMChooseCountryViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
@end
