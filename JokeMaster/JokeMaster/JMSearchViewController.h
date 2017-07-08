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
#import "JMFavouriteCell.h"
@interface JMSearchViewController : JMGlobalMethods<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *MainScroll;

@property (strong, nonatomic) IBOutlet UITableView *jokeTable;

@end
