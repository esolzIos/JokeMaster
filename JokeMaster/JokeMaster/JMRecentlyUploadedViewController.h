//
//  JMRecentlyUploadedViewController.h
//  JokeMaster
//
//  Created by priyanka on 10/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMCategoryCell.h"
#import "JMRecentUploadedCollectionViewCell.h"
#import "JMJokesCategoryVideoListViewController.h"
#import "JMPlayVideoViewController.h"
#import "UrlconnectionObject.h"
#import "JMCategoryVideoListViewController.h"
@interface JMRecentlyUploadedViewController : JMGlobalMethods<UICollectionViewDataSource,UICollectionViewDelegate>
{
    float MenuViewY;
    NSMutableArray *CategoryArray,*RecentVideoArray;
    UrlconnectionObject *urlobj;
   // NSInteger Page;
    BOOL MoreDataAvailable;
}
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;

@property (weak, nonatomic) IBOutlet UIView *ChooseCategoryView;
@property (weak, nonatomic) IBOutlet UILabel *ChooseCategoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ChooseCatImage;
@property (weak, nonatomic) IBOutlet UIButton *ChooseCategoryBtn;
- (IBAction)ChooseCategoryTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *RecentVideoCollectionView;
@property (weak, nonatomic) IBOutlet UIView *TransparentView;
@property (weak, nonatomic) IBOutlet UIView *MenuBaseView;

@property (weak, nonatomic) IBOutlet UIView *CrossView;
- (IBAction)CategoryCrossTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *CategoryTable;
@property (weak, nonatomic) IBOutlet UIView *LoaderView;

@property (strong, nonatomic) IBOutlet UIView *loaderHUDView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;
@property (strong, nonatomic) IBOutlet UILabel *novidLbl;
@end
