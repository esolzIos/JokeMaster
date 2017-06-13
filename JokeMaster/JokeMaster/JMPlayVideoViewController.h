//
//  JMPlayVideoViewController.h
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//
//
@import AVFoundation;
@import AVKit;
#import <QuartzCore/QuartzCore.h>
#import "AVFoundation/AVFoundation.h"
#import "JMGlobalMethods.h"

@interface JMPlayVideoViewController : JMGlobalMethods<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *reviewTable;
@property (strong, nonatomic) IBOutlet UIView *playerView;
@property (strong, nonatomic) IBOutlet UIView *tvView;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImage;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtn;
- (IBAction)ratingClicked:(id)sender;
- (IBAction)backClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *seekSlider;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (strong, nonatomic) IBOutlet UIButton *resizeBtn;
- (IBAction)sliderValueChange:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pausePlayBtn;
- (IBAction)pausePlayClicked:(id)sender;
@end
