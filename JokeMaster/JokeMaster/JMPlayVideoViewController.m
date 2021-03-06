//
//  JMPlayVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//
#define degreeToRadian(x) (M_PI * x / 180.0)
#define radianToDegree(x) (180.0 * x / M_PI)


#import "JMPlayVideoViewController.h"
#import "ReviewsTableViewCell.h"
#import "JMReviewViewController.h"
#import "JMProfileViewController.h"
#import "JMEditVideoViewController.h"
#import "JMRatingListViewController.h"
#import "JMFollowingViewController.h"
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
        AVPlayerViewController *controller;
UITextView *demoTxt;
    NSMutableArray *heightArr;
}
@end

@implementation JMPlayVideoViewController
@synthesize VideoId,mainscroll;

- (void)didChangeOrientation:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        NSLog(@"Landscape");
        
    
       
    
        if (self.childViewControllers.count>0) {
            [controller.view.layer setAffineTransform:CGAffineTransformIdentity];
        }
        
        controller.player = player;
        [controller setVideoGravity:AVLayerVideoGravityResizeAspect];
        
//        AVPlayerItem *currentItem = player.currentItem;
//        NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
//        
//        NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
//        NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
//        
//        NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
//        
//        DebugLog(@"resize time: %@",videoDurationText);
//            [controller.player seekToTime:player.currentTime];
//                [controller.player play];
       // [self.navigationController presentViewController:controller animated:YES completion:nil];
    
        [self addChildViewController:controller];
    [self.view addSubview:controller.view];
         
        controller.view.frame = self.view.frame;
        
    


      //  inFullscreen=TRUE;
        
        
        

    }
    else {
        NSLog(@"Portrait");
        
        UIViewController *vc = [self.childViewControllers lastObject];
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
     [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(didChangeOrientation:)    name:UIDeviceOrientationDidChangeNotification  object:nil];

    controller = [[AVPlayerViewController alloc]init];
    
     [_ratingImage.layer removeAllAnimations];
         [_optionView setHidden:YES];
       [_noreviewLbl setHidden:YES];
    
   DebugLog(@"video details %@",VideoDictionary);

    [_tvView setHidden:YES];
    [_ratingView setHidden:YES];
    [_ratingLbl setHidden:YES];
    [_ownerView setHidden:YES];
    [_reviewHeaderView setHidden:YES];
    [_reviewTable setHidden:YES];
    
    
        [self VideoDetailsApi];
        
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    [self addVideoMoreView:self.view];
    
    
    [self.editBtn addTarget:self action:@selector(editClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.delBtn addTarget:self action:@selector(deleteClicked) forControlEvents:UIControlEventTouchUpInside];
    
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
    
       [_noreviewLbl setFont:[UIFont fontWithName:_noreviewLbl.font.fontName size:[self getFontSize:_noreviewLbl.font.pointSize]]];
    
        [_commentTitle setFont:[UIFont fontWithName:_commentTitle.font.fontName size:[self getFontSize:_commentTitle.font.pointSize]]];
    
            [_favouriteCountBtn.titleLabel setFont:[UIFont fontWithName:_favouriteCountBtn.titleLabel.font.fontName size:[self getFontSize:_favouriteCountBtn.titleLabel.font.pointSize]]];
    
    
    [_reviewsLbl setText:AMLocalizedString(@"reviews", nil)];
       [_commentTitle setText:AMLocalizedString(@"comments", nil)];
    
    
    [_noreviewLbl setText:AMLocalizedString(@"No reviews found", nil)];
    
    [_ratingBtnOne addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnTwo addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnThree addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnFour addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    [_ratingBtnFive addTarget:self action:@selector(rateVideo:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_errorView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
           [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
demoTxt = [[UITextView alloc] init];
    

  
    demoTxt.font = [UIFont systemFontOfSize:[self getFontSize:10.0]];

  

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
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
    
        DebugLog(@"%f",42.0/480.0*FULLHEIGHT + ( [[heightArr objectAtIndex:indexPath.row ] floatValue]));
    
     return 42.0/480.0*FULLHEIGHT + ( [[heightArr objectAtIndex:indexPath.row ] floatValue]);

    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(ReviewsTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *reviewDict=[reviewArr objectAtIndex:indexPath.row];
    
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
       //  [cell.contentView setAutoresizesSubviews:NO];
    
    
    [cell.userImage setFrame:CGRectMake(15.0/320.0*FULLWIDTH, 8.0/480.0*FULLHEIGHT, 34.0/320.0*FULLWIDTH, 30.0/480.0*FULLHEIGHT)];
    
        [cell.userName setFrame:CGRectMake(cell.userName.frame.origin.x, cell.userName.frame.origin.y, 134.0/320.0*FULLWIDTH, 22.0/480.0*FULLHEIGHT)];
    
        [cell.ratingView setFrame:CGRectMake(227.0/320.0*FULLWIDTH, 3.0/480.0*FULLHEIGHT, 79.0/320.0*FULLWIDTH, 21.0/480.0*FULLHEIGHT)];
    
        [cell.ratingLbl setFrame:CGRectMake(228.0/320.0*FULLWIDTH, 21.0/480.0*FULLHEIGHT, 42.0/320.0*FULLWIDTH, 22.0/480.0*FULLHEIGHT)];
    
    
        [cell.reviewDate setFrame:CGRectMake(67.0/320.0*FULLWIDTH, 21.0/480.0*FULLHEIGHT, 134.0/320.0*FULLWIDTH, 22.0/480.0*FULLHEIGHT)];
    
            [cell.deleteView setFrame:CGRectMake(280.0/320.0*FULLWIDTH, 35.0/480.0*FULLHEIGHT, 40.0/320.0*FULLWIDTH, 30.0/480.0*FULLHEIGHT)];
    
    [cell.userBtn setFrame:CGRectMake(15.0/320.0*FULLWIDTH, 5.0/480.0*FULLHEIGHT,185.0/320.0*FULLWIDTH, 30.0/480.0*FULLHEIGHT)];
    
//        [cell.reviewTxt setFrame:CGRectMake(cell.reviewTxt.frame.origin.x, cell.reviewTxt.frame.origin.y, 260.0/320.0*FULLWIDTH, [[heightArr objectAtIndex:indexPath.row]floatValue])];
    
      [cell.reviewTxt setFrame:CGRectMake(15.0/320.0*FULLWIDTH, 41.0/480.0*FULLHEIGHT, 260.0/320.0*FULLWIDTH, [[heightArr objectAtIndex:indexPath.row]floatValue])];
    
    DebugLog(@"%f,%f,%f,%f",cell.reviewTxt.frame.origin.x,cell.reviewTxt.frame.origin.y,cell.reviewTxt.frame.size.width,cell.reviewTxt.frame.size.height);
    
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
    
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    NSDate *Ddate = [formatter dateFromString:[NSString stringWithFormat:@"%@",[reviewDict objectForKey:@"date"]]];
    
    
    
    
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc]init];
    
    [formatter3 setDateFormat:@"dd/MM/YYYY"];
    
    //   [formatter3 setDateStyle: NSDateFormatterLongStyle];
    
    NSString *formattedTime=[formatter3 stringFromDate:Ddate ];
    


    
     [cell.reviewDate setText:formattedTime];
     [cell.ratingLbl setText:[NSString stringWithFormat:@"%@/5",[reviewDict objectForKey:@"userrating"]]];
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

    
    
    [cell.userBtn addTarget:self action:@selector(userReviewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.deleteBtn addTarget:self action:@selector(deleteReviewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[reviewDict objectForKey:@"userid"] isEqualToString:app.userId] || [app.userId isEqualToString:[VideoDictionary objectForKey:@"user_id"]]) {
        
        [cell.deleteView setHidden:NO];
        
    }
    else
    {
      [cell.deleteView setHidden:YES];
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)userReviewClicked:(UIButton *)btn
{
    
    ReviewsTableViewCell *cCell=(ReviewsTableViewCell *)btn.superview.superview.superview;
    
    
    NSIndexPath *index=[_reviewTable indexPathForCell:cCell];
    
    
    NSDictionary *reviewDict=[reviewArr objectAtIndex:index.row];

    
    JMProfileViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMProfile"];
    VC.ProfileUserId=[reviewDict objectForKey:@"userid"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];

}

-(void)deleteReviewClicked:(UIButton *)btn
{

    ReviewsTableViewCell *cCell=(ReviewsTableViewCell *)btn.superview.superview.superview;
    
    
    NSIndexPath *index=[_reviewTable indexPathForCell:cCell];
    
    
    NSDictionary *reviewDict=[reviewArr objectAtIndex:index.row];


    DebugLog(@"%@",reviewDict);
    
    if([self networkAvailable])
    {
        
        
        
        [SVProgressHUD show];
        
        NSString *urlString;
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/useraction/deletecomment?commentid=&mode=1
        urlString=[NSString stringWithFormat:@"%@index.php/Useraction/deletecomment?commentid=%@&mode=%@",GLOBALAPI,[reviewDict objectForKey:@"commentid"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        DebugLog(@"Send string Url%@",urlString);
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            
            
            if (error) {
                NSLog(@"error = %@", error);
                
                //                [_gifImage setHidden:YES];
                //                [_noVideoView setHidden:NO];
                //                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                //                [_loaderBtn setHidden:NO];
                
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
                    
                    [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"some error occured", nil) ];
                    
                    //                    [_gifImage setHidden:YES];
                    //                    [_noVideoView setHidden:NO];
                    //                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    //                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                    
                    [_rateView setHidden:YES];
                    
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        [SVProgressHUD dismiss];
                        [_reviewTable beginUpdates];
                        [_reviewTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
                        
                        
                        [reviewArr removeObjectAtIndex:index.row];
                        
                       
                        
                        [_reviewTable endUpdates];

                        if (reviewArr.count==0) {
                            [_reviewTable setUserInteractionEnabled:NO];
                            
                            [_noreviewLbl setHidden:NO];
                        }
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
        //        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        //        [_loaderBtn setHidden:NO];
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
        
        
    }
    
    

    
}

-(void)rateVideo:(UIButton *)btn
{

    if([self networkAvailable])
    {
        

        
        [SVProgressHUD show];
        
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Useraction/commentrating?user_id=%@&videoid=%@&rating=%d&comment=&mode=%@",GLOBALAPI,app.userId,VideoId,(int)btn.tag,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            

            if (error) {
                NSLog(@"error = %@", error);
                
//                [_gifImage setHidden:YES];
//                [_noVideoView setHidden:NO];
//                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
//                [_loaderBtn setHidden:NO];
                
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
                    
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"some error occured", nil) ];
                    
//                    [_gifImage setHidden:YES];
//                    [_noVideoView setHidden:NO];
//                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
//                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                    
                    [_rateView setHidden:YES];
                    
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                         [SVProgressHUD dismiss];
                    [self VideoDetailsApi];
                         
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
//        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
//        [_loaderBtn setHidden:NO];
        
          [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
        
        
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
    
    if (app.isLogged) {
        if (![app.userId isEqualToString:[VideoDictionary objectForKey:@"user_id"]]) {
       

    if([[VideoDictionary objectForKey:@"video_rating"] intValue]==0)
        [_rateView setHidden:NO];
        else
         [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"You have already rated this video", nil) ];
        } else{
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"You cannot rate your own videos", nil) ];
        }
    }
    else{
           [self addWarningView:self.view];
        
       // [SVProgressHUD showInfoWithStatus:@"Login required to rate videos"];
    }
}

- (IBAction)backClicked:(id)sender {

    [_gobackBtn setUserInteractionEnabled:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)updateTime:(NSTimer *)timer {
 
 
}
- (IBAction)sliderValueChange:(id)sender {
    
//    int32_t timeScale = player.currentItem.asset.duration.timescale;
//    [player seekToTime:CMTimeMakeWithSeconds(_seekSlider.value,timeScale)];
    
    CMTime showingTime = CMTimeMake(_seekSlider.value *1000, 1000);
    
    [player seekToTime:showingTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        
    }];
    
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
    
    if (app.isLogged) {
      
          if (![app.userId isEqualToString:[VideoDictionary objectForKey:@"user_id"]]) {
              
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
        sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
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
                
                [SVProgressHUD showErrorWithStatus:AMLocalizedString(@"Some error occured", nil) ];
                
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
                    
         [SVProgressHUD showErrorWithStatus:AMLocalizedString(@"Some error occured", nil) ];
                    
                    
                    
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
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
    }
          }
    else{
        [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"You cannot like your own videos", nil) ];
    }

    }
    else{
       // [SVProgressHUD showInfoWithStatus:@"Login required to like videos"];
        
           [self addWarningView:self.view];
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
    NSURL *vidurl=[NSURL URLWithString:[VideoDictionary objectForKey:@"video_file"]];
    NSArray *items = @[vidurl];
    
    // build an activity view controller
    UIActivityViewController *actcontroller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self.navigationController presentViewController:actcontroller animated:YES completion:^{
        // executes after the user selects something
    }];
    
    
    actcontroller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };

}

- (IBAction)shareClicked:(id)sender {
    
    NSURL *vidurl=[NSURL URLWithString:[VideoDictionary objectForKey:@"video_file"]];
    NSArray *items = @[vidurl];
    
    // build an activity view controller
    UIActivityViewController *actcontroller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    // and present it
    [self.navigationController presentViewController:actcontroller animated:YES completion:^{
        // executes after the user selects something
    }];
    
    
    actcontroller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };

    
}
- (IBAction)reportClicked:(id)sender {
    
    
 
    [self addReportView:self.view];
    [self.warningTitle setText:AMLocalizedString(@"Reason of report:", nil) ];
    
 
    
    [self.warnChoice1 setText:AMLocalizedString(@"SUBMIT", nil)];
    
    [self.warnChoice2 setText:AMLocalizedString(@"CANCEL", nil)];

    [self.warnBtn1 addTarget:self action:@selector(reportOneClicked) forControlEvents:UIControlEventTouchUpInside];
    

    [self.warnBtn2 addTarget:self action:@selector(reportTwoClicked) forControlEvents:UIControlEventTouchUpInside];
    

    [self.warnCrossBtn addTarget:self action:@selector(reportTwoClicked) forControlEvents:UIControlEventTouchUpInside];
    
}
 -(void)reportOneClicked
 {
        
     if ([self textFieldBlankorNot:self.reportText.text]) {
         
         
         
         [SVProgressHUD showInfoWithStatus:@"Please provide a reason"];
     }
     else
     {
        

       [self.reportView removeFromSuperview];
  
    
    if([self networkAvailable])
    {
        
        [_reportBtn setUserInteractionEnabled:NO];
        
        
        
        
        [SVProgressHUD show];
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/useraction/reportabuse?videoid=21&userid=1
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@useraction/reportabuse?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]]];
        
        // configure the request
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        
        
        NSString *sendData = @"videoid=";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",[VideoDictionary objectForKey:@"video_id"]]];
        
        sendData = [sendData stringByAppendingString:@"&userid="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",app.userId]];
        
        sendData = [sendData stringByAppendingString:@"&reasons="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",self.reportText.text]];

        
        
        DebugLog(@"url : %@&%@",url,sendData);
        
       [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSMutableData *theBodyData = [NSMutableData data];
        
        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
        
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [SVProgressHUD showErrorWithStatus:AMLocalizedString(@"Some error occured", nil) ];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *Response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                [_reportBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Some error occured",nil)];
                    
                    
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                  
                    
                    NSLog(@"result = %@",Response);
                    
                    
                    if ([[Response objectForKey:@"status"]boolValue]) {
                        
                          [SVProgressHUD showInfoWithStatus:[Response objectForKey:@"message"]];
                        
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
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
    }
    
     }

}
 -(void)reportTwoClicked
{

    [self.reportView removeFromSuperview];
    

}

#pragma mark -Go to Profile Page
- (IBAction)gotoProfile:(id)sender {
    
    JMProfileViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMProfile"];
    VC.ProfileUserId=VideoPosterId;
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

- (IBAction)videoOptionClicked:(id)sender {
    
    
    if ([self.filterView isHidden]) {
        [self.filterView setHidden:NO];
    }
    else{
        [self.filterView setHidden:YES];
    }
    
}

- (void)editClicked
{

   [self.filterView setHidden:YES];
    
    JMEditVideoViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMEditVideoViewController"];
    
    VC.videoDict=VideoDictionary;
    
    [self.navigationController pushViewController:VC animated:YES];
    

}

- (void)deleteClicked {
    
       [self.filterView setHidden:YES];
    [self addWarningView:self.view];
    
    [self.warningTitle setText:AMLocalizedString(@"Are you Sure?", nil) ];
    
    [self.warningtext setText:AMLocalizedString(@"Confirm YES to Delete", nil)];
    
        [self.warnChoice1 setText:AMLocalizedString(@"YES", nil)];
    
        [self.warnChoice2 setText:AMLocalizedString(@"NO", nil)];

    
}

-(void)warnOneClicked
{
    [self.warningView removeFromSuperview];
    
    if (app.isLogged) {
 
    
    if([self networkAvailable])
    {
        
  
        
        
        
        
        [SVProgressHUD show];
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/video/deletevideo?videoid=3&mode=1
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@video/deletevideo",GLOBALAPI,INDEX]];
        
        // configure the request
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        
        
        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSString *sendData = @"videoid=";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",[VideoDictionary objectForKey:@"video_id"]]];
        
        sendData = [sendData stringByAppendingString:@"&mode="];
        sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSMutableData *theBodyData = [NSMutableData data];
        
        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
        
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [SVProgressHUD showErrorWithStatus:AMLocalizedString(@"Some error occured", nil) ];
                
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
                    
                                 [SVProgressHUD showErrorWithStatus:AMLocalizedString(@"Some error occured", nil) ];
                    
                    
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                    [SVProgressHUD dismiss];
                    
                    NSLog(@"result = %@",Response);
                    
                    
                    if ([[Response objectForKey:@"status"]boolValue]) {
                        
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        
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
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
    }
    
    }
    else{
    
   
        
        JMGlobalMethods *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMLogin"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


- (IBAction)resizeClicked:(id)sender {
    
    



    

    
//    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [controller setVideoGravity:AVLayerVideoGravityResizeAspect];
    
    //        AVPlayerItem *currentItem = player.currentItem;
    //        NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
    //
    //        NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
    //        NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
    //
    //        NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
    //
    //        DebugLog(@"resize time: %@",videoDurationText);
    //            [controller.player seekToTime:player.currentTime];
    //                [controller.player play];
    // [self.navigationController presentViewController:controller animated:YES completion:nil];
    

        [controller.view.layer setAffineTransform:CGAffineTransformMakeRotation(degreeToRadian(90.0))];
 
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = self.view.frame;
    
    
    
   // inFullscreen=TRUE;
  
    

}
#pragma mark - status bar white color
- (IBAction)commentClicked:(id)sender {
    
    if (app.isLogged) {
        
                if (![app.userId isEqualToString:[VideoDictionary objectForKey:@"user_id"]]) {
        
//        if([[VideoDictionary objectForKey:@"video_rating"] intValue]==0)
//        {
            JMReviewViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMReview"];
            VC.VideoId=[VideoDictionary objectForKey:@"video_id"];
        VC.userRating=[VideoDictionary objectForKey:@"video_rating"];
        
            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//        }
//        else{
//            [SVProgressHUD showInfoWithStatus:@"You have already rated this video"];
//        }
    
                }
                else{
                    [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"You cannot rate or comment your own videos", nil) ];
                }
    }
    else{
      //  [SVProgressHUD showInfoWithStatus:@"Login required to Comment on videos"];
        
           [self addWarningView:self.view];
    }
    
   
}


-(void)playerDidFinishPlaying:(NSNotification *)notification {
    
    if (_seekSlider.maximumValue==_seekSlider.value) {
        

        
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
else
{
    [SVProgressHUD showWithStatus:AMLocalizedString(@"Buffering", nil) ];
    
}

  }

-(void) viewWillDisappear:(BOOL)animated
{
  [player seekToTime:kCMTimeZero];
    
    [player pause];
    
    [[player currentItem] removeObserver:self forKeyPath:@"playbackBufferEmpty" context:nil];
    [[player currentItem] removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:nil];
    [player removeObserver:self forKeyPath:@"status" context:nil];
    [player removeObserver:self forKeyPath:@"rate" context:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
 
        [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    

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
    [_loaderView setHidden:NO];
    [mainscroll setHidden:YES];
    
    if([self networkAvailable])
    {
        
        
        
   // [SVProgressHUD show];
            
            NSString *urlString;
            
            if (app.isLogged) {
                  urlString=[NSString stringWithFormat:@"%@index.php/Videodetails?videoid=%@&loggedinid=%@&mode=%@",GLOBALAPI,VideoId,app.userId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            }
            else{
                  urlString=[NSString stringWithFormat:@"%@index.php/Videodetails?videoid=%@&loggedinid=&mode=%@",GLOBALAPI,VideoId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            }
          
            
            
            
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
                [_errorView setHidden:NO];
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
                    [_errorView setHidden:NO];
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        

                 
                     
                         VideoDictionary=[[jsonResponse objectForKey:@"details"] mutableCopy];
                         
                    
                        
                        
                        
                        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                        
                        {
                            NSURL *videoURL;
                            
                            videoURL = [NSURL URLWithString:[VideoDictionary objectForKey:@"video_file"]];
                            
//                            if (player != nil && [player currentItem] != nil)
//                            {
//                            [[player currentItem] removeObserver:self forKeyPath:@"playbackBufferEmpty"];
//                            [[player currentItem] removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
//                            }
                            
                            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
                            
//                         
//                              if (player != nil && [player currentItem] != nil)
//                              {
//                              [player removeObserver:self forKeyPath:@"status"];
//                                  [player removeObserver:self forKeyPath:@"rate"];
//                              }
                               player = [AVPlayer playerWithPlayerItem:item];
                            [player addObserver:self forKeyPath:@"rate" options:0 context:nil];
                            
                            [player addObserver:self forKeyPath:@"status" options:0 context:nil];
                            
                        [item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
                            [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
                            
                            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
                            
                            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemPlaybackStalledNotification object:item];
                            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
                            
                            
                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                
                                CALayer *superlayer = _playerView.layer;
                                
                                AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
                                [playerLayer setFrame:self.playerView.bounds];
                                playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                                [superlayer addSublayer:playerLayer];
                                
                                // create a player view controller
                                
                                
                                _seekSlider.maximumValue = CMTimeGetSeconds(player.currentItem.asset.duration);
                                _seekSlider.value = 0.0;
                                
                                //  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
                                
                                CMTime interval = CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC);
                                
                           //     dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                
                                [player addPeriodicTimeObserverForInterval:interval queue:nil usingBlock:^(CMTime time) {
                                    _seekSlider.value = CMTimeGetSeconds( player.currentItem.currentTime);
                                    
                                    AVPlayerItem *currentItem = player.currentItem;
                                    NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.duration)-CMTimeGetSeconds(currentItem.currentTime);
                                    
                                    NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
                                    NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
                                    
                                    NSString *videoDurationText = [NSString stringWithFormat:@"-%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
                                    
                                    DebugLog(@" tracking time: %@",videoDurationText);
                                    
                                    [_timeLbl setText:[NSString stringWithFormat:@"%@",videoDurationText]];
                                }];
                                
                                [player seekToTime:kCMTimeZero];
                                paused=false;
                                [_playPauseImg setImage:[UIImage imageNamed:@"pause"]];
                                 [player play];
                                
                                mainscroll.userInteractionEnabled=YES;
                                [_commentView setUserInteractionEnabled:YES];
                                
                                
                                liked=[[VideoDictionary objectForKey:@"like"]boolValue];
                                
                                if (liked) {
                                    [_likeImage setImage:[UIImage imageNamed:@"like"]];
                                    
                                }
                                else{
                                    [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
                                }
                                
                                  if (app.isLogged) {
                                if ([[VideoDictionary objectForKey:@"user_id"]isEqualToString:app.userId]) {
                                    
                                    [_videoOptionView setHidden:NO];
                                    
                                }
                                  }
                                
                                _VideoNameLabel.text=[VideoDictionary objectForKey:@"videoname"];
                                
                                _ownerName.text=[VideoDictionary objectForKey:@"username"];
                                VideoPosterId=[VideoDictionary objectForKey:@"user_id"];
                                
                                          [_favouriteCountBtn setTitle:[NSString stringWithFormat:@"%@ %@" ,[VideoDictionary objectForKey:@"favouritecount"],AMLocalizedString(@"FAVOURITES", nil) ] forState:UIControlStateNormal];
                                
                               _viewCountLbl.text=[NSString stringWithFormat:@"%@ %@",[VideoDictionary objectForKey:@"views"],AMLocalizedString(@"VIEWS", nil)];
                                
                                
                                
                                _rankLbl.text=[NSString stringWithFormat:@"%@ %@",AMLocalizedString(@"SCORE",nil),[VideoDictionary objectForKey:@"userscore"]];
                                
                                
                                if ([[VideoDictionary objectForKey:@"video_average_rating"] intValue]>0) {
                                 
                                
//                                _ratingLbl.text=[NSString stringWithFormat:@"%@ %@ %@/5",[VideoDictionary objectForKey:@"totalratedusers"],AMLocalizedString(@"people rated", nil),[VideoDictionary objectForKey:@"video_average_rating"]];
                                
                                    
                                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"rightToleft"]) {
                                        
                                        _ratingLbl.text=[NSString stringWithFormat:@"(%@ %@) %@/5",AMLocalizedString(@"people voted", nil),[VideoDictionary objectForKey:@"totalratedusers"],[VideoDictionary objectForKey:@"video_average_rating"]];
                                    } else {
                                        
                                        _ratingLbl.text=[NSString stringWithFormat:@"%@/5 (%@ %@)",[VideoDictionary objectForKey:@"video_average_rating"],[VideoDictionary objectForKey:@"totalratedusers"],AMLocalizedString(@"people voted", nil)];
                                    }
                                    
                                
                                
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
                                
                                    
                                }
                                else{
                                
                                    [_ratingView setHidden:YES];
                                    [_ratingLbl setText:AMLocalizedString(@"Not rated yet", nil) ];
                                }
                                [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
                                
                                [_ownerImage sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"userimage"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
                                
                                
                                totalCount=0;
                                page=1;
                                reviewArr=[[NSMutableArray alloc]init];
                                heightArr=[[NSMutableArray alloc]init];
                                [self getReviews];
                                
                                
                                [_tvView setHidden:NO];
                              //  [_ratingView setHidden:NO];
                                [_ratingLbl setHidden:NO];
                                [_ownerView setHidden:NO];
                                [_reviewHeaderView setHidden:NO];
                                [_reviewTable setHidden:NO];
                                   [mainscroll setHidden:NO];
                          
                                //Run UI Updates
                            });
                        });
                        
                        
                        
                       
                        
                        
                 }
                    
                    else{
                        
                        //                            if (langArr.count==0) {
                        //
                        //                                [SVProgressHUD dismiss];
                        //                          }
                        //                            else{
                        //                                [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                            }
                        
//                        [_gifImage setHidden:YES];
//                        [_noVideoView setHidden:NO];
//                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
//                        [_loaderBtn setHidden:NO];
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [_gifImage setHidden:YES];
        [_errorView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
         // [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
}
-(void)getReviews
{
    
    if([self networkAvailable])
    {
        
        
        
       // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@useraction/reviewlisting?videoid=%@&page=%d&limit=5&mode=%@",GLOBALAPI,INDEX,VideoId,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
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
                    
                    [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"some error occured", nil) ];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                                    [_noreviewLbl setHidden:YES];
                        
                    NSArray    *tempArr=[[jsonResponse objectForKey:@"reviewdetails"] copy];
                        
                        totalCount=[[jsonResponse objectForKey:@"totalcount"]intValue];
                        
                        
                        
                        [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in tempArr) {
                            
                            [reviewArr addObject:Dict];
                            
                            
                            demoTxt.text=[Dict objectForKey:@"usercomment"];
           
                            CGSize size = [demoTxt sizeThatFits:CGSizeMake(260.0/320.0*FULLWIDTH, FLT_MAX)];
            
                            [heightArr addObject:[NSString stringWithFormat:@"%f",size.height]];
                            
                       
                            
                            
                        }
                        
                        
                        
                        if (reviewArr.count>0) {
                            
                            
                            
                           float totalHeight=0;
                            
                            for (NSString *heightStr in heightArr) {
                                totalHeight+=[heightStr floatValue]+(42.0/480.0*FULLHEIGHT) ;
                                
                            }
                            
                            CGRect tableRect =_reviewTable.frame;
                            
                            tableRect.size.height=totalHeight;
                            
                            _reviewTable.frame=tableRect;
                            
                            
                            [mainscroll setContentSize:CGSizeMake(FULLWIDTH, _reviewTable.frame.origin.y+_reviewTable.frame.size.height)];
                            
                            
                            [_reviewTable reloadData];
                            
                            
                        }
                        else{
                            
                            [_reviewTable setUserInteractionEnabled:NO];
                            
                                [_noreviewLbl setHidden:NO];
                        }
                        
                        
                    }
                    
                    
                    else{
                        
                        if (reviewArr.count==0) {
                            
                            [SVProgressHUD dismiss];
                            
                            [_noreviewLbl setHidden:NO];
                            
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
        
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
        
        
    }
    

    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (scrollView==mainscroll && totalCount>reviewArr.count)
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
        
        
        
      //  [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@useraction/videoviewcount?videoid=%@&mode=%@",GLOBALAPI,INDEX,VideoId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
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
                    
                  //  [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        viewed=true;
                    // [SVProgressHUD dismiss];
                        
                        
                        
                    }
                    
                    
                    else{
                        
                    
                            
                           // [SVProgressHUD dismiss];
                     
                       
                           // [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                     
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
      //  [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    }
    

}
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_errorView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    

    
  [self VideoDetailsApi];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (!player)
    {
        return;
    }
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusReadyToPlay) {
            
                          [_loaderView setHidden:YES];
            _playBackView.userInteractionEnabled = YES;
            
        } else if (player.status == AVPlayerStatusFailed) {
            _playBackView.userInteractionEnabled = NO;
            // something went wrong. player.error should contain some information
        }
//        else
//        {
//          [SVProgressHUD showWithStatus:@"Buffering"];
//        }
    }
    else if (object == player && [keyPath isEqualToString:@"rate"])
    {

        
        DebugLog(@"rate: %.2f",player.rate);
        
        if (player.rate>0) {
            
            
    
            
            
           // if (paused) {
           
            
           // paused=false;
           // [_playPauseImg setImage:[UIImage imageNamed:@"pause"]];
            
           // [player play];
            
            [self addViewCount];
            
            [_ratingImage.layer removeAllAnimations];
            [_optionView setHidden:YES];
                
           // }
        }
        else{
            if (!paused) {
           
           //playback has ended
                
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
        }
    }
    
    
    else if (object == player.currentItem && [keyPath isEqualToString:@"playbackBufferEmpty"])
    {
       // if (player.currentItem.playbackBufferEmpty) {
            [SVProgressHUD showWithStatus:AMLocalizedString(@"Buffering", nil) ];
       // }
    }
    
    else if (object == player.currentItem && [keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        if (player.currentItem.playbackLikelyToKeepUp)
        {
            [SVProgressHUD dismiss];
        }
    }
}


- (IBAction)jokeDetailClicked:(id)sender {
    
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
- (IBAction)favouriteListClicked:(id)sender {
    
    if([[VideoDictionary objectForKey:@"favouritecount"] intValue]>0)
    {
    JMFollowingViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMFollowingViewController"];
    VC.profileId=[VideoDictionary objectForKey:@"video_id"];
    VC.fromVideo=YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
- (IBAction)ratingListClicked:(id)sender {
    
               if ([[VideoDictionary objectForKey:@"video_average_rating"] intValue]>0) {
    
    JMRatingListViewController *VC=[app.storyBoard instantiateViewControllerWithIdentifier:@"JMRatingListViewController"];
  
    VC.videoId=VideoId;
    
    [self.navigationController pushViewController:VC animated:YES];
                   
               }
}
@end
