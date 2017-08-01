//
//  JMJokeMasterRankViewController.h
//  JokeMaster
//
//  Created by priyanka on 16/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMFavouriteCell.h"
@interface JMJokeMasterRankViewController : JMGlobalMethods
{
    BOOL swiped,oneTime;
    NSInteger PreviousTag;
    float WhiteViewX;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITableView *RankTable;

@property (strong, nonatomic) IBOutlet UIView *loaderView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;
@property (strong, nonatomic) IBOutlet UIImageView *crownImage;
@end
