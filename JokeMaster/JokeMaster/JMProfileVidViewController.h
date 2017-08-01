//
//  JMProfileVidViewController.h
//  JokeMaster
//
//  Created by santanu on 27/07/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMRecentUploadedCollectionViewCell.h"
#import "JMCategoryCell.h"
@interface JMProfileVidViewController : JMGlobalMethods<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    float MenuViewY;
    NSMutableArray *CategoryArray;
}
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;

@property (weak, nonatomic) IBOutlet UIView *CategoryView;
@property (weak, nonatomic) IBOutlet UILabel *CategoryLabel;
@property (strong, nonatomic) IBOutlet UIView *profileImgView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIImageView *imageFrame;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *scoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *membershipDate;
@property (strong, nonatomic) IBOutlet UIView *followView;
@property (strong, nonatomic) IBOutlet UIButton *followBtn;
- (IBAction)followClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *categoryBtn;
@property (strong, nonatomic) IBOutlet UIImageView *FollowImg;

- (IBAction)categoryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@property (weak, nonatomic) IBOutlet UIView *TransparentView;
@property (weak, nonatomic) IBOutlet UIView *MenuBaseView;

@property (weak, nonatomic) IBOutlet UIView *CrossView;
- (IBAction)CategoryCrossTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *CategoryTable;
- (IBAction)profileClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *profileBttn;
@property(nonatomic) BOOL fromLeftMenu;

@property (strong, nonatomic) IBOutlet UILabel *noVidLbl;
@property (strong, nonatomic) IBOutlet UIImageView *countryImage;

@property (strong, nonatomic) IBOutlet UIView *loaderView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;

@property (strong, nonatomic) IBOutlet UILabel *profileCountryLbl;

@property (strong, nonatomic) NSString *ProfileUserId;
@property (strong, nonatomic) NSString *ProfileuserImage;
@property (strong, nonatomic) NSString *ProfileFlag;
@property (strong, nonatomic) NSString *ProfileCountry;
@property (strong, nonatomic) NSString *ProfileUserName;
@property (strong, nonatomic) NSString *categoryId;
@property (strong, nonatomic) NSString *categoryName;
@end
