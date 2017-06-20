//
//  JMPlayVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMPlayVideoViewController.h"
#import "ReviewsTableViewCell.h"

@interface JMPlayVideoViewController ()<AVPlayerViewControllerDelegate>
{
AVPlayer *player;
    
    BOOL paused;
    
}
@end

@implementation JMPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [_reviewTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
[_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateNormal];
    [_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateSelected];
    [_seekSlider setThumbImage:[UIImage imageNamed:@"circleslider"] forState:UIControlStateHighlighted];
  ;
    

    
    NSURL *videoURL = [NSURL URLWithString:@"http://techslides.com/demos/sample-videos/small.mp4"];
    
    
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
        
        [_timeLbl setText:[NSString stringWithFormat:@"%@",videoDurationText]];
    }];
     [player seekToTime:kCMTimeZero];
     [player play];
    
    // show the view controller
      [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
          [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
      [self setRoundCornertoView:_playerView withBorderColor:[UIColor clearColor] WithRadius:0.15];

    // Do any additional setup after loading the view.
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
        [_pausePlayBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateNormal];
        
        [player pause];
           [_optionView setHidden:NO];
        
    }
    else{
        paused=false;
        [_pausePlayBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        [player play];
           [_optionView setHidden:YES];
    }
    
 

}
- (IBAction)likeClicked:(id)sender {
    
    [_optionView setHidden:YES];
    
    
}
- (IBAction)playClicked:(id)sender {
    
    
    [_optionView setHidden:YES];
    paused=false;
    [_pausePlayBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [player seekToTime:kCMTimeZero];
    [player play];
}
- (IBAction)sharedClicked:(id)sender {
    
    [_optionView setHidden:YES];
}

- (IBAction)shareClicked:(id)sender {
}
- (IBAction)reportClicked:(id)sender {
}
- (IBAction)resizeClicked:(id)sender {
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [controller setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    

    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
    

}

-(void)playerDidFinishPlaying:(NSNotification *)notification {
    paused=true;
    [_pausePlayBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateNormal];
    
  [player seekToTime:kCMTimeZero];
      [_optionView setHidden:NO];
  }
@end
