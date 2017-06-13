//
//  JMPlayVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMPlayVideoViewController.h"

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
    
   player = [AVPlayer playerWithURL:videoURL];
    
    // create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [controller setVideoGravity:AVLayerVideoGravityResizeAspectFill];
 
    controller.showsPlaybackControls=NO;
    
    
    _seekSlider.maximumValue = CMTimeGetSeconds(player.currentItem.asset.duration);
    _seekSlider.value = 0.0;
    
  //  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];

    CMTime interval = CMTimeMakeWithSeconds(1.0, NSEC_PER_SEC);
    
[player addPeriodicTimeObserverForInterval:interval queue:NULL usingBlock:^(CMTime time) {
        _seekSlider.value = CMTimeGetSeconds( player.currentItem.currentTime);
        
        AVPlayerItem *currentItem = player.currentItem;
        NSTimeInterval currentTime = CMTimeGetSeconds(currentItem.currentTime);
        NSLog(@" Capturing Time :%f ",currentTime);
        
        NSUInteger dTotalSeconds = CMTimeGetSeconds(currentItem.currentTime);
        
        NSUInteger dMinutes = floor(dTotalSeconds % 3600 / 60);
        NSUInteger dSeconds = floor(dTotalSeconds % 3600 % 60);
        
        NSString *videoDurationText = [NSString stringWithFormat:@"%02lu:%02lu", (unsigned long)dMinutes, (unsigned long)dSeconds];
        
        [_timeLbl setText:[NSString stringWithFormat:@"%@",videoDurationText]];
    }];
    
     [player play];
    
    // show the view controller
    [self addChildViewController:controller];
       [_playerView addSubview:controller.view];
        controller.view.frame= CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height);
 
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    
      [self setRoundCornertoView:_playerView withBorderColor:[UIColor clearColor] WithRadius:0.15];

    // Do any additional setup after loading the view.
}


#pragma mark - UITableView Delegates
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//{
//    return 0;
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
////    NSString *identifier = @"CountryCell";
////    
////    CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
////    
////    cell.selectionStyle = UITableViewCellSelectionStyleNone;
////    
////    cell.CheckImage.tag=indexPath.row+500;
////    cell.CheckButton.tag=indexPath.row;
////    [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
////    
////    return cell;
////    
////    
//    
//    
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if (IsIphone5 || IsIphone4)
////    {
////        return 50;
////    }
////    else
////    {
////        return 60;
////    }
//    
//}
//
//-(void) tableView:(UITableView *)tableView willDisplayCell:(CountryCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//    
//    [cell.CountryImage setImage:[UIImage imageNamed:[CountryArray objectAtIndex:indexPath.row]]] ;
//    
//    [cell.CountryLabel setText:AMLocalizedString([[CountryArray objectAtIndex:indexPath.row]uppercaseString], nil) ];
//    
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


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
    
    int32_t timeScale = player.currentItem.asset.duration.timescale;
    [player seekToTime:CMTimeMakeWithSeconds(_seekSlider.value,timeScale)];
    
}


- (IBAction)pausePlayClicked:(id)sender
{
    if (!paused) {
        paused=true;
        [_pausePlayBtn setImage:[UIImage imageNamed:@"play-1"] forState:UIControlStateNormal];
        
        [player pause];
        
    }
    else{
        paused=false;
        [_pausePlayBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        [player play];
    }
    
 

}

@end
