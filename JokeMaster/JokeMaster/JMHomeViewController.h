//
//  JMHomeViewController.h
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JokeCollectionViewCell.h"
#import "UrlconnectionObject.h"
#import "HCSStarRatingView.h"
@interface JMHomeViewController : JMGlobalMethods<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    float MenuViewY;
    NSMutableArray *CategoryArray;
    UrlconnectionObject *urlobj;
    NSMutableArray *RecentVideoArray;
}
@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UILabel *jokeTitle;
@property (strong, nonatomic) IBOutlet UIView *tvView;
@property (strong, nonatomic) IBOutlet UIImageView *videoThumb;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImage;
@property (strong, nonatomic) IBOutlet UIView *categoryBtnView;
@property (strong, nonatomic) IBOutlet UILabel *categoryBtnlbl;
@property (strong, nonatomic) IBOutlet UIButton *categoryBtn;
- (IBAction)categoryClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *jokeCollectionView;
@property (strong, nonatomic) IBOutlet UIView *tutorialView;
@property (strong, nonatomic) IBOutlet UIButton *tutorialBtn;
- (IBAction)tutorialClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *recentBtn;
- (IBAction)recentClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *jokeDetailBtn;
- (IBAction)jokeDetailClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtn;
- (IBAction)ratingClicked:(id)sender;
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
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
- (IBAction)shareClicked:(id)sender;
 @property (strong, nonatomic) UIView *filterView;
//@property (weak, nonatomic) IBOutlet UIView *TransparentView;
//@property (weak, nonatomic) IBOutlet UIView *MenuBaseView;
//@property (weak, nonatomic) IBOutlet UIView *CrossView;
//- (IBAction)CategoryCrossTapped:(id)sender;
//@property (weak, nonatomic) IBOutlet UITableView *CategoryTable;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;

@property (strong, nonatomic) IBOutlet UIView *ratingView;
@property (strong, nonatomic) IBOutlet UIButton *crossBtn;
- (IBAction)crossClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtnOne;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtnTwo;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtnThree;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtnFour;
@property (strong, nonatomic) IBOutlet UIButton *ratingBtnFive;
@property (weak, nonatomic) IBOutlet UILabel *VideoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *VideoCreaterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *VideoRatingLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *VideoRatingView;

@property (strong, nonatomic) IBOutlet UIView *loaderView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;
@property (strong, nonatomic) IBOutlet UIButton *jokeUserBtn;
- (IBAction)gotoJokeUser:(id)sender;

@end
