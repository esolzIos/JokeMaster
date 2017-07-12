//
//  JMHomeViewController.m
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMRecentlyUploadedViewController.h"
@interface JMHomeViewController ()
{
    BOOL liked,jokeNotFound;
    NSDictionary *jsonResponse;

    NSDictionary *jokeDict;
    NSURLSession *session;
    AppDelegate *appDelegate;
}
@end

@implementation JMHomeViewController


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait + UIInterfaceOrientationMaskPortraitUpsideDown;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadJokes) name:@"videoLoaded" object:nil];
    
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
            [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self addMoreView:self.view];
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [_jokeTitle setFont:[UIFont fontWithName:_jokeTitle.font.fontName size:[self getFontSize:_jokeTitle.font.pointSize]]];
    
    [_categoryBtnlbl setFont:[UIFont fontWithName:_categoryBtnlbl.font.fontName size:[self getFontSize:_categoryBtnlbl.font.pointSize]]];
    
    [_recentBtn.titleLabel setFont:[UIFont fontWithName:_recentBtn.titleLabel.font.fontName size:[self getFontSize:_recentBtn.titleLabel.font.pointSize]]];
    
    [_VideoNameLabel setFont:[UIFont fontWithName:_VideoNameLabel.font.fontName size:[self getFontSize:_VideoNameLabel.font.pointSize]]];
    
    [_VideoCreaterNameLabel setFont:[UIFont fontWithName:_VideoCreaterNameLabel.font.fontName size:[self getFontSize:_VideoCreaterNameLabel.font.pointSize]]];
    
    [_VideoRatingLabel setFont:[UIFont fontWithName:_VideoRatingLabel.font.fontName size:[self getFontSize:_VideoRatingLabel.font.pointSize]]];
    
    
    [_jokeTitle setText:AMLocalizedString(@"JOKE OF THE DAY", nil)];
    
    [_categoryBtnlbl setText:AMLocalizedString(@"CHOOSE CATEGORY", nil)];
    
    [_recentBtn setTitle:AMLocalizedString(@"RECENTLY UPLOADED VIDEOS", nil) forState:UIControlStateNormal];
    
    
    [self.HeaderView.langBtn addTarget:self action:@selector(langClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //    MenuViewY=_MenuBaseView.frame.origin.y;
    //
    //    _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
    //    _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
    //
    //    CategoryArray=[[NSMutableArray alloc] initWithObjects:@"LATEST",@"SEXUAL JOKES",@"ANIMAL JOKES",@"DOCTORS JOKES",@"GIRLFRIEND JOKES",@"STUPID JOKES", nil];
    
    
    // Do any additional setup after loading the view.
    
    urlobj=[[UrlconnectionObject alloc] init];
    
    [_ratingBtnOne addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnTwo addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnThree addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnFour addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnFive addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];

    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_errorView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    RecentVideoArray=[[NSMutableArray alloc] init];
    jokeDict=[[NSDictionary alloc]init];
    
    [self getJokeOftheDay];
    
 
}
-(void)reloadJokes
{
    RecentVideoArray=[[NSMutableArray alloc] init];
    jokeDict=[[NSDictionary alloc]init];
    
    [self getJokeOftheDay];
}

#pragma mark -Joke of the Day API
-(void)getJokeOftheDay
{
    
     [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        //   [SVProgressHUD show];
        
        
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@%@Video/jokeoftheday?language=%@&country=%@&userid=%@&mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"],appDelegate.userId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [self  JokeNotFound];
                
                [self RecentVideoApi];
                
//                
//                [_gifImage setHidden:YES];
//                [_noVideoView setHidden:NO];
//                [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
//                [_loaderBtn setHidden:NO];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                      [self  JokeNotFound];
                    
                          [self RecentVideoApi];
                    
                    
                    
//                    [_gifImage setHidden:YES];
//                    [_noVideoView setHidden:NO];
//                    [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
//                    [_loaderBtn setHidden:NO];
                    
                    //  [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {

                  //   [SVProgressHUD dismiss];
                     
              
                        // _tvView.hidden=NO;
                        
       
                        [_VideoRatingView setHidden:NO];
                        [_VideoRatingLabel setHidden:NO];
                        [_VideoCreaterNameLabel setHidden:NO];
                        [_VideoNameLabel setHidden:NO];
                        [_jokeDetailBtn setUserInteractionEnabled:YES];
                        [_ratingBtn setUserInteractionEnabled:YES];
                        
                             if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"HomeVisited"] boolValue]==YES)
                             {
                                 _tutorialView.hidden=YES;
                             }
                             else
                             {
                                 _tutorialView.hidden=NO;
                             }
                             
                             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HomeVisited"];
                             
                              jokeDict=[jsonResponse objectForKey:@"videoDetails"];
                         
                         
                             _VideoNameLabel.text=[jokeDict objectForKey:@"videoname"];
                             _VideoCreaterNameLabel.text=[jokeDict objectForKey:@"username"];
                             _VideoRatingLabel.text=[NSString stringWithFormat:@"%@/5",[jokeDict objectForKey:@"averagerating"]];
                             
                             
                             _VideoRatingView.maximumValue = 5;
                             _VideoRatingView.minimumValue = 0;
                             _VideoRatingView.value =[[jokeDict objectForKey:@"averagerating"] floatValue];
                             _VideoRatingView.userInteractionEnabled=NO;
                             //    _RatingView.tintColor = [UIColor clearColor];
                             _VideoRatingView.allowsHalfStars = YES;
                             _VideoRatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                             _VideoRatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                             _VideoRatingView.accurateHalfStars = YES;
                             _VideoRatingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                             
                             [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[jokeDict objectForKey:@"videoimagename"] ] placeholderImage:[UIImage imageNamed: @"noimage"]];
                             
                             
                             liked=[[jokeDict objectForKey:@"like"]boolValue];
                         
                             
                         
                         
                              [self RecentVideoApi];
                         
                      
                         
                     }
                    else{
                        
                [self  JokeNotFound];
             [self RecentVideoApi];
                            
//                            [_gifImage setHidden:YES];
//                            [_noVideoView setHidden:NO];
//                            [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n Click to retry",[jsonResponse objectForKey:@"message"]]];
//                            [_loaderBtn setHidden:NO];
                     
                        
                        
                    }
                    
                }
                
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"Check your Internet connection\n\n Click to retry"]];
        [_loaderBtn setHidden:NO];
        
         [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
          //    [self RecentVideoApi];
    }
    

}

-(void)rateVideo:(UIButton *)btn
{
    
    if([self networkAvailable])
    {
        
        
        
        [SVProgressHUD show];
        
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@%@Useraction/commentrating?user_id=%@&videoid=%@&rating=%d&comment=&mode=%@",GLOBALAPI,INDEX,appDelegate.userId,[jokeDict objectForKey:@"id"],(int)btn.tag,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            
            
            if (error) {
                NSLog(@"error = %@", error);
                
                //                [_gifImage setHidden:YES];
                //                [_noVideoView setHidden:NO];
                //                [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                //                [_loaderBtn setHidden:NO];
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
             jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                    //                    [_gifImage setHidden:YES];
                    //                    [_noVideoView setHidden:NO];
                    //                    [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                    //                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    [_ratingView setHidden:YES];
                    self.view.userInteractionEnabled = YES;
                    
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
       
                         
                         [SVProgressHUD dismiss];
                         
                        [self reloadJokes];
                     }
                     else
                     {
                         
                         [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                         
                     }
                     
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        //
        //        [_gifImage setHidden:YES];
        //        [_noVideoView setHidden:NO];
        //        [_noVideoLbl setText:[NSString stringWithFormat:@"Check your Internet connection\n\n Click to retry"]];
        //        [_loaderBtn setHidden:NO];
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
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
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - Category button click
- (IBAction)categoryClicked:(id)sender
{
    //    _TransparentView.hidden=NO;
    //    _MenuBaseView.hidden=NO;
    //
    //
    //    [UIView animateWithDuration:0.5
    //                          delay:0.1
    //                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
    //                     animations:^{
    //                         _TransparentView.frame = CGRectMake(0, 0, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
    //                         _MenuBaseView.frame = CGRectMake(0,MenuViewY, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
    //                     }
    //                     completion:^(BOOL finished){
    //                     }];
    
    JMJokesCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMJokesCategoryVideoListViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

#pragma mark collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([RecentVideoArray count]==0)
    {
        return 10;
    }
    else
    {
        return [RecentVideoArray count];
    }
    
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    JokeCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jokeCell" forIndexPath:indexPath];
    
    if ([RecentVideoArray count]==0)
    {
        ccell.jokeThumb.image=[UIImage imageNamed: @"noimage"];
    }
    else
    {
        [ccell.jokeThumb sd_setImageWithURL:[NSURL URLWithString:[[RecentVideoArray objectAtIndex:indexPath.row]objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
    }
    
    
    
    return ccell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([RecentVideoArray count]==0)
    {
        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Video not found",nil)];
    }
    else
    {
        JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
        VC.VideoId=[[RecentVideoArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    return CGSizeMake(125.0f/320.0*FULLWIDTH, 90.0f/480.0*FULLHEIGHT);
}
#pragma mark - tutorial view click
- (IBAction)tutorialClicked:(id)sender {
    
    [_tutorialView setHidden:YES];
    
}
#pragma mark - recent button click
- (IBAction)recentClicked:(id)sender {
    
    JMRecentlyUploadedViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMRecentlyUploadedViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)jokeDetailClicked:(id)sender {
    
    //    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    [anim setToValue:[NSNumber numberWithFloat:0.0f]];
    //    [anim setFromValue:[NSNumber numberWithDouble:M_PI/16]]; // rotation angle
    //    [anim setDuration:0.1];
    //    [anim setRepeatCount:NSUIntegerMax];
    //    [anim setAutoreverses:YES];
    //    [[_ratingImage layer] addAnimation:anim forKey:@"iconShake"];
    
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.4;
    anim.toValue = [NSNumber numberWithFloat:0.8];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [anim setRepeatCount:NSUIntegerMax];
    [anim setAutoreverses:YES];
    
    [[_ratingImage layer] addAnimation:anim forKey:nil];
    
    
    if (liked) {
        [_likeImage setImage:[UIImage imageNamed:@"like"]];
        
    }
    else{
        [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
    }
    [_optionView setHidden:NO];
    
}
- (IBAction)ratingClicked:(id)sender {
    [_ratingImage.layer removeAllAnimations];
    
    if (appDelegate.isLogged) {
       [_ratingView setHidden:NO];
    }
    else{
        [SVProgressHUD showInfoWithStatus:@"Login required to rate videos"];
    }
    
    
}
- (IBAction)likeClicked:(id)sender {
    
      if (appDelegate.isLogged) {
    
    if([self networkAvailable])
    {
        
        [_likeBtn setUserInteractionEnabled:NO];
        
        
        
        
        [SVProgressHUD show];
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/useraction/likeunlikevideo?videoid=21&userid=1
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@useraction/likeunlikevideo",GLOBALAPI,INDEX]];
        
        // configure the request
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        
        
        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSString *sendData = @"videoid=";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",[jokeDict objectForKey:@"id"]]];
        
        sendData = [sendData stringByAppendingString:@"&userid="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userId]];
        
        sendData = [sendData stringByAppendingString:@"&mode="];
        sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
        sendData = [sendData stringByAppendingString:@"&pushmode="];
        sendData = [sendData stringByAppendingString: PUSHTYPE];
   
        
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSMutableData *theBodyData = [NSMutableData data];
        
        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
        
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [SVProgressHUD showErrorWithStatus:@"Some error occured"];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *Response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                [_likeBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"Some error occured"];
                    
                    
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                    [SVProgressHUD dismiss];
                    
                    NSLog(@"result = %@",Response);
                    
                    
                    if ([[Response objectForKey:@"status"]boolValue]) {
                        
                        
                        if (liked) {
                            [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
                            liked=false;
                            
                            
                        }
                        else{
                            [_likeImage setImage:[UIImage imageNamed:@"like"]];
                            
                            liked=true;
                        }                        
                        
                    }
                    
                    else{
                        
                        [SVProgressHUD showInfoWithStatus:[Response objectForKey:@"message"]];
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
            }
        }];
        
        
        [task resume];
        
        
    }
    else{
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
    }
    

      }
      else{
          [SVProgressHUD showInfoWithStatus:@"Login required to like videos"];
      }
    
 
    //[_optionView setHidden:YES];
    //  [_ratingImage.layer removeAllAnimations];
    
}
#pragma mark - play button click
- (IBAction)playClicked:(id)sender {
    
    if ([jokeDict valueForKey:@"id"]==nil)
    {
        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Video not found",nil)];
    }
    else
    {
        [_optionView setHidden:YES];
        [_ratingImage.layer removeAllAnimations];
        JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
        VC.VideoId=[jokeDict valueForKey:@"id"];
        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
   
}
- (IBAction)shareClicked:(id)sender {
    [_ratingImage.layer removeAllAnimations];
    [_optionView setHidden:YES];
}

-(void)langClicked
{
    
    
}
//#pragma mark - Category view hide
//- (IBAction)CategoryCrossTapped:(id)sender
//{
//
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
//                     animations:^{
//                         _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
//                         _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
//
//                     }
//                     completion:^(BOOL finished){
//
//                         JMJokesCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMJokesCategoryVideoListViewController"];
//
//                         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//                         
//                     }];
//}
- (IBAction)crossClicked:(id)sender {
    
    [_ratingView setHidden:YES];
    
}
#pragma mark -Recent Video list API
-(void)RecentVideoApi
{
    
    
    if([self networkAvailable])
    {
        
        
        
        //   [SVProgressHUD show];
        
        
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@%@Video?categoryid=&language=%@&country=%@&userid=&page=1&limit=10&mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                if (jokeNotFound) {
                    [_gifImage setHidden:YES];
                    [_errorView setHidden:NO];
                    [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                    [_loaderBtn setHidden:NO];
                }
                else{
                
                    [_jokeCollectionView setUserInteractionEnabled:false];
                    
                }
          
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    if (jokeNotFound) {
                        [_gifImage setHidden:YES];
                        [_errorView setHidden:NO];
                        [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                        [_loaderBtn setHidden:NO];
                    }
                    else{
                        
                        [_jokeCollectionView setUserInteractionEnabled:false];
                        
                    }
                    
                    
                    //  [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                                     [_loaderView setHidden:YES];
                        
                         RecentVideoArray=[[jsonResponse objectForKey:@"videoDetails"] mutableCopy];
                         
                         
                         if (RecentVideoArray.count>0)
                         {
                           //  _tvView.hidden=NO;
                         //    _recentBtn.userInteractionEnabled=YES;
                             
                    
                             [_jokeCollectionView reloadData];
                         }
                         else
                         {
                           //  _recentBtn.userInteractionEnabled=NO;
                         }
                         
                     }
                    else{
                        
                    
                        if (jokeNotFound) {
                            [_gifImage setHidden:YES];
                            [_errorView setHidden:NO];
                            [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                            [_loaderBtn setHidden:NO];
                        }
                        else{
                            
                            [_jokeCollectionView setUserInteractionEnabled:false];
                            
                        }
                        
                 
                        
                        
                    }
                    
                }
                
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        if (jokeNotFound) {
            [_gifImage setHidden:YES];
            [_errorView setHidden:NO];
            [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
            [_loaderBtn setHidden:NO];
        }
        else{
            
            [_jokeCollectionView setUserInteractionEnabled:false];
            
        }
        
        // [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
}
#pragma mark -Video not found
-(void)JokeNotFound
{
    jokeNotFound=true;
    
   // _tvView.hidden=NO;
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"HomeVisited"] boolValue]==YES)
//    {
//        _tutorialView.hidden=YES;
//    }
//    else
//    {
//        _tutorialView.hidden=NO;
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HomeVisited"];
    
    [_noVideoView setHidden:NO];
    
  
    [_VideoRatingView setHidden:YES];
    [_VideoRatingLabel setHidden:YES];
    [_VideoCreaterNameLabel setHidden:YES];
    [_VideoNameLabel setHidden:YES];
    [_jokeDetailBtn setUserInteractionEnabled:NO];
    [_ratingBtn setUserInteractionEnabled:NO];
    
    
//    _VideoRatingView.maximumValue = 5;
//    _VideoRatingView.minimumValue = 0;
//    _VideoRatingView.value =4;
//    _VideoRatingView.userInteractionEnabled=NO;
//    //    _RatingView.tintColor = [UIColor clearColor];
//    _VideoRatingView.allowsHalfStars = YES;
//    _VideoRatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    _VideoRatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    _VideoRatingView.accurateHalfStars = YES;
//    _VideoRatingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
}
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_errorView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
    RecentVideoArray=[[NSMutableArray alloc] init];
    jokeDict=[[NSDictionary alloc]init];
    
    [self getJokeOftheDay];
    
    
    
}
@end
