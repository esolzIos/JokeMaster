//
//  JMPlayVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMPlayVideoViewController.h"
#import "ReviewsTableViewCell.h"
#import "JMReviewViewController.h"
#import "JMProfileViewController.h"
@interface JMPlayVideoViewController ()<AVPlayerViewControllerDelegate>
{
AVPlayer *player;
    
    BOOL paused,inFullscreen,fontSet;
    
    AppDelegate *app;
        BOOL liked,viewed;
    int totalCount,page;
    NSURLSession *session;
    NSMutableArray *reviewArr;
    UIFont *nameFont,*dateFont,*reviewFont,*ratingFont;
    
}
@end

@implementation JMPlayVideoViewController
@synthesize VideoId,mainscroll;
-(void)viewDidAppear:(BOOL)animated
{
    
   DebugLog(@"video details %@",VideoDictionary);

      if (inFullscreen) {
        [_optionView setHidden:NO];
        inFullscreen=NO;
        CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anim.duration = 0.4;
        anim.toValue = [NSNumber numberWithFloat:0.8];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        
        [anim setRepeatCount:NSUIntegerMax];
        [anim setAutoreverses:YES];
        
        [[_ratingImage layer] addAnimation:anim forKey:nil];
          
                      _seekSlider.value = CMTimeGetSeconds( player.currentItem.currentTime);
              
              AVPlayerItem *currentItem = player.currentItem;
              NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
              
              NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
              NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
              
              NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
              
              DebugLog(@"time: %@",videoDurationText);
              
              
              [_timeLbl setText:[NSString stringWithFormat:@"%@",videoDurationText]];
     

          CMTime showingTime = CMTimeMake(_seekSlider.value *1000, 1000);
          
          [player seekToTime:showingTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
          
          paused=true;
          [_playPauseImg setImage:[UIImage imageNamed:@"play-1"]];
          [player pause];
          

    }
    else{
        
        urlobj=[[UrlconnectionObject alloc] init];
        
        
     
        
        
        [self VideoDetailsApi];
        
        }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
        [_reviewTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
[_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateNormal];
    [_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateSelected];
    [_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateHighlighted];
  ;
    

    
    // show the view controller
      [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
          [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
      [self setRoundCornertoView:_playerView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    
    [_VideoNameLabel setFont:[UIFont fontWithName:_VideoNameLabel.font.fontName size:[self getFontSize:_VideoNameLabel.font.pointSize]]];
    
    [_viewCountLbl setFont:[UIFont fontWithName:_viewCountLbl.font.fontName size:[self getFontSize:_viewCountLbl.font.pointSize]]];
    
      [_ratingLbl setFont:[UIFont fontWithName:_ratingLbl.font.fontName size:[self getFontSize:_ratingLbl.font.pointSize]]];
    
        [_ownerName setFont:[UIFont fontWithName:_ownerName.font.fontName size:[self getFontSize:_ownerName.font.pointSize]]];
    
            [_rankLbl setFont:[UIFont fontWithName:_rankLbl.font.fontName size:[self getFontSize:_rankLbl.font.pointSize]]];
    
        [_reviewsLbl setFont:[UIFont fontWithName:_reviewsLbl.font.fontName size:[self getFontSize:_reviewsLbl.font.pointSize]]];
    
        [_commentTitle setFont:[UIFont fontWithName:_commentTitle.font.fontName size:[self getFontSize:_commentTitle.font.pointSize]]];
    
    
    [_ratingBtnOne addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnTwo addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnThree addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnFour addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnFive addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return reviewArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"reviewCell";
    
    ReviewsTableViewCell *cell = (ReviewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    
    return cell;
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (IsIphone5 || IsIphone4)
//    {
//        return 50;
//    }
//    else
//    {
//        return 60;
//    }
    
    return 100.0/480.0*FULLHEIGHT;
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(ReviewsTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *reviewDict=[reviewArr objectAtIndex:indexPath.row];
    
    
    [self setRoundCornertoView:cell.userImage withBorderColor:[UIColor clearColor] WithRadius:0.5];
    
    if (!fontSet) {
        
     nameFont =[UIFont fontWithName:cell.userName.font.fontName size:[self getFontSize:cell.userName.font.pointSize]];
       dateFont =[UIFont fontWithName:cell.reviewDate.font.fontName size:[self getFontSize:cell.reviewDate.font.pointSize]];
        ratingFont=[UIFont fontWithName:cell.ratingLbl.font.fontName size:[self getFontSize:cell.ratingLbl.font.pointSize]];
        reviewFont=[UIFont fontWithName:cell.reviewTxt.font.fontName size:[self getFontSize:cell.reviewTxt.font.pointSize]];
        
        fontSet=true;
        
    }
    [cell.userName setFont:nameFont];
    [cell.reviewDate setFont:dateFont];
    [cell.ratingLbl setFont:ratingFont];
    [cell.reviewTxt setFont:reviewFont];
    
    [cell.userName setText:[reviewDict objectForKey:@"username"]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //   [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm a"];
    
    NSDate *Ddate = [formatter dateFromString:[NSString stringWithFormat:@"%@",[reviewDict objectForKey:@"date"]]];
    
    
    
    
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc]init];
    
    [formatter3 setDateFormat:@"dd/MM/YYYY"];
    
    //   [formatter3 setDateStyle: NSDateFormatterLongStyle];
    
    NSString *formattedTime=[formatter3 stringFromDate:Ddate ];
    


    
     [cell.reviewDate setText:formattedTime];
     [cell.ratingLbl setText:[reviewDict objectForKey:[NSString stringWithFormat:@"%@/5",[reviewDict objectForKey:@"userrating"]]]];
     [cell.reviewTxt setText:[reviewDict objectForKey:@"usercomment"]];
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[reviewDict objectForKey:@"userimage"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    cell.ratingView.maximumValue = 5;
    cell.ratingView.minimumValue = 0;
    cell.ratingView.allowsHalfStars = YES;
    cell.ratingView.value =[[reviewDict objectForKey:@"userrating"] floatValue];
    cell.ratingView.userInteractionEnabled=NO;
    //    _RatingView.tintColor = [UIColor clearColor];
    
    cell.ratingView.accurateHalfStars = YES;
    cell.ratingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.ratingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.ratingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)rateVideo:(UIButton *)btn
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
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Useraction/commentrating?user_id=%@&videoid=%@&rating=%d&comment=&mode=%@",GLOBALAPI,app.userId,VideoId,(int)btn.tag,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                        [_rateView setHidden:YES];
                 self.view.userInteractionEnabled = YES;
                 //  [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==1)
                     {
                         
                         [SVProgressHUD dismiss];
                 
                         
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
- (IBAction)ratingClicked:(id)sender
{
[_ratingImage.layer removeAllAnimations];
        [_rateView setHidden:NO];
}

- (IBAction)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)updateTime:(NSTimer *)timer {
 
 
}
- (IBAction)sliderValueChange:(id)sender {
    
//    int32_t timeScale = player.currentItem.asset.duration.timescale;
//    [player seekToTime:CMTimeMakeWithSeconds(_seekSlider.value,timeScale)];
    
    CMTime showingTime = CMTimeMake(_seekSlider.value *1000, 1000);
    
    [player seekToTime:showingTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
}


- (IBAction)pausePlayClicked:(id)sender
{
    if (!paused) {
        paused=true;
        [_playPauseImg setImage:[UIImage imageNamed:@"play-1"]];
        
        [player pause];
           [_optionView setHidden:NO];
        CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anim.duration = 0.4;
        anim.toValue = [NSNumber numberWithFloat:0.8];
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        
        [anim setRepeatCount:NSUIntegerMax];
        [anim setAutoreverses:YES];
        
        [[_ratingImage layer] addAnimation:anim forKey:nil];

        
    }
    else{
        paused=false;
        [_playPauseImg setImage:[UIImage imageNamed:@"pause"]];
        
        [player play];
        
        [self addViewCount];
        
        [_ratingImage.layer removeAllAnimations];
           [_optionView setHidden:YES];
    }
    
 

}
- (IBAction)likeClicked:(id)sender {
    
    
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
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",[VideoDictionary objectForKey:@"video_id"]]];
        
        sendData = [sendData stringByAppendingString:@"&userid="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",app.userId]];
        
        sendData = [sendData stringByAppendingString:@"&mode="];
        sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
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
- (IBAction)playClicked:(id)sender {
    
     [_ratingImage.layer removeAllAnimations];
    [_optionView setHidden:YES];
    paused=false;
    [_playPauseImg setImage:[UIImage imageNamed:@"pause"]];
  //  [player seekToTime:kCMTimeZero];
    [player play];
    
     [self addViewCount];
    
}
- (IBAction)sharedClicked:(id)sender {
     [_ratingImage.layer removeAllAnimations];
    [_optionView setHidden:YES];
}

- (IBAction)shareClicked:(id)sender {
}
- (IBAction)reportClicked:(id)sender {
}
#pragma mark -Go to Profile Page
- (IBAction)gotoProfile:(id)sender {
    
    JMProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
    VC.ProfileUserId=VideoPosterId;
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

- (IBAction)resizeClicked:(id)sender {
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [controller setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    AVPlayerItem *currentItem = player.currentItem;
    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
    
    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    
    NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
    
    DebugLog(@"resize time: %@",videoDurationText);

      [self.navigationController presentViewController:controller animated:YES completion:nil];
    [controller.player seekToTime:player.currentTime];
    
      [controller.player play];
    inFullscreen=TRUE;
    
    
  
    

}
#pragma mark - status bar white color
- (IBAction)commentClicked:(id)sender {
    
    JMReviewViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMReview"];
    VC.VideoId=[VideoDictionary objectForKey:@"video_id"];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

-(void)playerDidFinishPlaying:(NSNotification *)notification {
    paused=true;
    [_playPauseImg setImage:[UIImage imageNamed:@"play-1"]];
    
  [player seekToTime:kCMTimeZero];
      [_optionView setHidden:NO];
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.4;
    anim.toValue = [NSNumber numberWithFloat:0.8];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [anim setRepeatCount:NSUIntegerMax];
    [anim setAutoreverses:YES];
    
    [[_ratingImage layer] addAnimation:anim forKey:nil];

  }

-(void) viewWillDisappear:(BOOL)animated
{
  [player seekToTime:kCMTimeZero];
    
    [player pause];
    
   

}

- (IBAction)crossClicked:(id)sender {
    
    [_rateView setHidden:YES];
    
}
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -Video Details API
-(void)VideoDetailsApi
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
            
            if (app.isLogged) {
                  urlString=[NSString stringWithFormat:@"%@index.php/Videodetails?videoid=%@&loggedinid=%@&mode=%@",GLOBALAPI,VideoId,app.userId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            }
            else{
                  urlString=[NSString stringWithFormat:@"%@index.php/Videodetails?videoid=%@&loggedinid=&mode=%@",GLOBALAPI,VideoId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            }
          
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                   [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
//                     if ([[NSString stringWithFormat:@"%@",[responseDict objectForKey:@"status"]] isEqualToString:@"Success"])
//                     {
                     
                    // if ([[responseDict objectForKey:@"details"] count]!=0)
                    // {
                         VideoDictionary=[[responseDict objectForKey:@"details"] mutableCopy];
                         
                         liked=[[VideoDictionary objectForKey:@"like"]boolValue];
                         
                         if (liked) {
                             [_likeImage setImage:[UIImage imageNamed:@"like"]];
                             
                         }
                         else{
                             [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
                         }

                         
                         _VideoNameLabel.text=[VideoDictionary objectForKey:@"videoname"];
                         
                         _ownerName.text=[VideoDictionary objectForKey:@"username"];
                         VideoPosterId=[VideoDictionary objectForKey:@"user_id"];
                         
                         
                         _ratingLbl.text=[NSString stringWithFormat:@"%@/5",[VideoDictionary objectForKey:@"video_average_rating"]];
                         
                         _viewCountLbl.text=[NSString stringWithFormat:@"%@ VIEWS",[VideoDictionary objectForKey:@"views"]];
                         
                         _rankLbl.text=[NSString stringWithFormat:@"RANK %@",[VideoDictionary objectForKey:@"rank"]];
                         
                         _ratingView.maximumValue = 5;
                         _ratingView.minimumValue = 0;
                         _ratingView.allowsHalfStars = YES;
                         _ratingView.value =[[VideoDictionary objectForKey:@"video_average_rating"] floatValue];
                         _ratingView.userInteractionEnabled=NO;
                         //    _RatingView.tintColor = [UIColor clearColor];
                       
                         _ratingView.accurateHalfStars = YES;
                         _ratingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                         _ratingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                         _ratingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                         _ratingView.hidden=NO;
                         
                         [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
                         
                          [_ownerImage sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"userimage"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
                         
                         NSURL *videoURL;
                        
                             videoURL = [NSURL URLWithString:[VideoDictionary objectForKey:@"video_file"]];
                         
                         AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
                         
                         player = [AVPlayer playerWithPlayerItem:item];
                         
                         
                         CALayer *superlayer = _playerView.layer;
                         
                         AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
                         [playerLayer setFrame:self.playerView.bounds];
                         playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                         [superlayer addSublayer:playerLayer];
                         
                         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
                         
                         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemPlaybackStalledNotification object:item];
                         
                         
                         // create a player view controller
                         
                         
                         _seekSlider.maximumValue = CMTimeGetSeconds(player.currentItem.asset.duration);
                         _seekSlider.value = 0.0;
                         
                         //  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
                         
                         CMTime interval = CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC);
                         
                         [player addPeriodicTimeObserverForInterval:interval queue:NULL usingBlock:^(CMTime time) {
                             _seekSlider.value = CMTimeGetSeconds( player.currentItem.currentTime);
                             
                             AVPlayerItem *currentItem = player.currentItem;
                             NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
                             
                             NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
                             NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
                             
                             NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
                             
                             DebugLog(@" tracking time: %@",videoDurationText);
                             
                             [_timeLbl setText:[NSString stringWithFormat:@"%@",videoDurationText]];
                         }];
                         
                         [player seekToTime:kCMTimeZero];
                         paused=true;
                         [_playPauseImg setImage:[UIImage imageNamed:@"play-1"]];
                         // [player play];

                         mainscroll.hidden=NO;
                     
                     
                     totalCount=0;
                     page=1;
                     reviewArr=[[NSMutableArray alloc]init];
                     
                     [self getReviews];
                     
                     //}
                    // else
//                     {
//                         // kept for testing purpose-------------------
//                         
//                        
//                         
//                         
//                         _VideoNameLabel.text=[VideoDictionary objectForKey:@"videoname"];
//                         _ratingLbl.text=[NSString stringWithFormat:@"%@/5",[VideoDictionary objectForKey:@"rating"]];
//                         
//                         
//                         _ratingView.maximumValue = 5;
//                         _ratingView.minimumValue = 0;
//                         _ratingView.value =[[VideoDictionary objectForKey:@"rating"] floatValue];
//                         _ratingView.userInteractionEnabled=NO;
//                         //    _RatingView.tintColor = [UIColor clearColor];
//                         _ratingView.allowsHalfStars = YES;
//                         _ratingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                         _ratingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//                         _ratingView.hidden=NO;
//                         
//                         [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
//                         
//                         NSURL *videoURL;
//                         if ([VideoDictionary count] == 0)
//                         {
//                             _VideoNameLabel.text=@"FUNNY LINNA";
//                             videoURL = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"];
//                             _ratingLbl.text=[NSString stringWithFormat:@"0/5"];
//                             
//                         }
//                         else
//                         {
//                             videoURL = [NSURL URLWithString:[VideoDictionary objectForKey:@"video_file"]];
//                         }
//                         
//                         
//                         
//                         
//                         AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
//                         
//                         player = [AVPlayer playerWithPlayerItem:item];
//                         
//                         
//                         CALayer *superlayer = _playerView.layer;
//                         
//                         AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//                         [playerLayer setFrame:self.playerView.bounds];
//                         playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//                         [superlayer addSublayer:playerLayer];
//                         
//                         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
//                         
//                         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemPlaybackStalledNotification object:item];
//                         
//                         
//                         // create a player view controller
//                         
//                         
//                         _seekSlider.maximumValue = CMTimeGetSeconds(player.currentItem.asset.duration);
//                         _seekSlider.value = 0.0;
//                         
//                         //  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
//                         
//                         CMTime interval = CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC);
//                         
//                         [player addPeriodicTimeObserverForInterval:interval queue:NULL usingBlock:^(CMTime time) {
//                             _seekSlider.value = CMTimeGetSeconds( player.currentItem.currentTime);
//                             
//                             AVPlayerItem *currentItem = player.currentItem;
//                             NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
//                             
//                             NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
//                             NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
//                             
//                             NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
//                             
//                             DebugLog(@" tracking time: %@",videoDurationText);
//                             
//                             [_timeLbl setText:[NSString stringWithFormat:@"%@",videoDurationText]];
//                         }];
//                         
//                         [player seekToTime:kCMTimeZero];
//                         paused=true;
//                         [_playPauseImg setImage:[UIImage imageNamed:@"play-1"]];
//                         
//                         mainscroll.hidden=NO;
//                         
//                     }
                     
                     
                     
                     
                     
//                     }
//                     else
//                     {
//                         
//                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
//                         
//                     }
       
                     
                     
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
                                       
                                        [self checkLoader];
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
-(void)getReviews
{
    
    if([self networkAvailable])
    {
        
        
        
        [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@useraction/reviewlisting?videoid=%@&page=%d&limit=10&mode=%@",GLOBALAPI,INDEX,VideoId,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                

                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
       
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([jsonResponse objectForKey:@"status"]) {
                        
                        
                        
                    NSArray    *tempArr=[[jsonResponse objectForKey:@"reviewdetails"] copy];
                        
                        totalCount=[[jsonResponse objectForKey:@"totalCount"]intValue];
                        
                        
                        
                        [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in tempArr) {
                            
                            [reviewArr addObject:Dict];
                            
                            
                        }
                        
                        
                        
                        if (reviewArr.count>0) {
                            
                            [_reviewTable reloadData];
                            
                            
                        }
                        else{
                            
                            [_reviewTable setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    else{
                        
                        if (reviewArr.count==0) {
                            
                            [SVProgressHUD dismiss];
                        }
                        else{
                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    

    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (scrollView==_reviewTable && totalCount>reviewArr.count)
    {
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        
        float reload_distance = -10.0f;
        
        
        if(y > h + reload_distance)
        {
            
            
            
            page += 1;
            [self getReviews];
            
            
            
        }
    }
}
-(void)addViewCount
{
    if (!viewed) {
       
  
    if([self networkAvailable]  )
    {
        
        
        
        [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@useraction/videoviewcount?videoid=%@&mode=%@",GLOBALAPI,INDEX,VideoId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
          
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
          
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        viewed=true;
                     [SVProgressHUD dismiss];
                        
                        
                        
                    }
                    
                    
                    else{
                        
                    
                            
                            [SVProgressHUD dismiss];
                     
                       
                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                     
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    }
    

}

@end
