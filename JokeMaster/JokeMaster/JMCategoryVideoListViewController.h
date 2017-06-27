//
//  JMCategoryVideoListViewController.h
//  JokeMaster
//
//  Created by santanu on 24/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMCategoryCell.h"
#import "JMRecentUploadedCollectionViewCell.h"
#import "JMJokesCategoryVideoListViewController.h"
#import "JMPlayVideoViewController.h"
#import "UrlconnectionObject.h"
@interface JMCategoryVideoListViewController : JMGlobalMethods
{
    float MenuViewY;
    NSMutableArray *CategoryArray;
    UrlconnectionObject *urlobj;
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
@property (strong, nonatomic) NSString *CategoryId;
@property (strong, nonatomic) NSString *CategoryName;
@end
