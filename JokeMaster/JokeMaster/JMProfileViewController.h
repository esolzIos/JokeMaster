//
//  JMProfileViewController.h
//  JokeMaster
//
//  Created by santanu on 15/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMRecentUploadedCollectionViewCell.h"
#import "JMCategoryCell.h"

@interface JMProfileViewController : JMGlobalMethods<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>
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

- (IBAction)categoryClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@property (weak, nonatomic) IBOutlet UIView *TransparentView;
@property (weak, nonatomic) IBOutlet UIView *MenuBaseView;

@property (weak, nonatomic) IBOutlet UIView *CrossView;
- (IBAction)CategoryCrossTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *CategoryTable;
- (IBAction)profileClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *profileBttn;
@end
