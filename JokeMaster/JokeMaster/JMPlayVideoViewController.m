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
    

        BOOL liked;
 
    
}
@end

@implementation JMPlayVideoViewController
@synthesize VideoDictionary;
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
        
        _VideoNameLabel.text=[VideoDictionary objectForKey:@"videoname"];
        _ratingLbl.text=[NSString stringWithFormat:@"%@/5",[VideoDictionary objectForKey:@"rating"]];
        
        
        _ratingView.maximumValue = 5;
        _ratingView.minimumValue = 0;
        _ratingView.value =[[VideoDictionary objectForKey:@"rating"] floatValue];
        _ratingView.userInteractionEnabled=NO;
        //    _RatingView.tintColor = [UIColor clearColor];
        _ratingView.allowsHalfStars = YES;
        _ratingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _ratingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _ratingView.hidden=NO;
        
        [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
        
        //   NSURL *videoURL = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"];
        NSURL *videoURL = [NSURL URLWithString:[VideoDictionary objectForKey:@"video_file"]];
        
        
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
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
        [_reviewTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
[_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateNormal];
    [_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateSelected];
    [_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateHighlighted];
  ;
    

    
    // show the view controller
      [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
          [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
      [self setRoundCornertoView:_playerView withBorderColor:[UIColor clearColor] WithRadius:0.15];

    // Do any additional setup after loading the view.
    
    _VideoNameLabel.text=[VideoDictionary objectForKey:@"videoname"];
    _ratingLbl.text=[NSString stringWithFormat:@"%@/5",[VideoDictionary objectForKey:@"rating"]];
    
    
    _ratingView.maximumValue = 5;
    _ratingView.minimumValue = 0;
    _ratingView.value =[[VideoDictionary objectForKey:@"rating"] floatValue];
    _ratingView.userInteractionEnabled=NO;
    //    _RatingView.tintColor = [UIColor clearColor];
    _ratingView.allowsHalfStars = YES;
    _ratingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _ratingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _ratingView.hidden=NO;
    
    [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[VideoDictionary objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
    
    _seekSlider.value = 0.0;
    
    paused=true;
    [_playPauseImg setImage:[UIImage imageNamed:@"play-1"]];
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"reviewCell";
    
    ReviewsTableViewCell *cell = (ReviewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (!fontSet) {
        
        [cell.userName setFont:[UIFont fontWithName:cell.userName.font.fontName size:[self getFontSize:cell.userName.font.pointSize]]];
        [cell.reviewDate setFont:[UIFont fontWithName:cell.reviewDate.font.fontName size:[self getFontSize:cell.reviewDate.font.pointSize]]];
        [cell.ratingLbl setFont:[UIFont fontWithName:cell.ratingLbl.font.fontName size:[self getFontSize:cell.ratingLbl.font.pointSize]]];
           [cell.reviewTxt setFont:[UIFont fontWithName:cell.reviewTxt.font.fontName size:[self getFontSize:cell.reviewTxt.font.pointSize]]];
        
        fontSet=true;
        
    }
    
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
    
  
    
    [self setRoundCornertoView:cell.userImage withBorderColor:[UIColor clearColor] WithRadius:0.5];
    
    if (!fontSet) {
        
        [cell.userName setFont:[UIFont fontWithName:cell.userName.font.fontName size:[self getFontSize:cell.userName.font.pointSize]]];
        [cell.reviewDate setFont:[UIFont fontWithName:cell.reviewDate.font.fontName size:[self getFontSize:cell.reviewDate.font.pointSize]]];
        [cell.ratingLbl setFont:[UIFont fontWithName:cell.ratingLbl.font.fontName size:[self getFontSize:cell.ratingLbl.font.pointSize]]];
        [cell.reviewTxt setFont:[UIFont fontWithName:cell.reviewTxt.font.fontName size:[self getFontSize:cell.reviewTxt.font.pointSize]]];
        
        fontSet=true;
        
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        [_ratingImage.layer removeAllAnimations];
           [_optionView setHidden:YES];
    }
    
 

}
- (IBAction)likeClicked:(id)sender {
    
    if (!liked) {
        [_likeImage setImage:[UIImage imageNamed:@"like"]];
        liked=true;
        
        
    }
    else{
        [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
        
        liked=false;
    }
    
}
- (IBAction)playClicked:(id)sender {
    
     [_ratingImage.layer removeAllAnimations];
    [_optionView setHidden:YES];
    paused=false;
    [_playPauseImg setImage:[UIImage imageNamed:@"pause"]];
  //  [player seekToTime:kCMTimeZero];
    [player play];
}
- (IBAction)sharedClicked:(id)sender {
     [_ratingImage.layer removeAllAnimations];
    [_optionView setHidden:YES];
}

- (IBAction)shareClicked:(id)sender {
}
- (IBAction)reportClicked:(id)sender {
}
- (IBAction)gotoProfile:(id)sender {
    
    JMProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
    
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

- (IBAction)resizeClicked:(id)sender {
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
   // [controller setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
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

- (IBAction)commentClicked:(id)sender {
    
    JMReviewViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMReview"];
    
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
@end
