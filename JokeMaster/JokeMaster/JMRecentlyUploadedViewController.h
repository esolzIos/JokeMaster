//
//  JMRecentlyUploadedViewController.h
//  JokeMaster
//
//  Created by priyanka on 10/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMRecentUploadedCollectionViewCell.h"
@interface JMRecentlyUploadedViewController : JMGlobalMethods<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;

@property (weak, nonatomic) IBOutlet UIView *ChooseCategoryView;
@property (weak, nonatomic) IBOutlet UILabel *ChooseCategoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ChooseCatImage;
@property (weak, nonatomic) IBOutlet UIButton *ChooseCategoryBtn;
- (IBAction)ChooseCategoryTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *RecentVideoCollectionView;

@end
