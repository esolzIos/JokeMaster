//
//  JMSearchViewController.h
//  JokeMaster
//
//  Created by santanu on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMSearchView.h"
#import "JMCategoryCell.h"
#import "JMRecentUploadedCollectionViewCell.h"
@interface JMSearchViewController : JMGlobalMethods<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;
@property (weak, nonatomic) IBOutlet UICollectionView *RecentVideoCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *RecentlyUploadedBtn;
- (IBAction)RecentlyUploadedVideoTapped:(id)sender;
@end
