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
@end
