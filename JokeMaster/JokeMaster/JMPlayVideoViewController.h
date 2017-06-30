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
#import "HCSStarRatingView.h"
#import "UrlconnectionObject.h"
@interface JMPlayVideoViewController : JMGlobalMethods<UITableViewDelegate,UITableViewDataSource>
{
    UrlconnectionObject *urlobj;
    NSMutableDictionary *VideoDictionary;
}
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
@property (strong, nonatomic) IBOutlet UIView *gobackView;
@property (strong, nonatomic) IBOutlet UIButton *gobackBtn;
@property (strong, nonatomic) IBOutlet UIView *ownerView;
@property (strong, nonatomic) IBOutlet UIView *ownerPicView;
@property (strong, nonatomic) IBOutlet UIImageView *ownerImage;
@property (strong, nonatomic) IBOutlet UILabel *ownerName;
@property (strong, nonatomic) IBOutlet UILabel *rankLbl;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
- (IBAction)shareClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *reportBtn;
- (IBAction)reportClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *reviewHeaderView;
@property (strong, nonatomic) IBOutlet UILabel *reviewsLbl;
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (strong, nonatomic) IBOutlet UILabel *commentTitle;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@property (strong, nonatomic) IBOutlet UIImageView *rating1;
@property (strong, nonatomic) IBOutlet UIImageView *rating2;
@property (strong, nonatomic) IBOutlet UIImageView *rating3;
@property (strong, nonatomic) IBOutlet UIImageView *rating4;
@property (strong, nonatomic) IBOutlet UIImageView *rating5;
@property (strong, nonatomic) IBOutlet UILabel *ratingLbl;

@property (strong, nonatomic) IBOutlet UIView *optionView;
@property (strong, nonatomic) IBOutlet UIView *transView;
@property (strong, nonatomic) IBOutlet UIView *likeVIew;
@property (strong, nonatomic) IBOutlet UIImageView *likeImage;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
- (IBAction)likeClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *playView;
@property (strong, nonatomic) IBOutlet UIImageView *playImage;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
- (IBAction)playClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *shareView;
@property (strong, nonatomic) IBOutlet UIImageView *shareImg;
@property (strong, nonatomic) IBOutlet UIButton *shareBttn;
- (IBAction)sharedClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *playPauseImg;
@property (strong, nonatomic) IBOutlet UIButton *profileBttn;
- (IBAction)gotoProfile:(id)sender;

- (IBAction)resizeClicked:(id)sender;
- (IBAction)commentClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *rateView;
@property (strong, nonatomic) IBOutlet UIButton *crossBtn;
- (IBAction)crossClicked:(id)sender;

@property (strong, nonatomic) NSString *VideoId;

@property (weak, nonatomic) IBOutlet UILabel *VideoNameLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;

@end
