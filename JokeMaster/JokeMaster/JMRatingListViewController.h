//
//  JMRatingListViewController.h
//  JokeMaster
//
//  Created by santanu on 07/08/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMFavouriteCell.h"
@interface JMRatingListViewController : JMGlobalMethods
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITableView *FollowTable;
@property (strong, nonatomic) IBOutlet UIView *loaderView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;
@property (nonatomic) NSString *videoId;
@end
