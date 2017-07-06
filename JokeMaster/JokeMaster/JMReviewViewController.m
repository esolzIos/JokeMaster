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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
    Rate=0;
    urlobj=[[UrlconnectionObject alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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

#pragma mark - Submit Click
- (IBAction)submitClicked:(id)sender
{
    [_commentTxt resignFirstResponder];
    [_mainScroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
    
    if (Rate>0)
    {
        [self ReviewApi];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Please Rate the Video.",nil)];
    }
}
#pragma mark - Rating Click
- (IBAction)oneClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
    
    [_two setBackgroundColor:[UIColor whiteColor]];
        [_three setBackgroundColor:[UIColor whiteColor]];
        [_four setBackgroundColor:[UIColor whiteColor]];
        [_five setBackgroundColor:[UIColor whiteColor]];
    Rate=1;
    
}

- (IBAction)twoClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_three setBackgroundColor:[UIColor whiteColor]];
    [_four setBackgroundColor:[UIColor whiteColor]];
    [_five setBackgroundColor:[UIColor whiteColor]];
       [_two setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
    Rate=2;
}

- (IBAction)threeClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_two setBackgroundColor:[UIColor whiteColor]];
    [_four setBackgroundColor:[UIColor whiteColor]];
    [_five setBackgroundColor:[UIColor whiteColor]];
       [_three setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
    Rate=3;
}

- (IBAction)fourClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_two setBackgroundColor:[UIColor whiteColor]];
    [_three setBackgroundColor:[UIColor whiteColor]];
    [_five setBackgroundColor:[UIColor whiteColor]];
    
     [_four setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
    Rate=4;
}

- (IBAction)fiveClicked:(id)sender {
    
    [_one setBackgroundColor:[UIColor whiteColor]];
    [_two setBackgroundColor:[UIColor whiteColor]];
    [_three setBackgroundColor:[UIColor whiteColor]];
    [_four setBackgroundColor:[UIColor whiteColor]];
    
       [_five setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
    Rate=5;
}
#pragma mark -Review API
-(void)ReviewApi
{
    
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.view.userInteractionEnabled = NO;
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Useraction/commentrating?user_id=%@&videoid=%@&rating=%ld&comment=%@",GLOBALAPI,[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],_VideoId,(long)Rate,_commentTxt.text];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 //  [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==1)
                     {
                        
                         [SVProgressHUD dismiss];
                         [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
                         
                     }
                     else
                     {
                         
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
     
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     
                 }
                 else
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       // [self checkLoader];
                                       self.view.userInteractionEnabled = YES;
                                      
                                       NSLog(@"Failure");
                                       //                                       [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       
                                   }
             ];
        }];
    }
    else
    {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
    }
}
#pragma mark -After success pop view controller called
-(void)GotoNextPageAfterSuccess
{
    [self POPViewController];
}
#pragma mark - textview delegate
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [textView becomeFirstResponder];
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         if (IsIphone4)
                         {
                             if (textView==_commentTxt)
                             {
                                 [_mainScroll setContentOffset:CGPointMake(0.0f,160.0f) animated:YES];
                             }
                             
                         }
                         else if (IsIphone5)
                         {
                             if (textView==_commentTxt)
                             {
                                 [_mainScroll setContentOffset:CGPointMake(0.0f,160.0f) animated:YES];
                             }
                            
                             
                         }
                         else if (IsIphone6)
                         {
                             if (textView==_commentTxt)
                             {
                                 [_mainScroll setContentOffset:CGPointMake(0.0f,220.0f) animated:YES];
                             }
                           
                             
                         }
                         else if (IsIphone6plus)
                         {
                             if (textView==_commentTxt)
                             {
                                 [_mainScroll setContentOffset:CGPointMake(0.0f,240.0f) animated:YES];
                             }
                             
                             
                         }
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         if([text isEqualToString:@"\n"])
                         {
                             [textView resignFirstResponder];
                             [_mainScroll setContentOffset:CGPointMake(0.0f,0.0f) animated:YES];
                             
                         }
                         
                     }
                     completion:^(BOOL finished)
    {
        
                     }
     ];

   
    
    return YES;
}
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
