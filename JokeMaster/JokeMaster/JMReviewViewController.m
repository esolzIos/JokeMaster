//
//  JMReviewViewController.m
//  JokeMaster
//
//  Created by santanu on 22/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMReviewViewController.h"

@interface JMReviewViewController ()

@end

@implementation JMReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
          [self setRoundCornertoView:_one withBorderColor:[UIColor clearColor] WithRadius:0.15];
       [self setRoundCornertoView:_two withBorderColor:[UIColor clearColor] WithRadius:0.15];
       [self setRoundCornertoView:_three withBorderColor:[UIColor clearColor] WithRadius:0.15];
       [self setRoundCornertoView:_four withBorderColor:[UIColor clearColor] WithRadius:0.15];
       [self setRoundCornertoView:_five withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    
    [_rateTitle setFont:[UIFont fontWithName:_rateTitle.font.fontName size:[self getFontSize:_rateTitle.font.pointSize]]];
    
     [_commentTitle setFont:[UIFont fontWithName:_commentTitle.font.fontName size:[self getFontSize:_commentTitle.font.pointSize]]];
    
    
    [_commentTxt setFont:[UIFont fontWithName:_commentTxt.font.fontName size:[self getFontSize:_commentTxt.font.pointSize]]];
    
    
    [_submitBtn.titleLabel setFont:[UIFont fontWithName:_submitBtn.titleLabel.font.fontName size:[self getFontSize:_submitBtn.titleLabel.font.pointSize]]];
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

- (IBAction)submitClicked:(id)sender {
}
- (IBAction)oneClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
    
    [_two setBackgroundColor:[UIColor whiteColor]];
        [_three setBackgroundColor:[UIColor whiteColor]];
        [_four setBackgroundColor:[UIColor whiteColor]];
        [_five setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (IBAction)twoClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_three setBackgroundColor:[UIColor whiteColor]];
    [_four setBackgroundColor:[UIColor whiteColor]];
    [_five setBackgroundColor:[UIColor whiteColor]];
       [_two setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
}

- (IBAction)threeClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_two setBackgroundColor:[UIColor whiteColor]];
    [_four setBackgroundColor:[UIColor whiteColor]];
    [_five setBackgroundColor:[UIColor whiteColor]];
       [_three setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
}

- (IBAction)fourClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_two setBackgroundColor:[UIColor whiteColor]];
    [_three setBackgroundColor:[UIColor whiteColor]];
    [_five setBackgroundColor:[UIColor whiteColor]];
    
     [_four setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
}

- (IBAction)fiveClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_two setBackgroundColor:[UIColor whiteColor]];
    [_three setBackgroundColor:[UIColor whiteColor]];
    [_four setBackgroundColor:[UIColor whiteColor]];
    
       [_five setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
}
@end
