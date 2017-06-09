//
//  JMLeftMenuView.m
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMLeftMenuView.h"

@implementation JMLeftMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (id)leftmenu
{
    JMLeftMenuView *customView = [[[NSBundle mainBundle] loadNibNamed:@"JMLeftMenuView" owner:nil options:nil] lastObject];
    
    NSIndexPath *indexpath=[NSIndexPath indexPathForRow:2 inSection:0];
//    [customView.LeftTable selectRowAtIndexPath:indexpath animated:YES  scrollPosition:UITableViewScrollPositionNone];
//    
//    customView.lblUserName.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"];
//    
//    if (customView.lblUserName.text.length==0)
//    {
//        customView.lblUserName.text=@"GUEST";
//    }
//    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserType"] isEqualToString:@"U"])
//    {
//        customView.lblUserType.text=@"Owner";
//    }
//    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserType"] isEqualToString:@"A"])
//    {
//        customView.lblUserType.text=@"Agent";
//    }
//    else
//    {
//        customView.lblUserType.hidden=YES;
//        customView.lblUserName.frame=CGRectMake(customView.lblUserName.frame.origin.x, customView.UserImage.frame.origin.y+customView.UserImage.frame.size.height/2-customView.lblUserName.frame.size.height/2, customView.lblUserName.frame.size.width, customView.lblUserName.frame.size.height);
//    }
    
    
    
    // make sure customView is not nil or the wrong class!
    if ([customView isKindOfClass:[JMLeftMenuView class]])
        return customView;
    else
        return nil;
    
    
}
@end
