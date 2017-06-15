//
//  JMFavouriteViewController.h
//  JokeMaster
//
//  Created by priyanka on 14/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "JMFavouriteCell.h"
@interface JMFavouriteViewController : JMGlobalMethods
{
    BOOL swiped,oneTime;
    NSInteger PreviousTag;
    float WhiteViewX;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UITableView *FavouriteTable;

@end
