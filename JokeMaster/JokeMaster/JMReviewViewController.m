//
//  JMReviewViewController.m
//  JokeMaster
//
//  Created by santanu on 22/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMReviewViewController.h"
#import "JMHomeViewController.h"
@interface JMReviewViewController ()
{
    NSURLSession *session;
    
}
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
    
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    
    if ([_userRating intValue]>0) {
        [_rateView setUserInteractionEnabled:NO];
    
        
        switch ([_userRating intValue]) {
            case 1:
                [_one setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
                
                [_two setBackgroundColor:[UIColor whiteColor]];
                [_three setBackgroundColor:[UIColor whiteColor]];
                [_four setBackgroundColor:[UIColor whiteColor]];
                [_five setBackgroundColor:[UIColor whiteColor]];
                Rate=1;
                break;
            case 2:
                [_one setBackgroundColor:[UIColor whiteColor]];
                [_three setBackgroundColor:[UIColor whiteColor]];
                [_four setBackgroundColor:[UIColor whiteColor]];
                [_five setBackgroundColor:[UIColor whiteColor]];
                [_two setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
                Rate=2;
                break;
            case 3:
                [_one setBackgroundColor:[UIColor whiteColor]];
                [_two setBackgroundColor:[UIColor whiteColor]];
                [_four setBackgroundColor:[UIColor whiteColor]];
                [_five setBackgroundColor:[UIColor whiteColor]];
                [_three setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
                Rate=3;
                break;
            case 4:
                [_one setBackgroundColor:[UIColor whiteColor]];
                [_two setBackgroundColor:[UIColor whiteColor]];
                [_three setBackgroundColor:[UIColor whiteColor]];
                [_five setBackgroundColor:[UIColor whiteColor]];
                
                [_four setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
                Rate=4;
                break;
            case 5:
                [_one setBackgroundColor:[UIColor whiteColor]];
                [_two setBackgroundColor:[UIColor whiteColor]];
                [_three setBackgroundColor:[UIColor whiteColor]];
                [_four setBackgroundColor:[UIColor whiteColor]];
                
                [_five setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:65.0/255.0 blue:42.0/255.0 alpha:1]];
                Rate=5;
                break;
                
            default:
                break;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
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
            [_submitBtn setUserInteractionEnabled:false];
        
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
    
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Useraction/commentrating?user_id=%@&videoid=%@&rating=%ld&comment=%@&mode=%@",GLOBALAPI,[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"],_VideoId,(long)Rate,_commentTxt.text,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [_gifImage setHidden:YES];
                [_noVideoView setHidden:NO];
                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                [_loaderBtn setHidden:NO];
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    // [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        [_loaderView setHidden:YES];
                        
                        
                         //[SVProgressHUD dismiss];
                         [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
                         
                     }
                    
                    else{
                        
                        //                            if (langArr.count==0) {
                        //
                        //                                [SVProgressHUD dismiss];
                        //                          }
                        //                            else{
                        //                                [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                            }
                        
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
        //  [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
}
#pragma mark -After success pop view controller called
-(void)GotoNextPageAfterSuccess
{
//    JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
//    
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    
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
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_noVideoView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
   [self ReviewApi];
    
    
    
    
    
}

#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
