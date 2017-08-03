//
//  JMLeftMenuView.m
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMLeftMenuView.h"

@implementation JMLeftMenuView
@synthesize SideDelegate;
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
    [customView.LeftMenuTable selectRowAtIndexPath:indexpath animated:YES  scrollPosition:UITableViewScrollPositionNone];
    
    
    [customView.NameLabel setFont:[UIFont fontWithName:customView.NameLabel.font.fontName size:[customView getFontSize:customView.NameLabel.font.pointSize]]];
    [customView.ScoreLabel setFont:[UIFont fontWithName:customView.ScoreLabel.font.fontName size:[customView getFontSize:customView.ScoreLabel.font.pointSize]]];
        
    
    customView.ScoreLabel.text=[NSString stringWithFormat:@"%@ : %@",AMLocalizedString(@"SCORE",nil),@"0.0/5"];
    //AMLocalizedString(@"SCORE : 0.0/5", nil);
  //  customView.NameLabel.text=AMLocalizedString(@"JOHN DOE", nil);
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"loggedIn"])
        
    {
        
        customView.NameLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
       
         [customView.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Image"]]] placeholderImage:[UIImage imageNamed: @"noimage"]];
       
        
    }
    
    else
        
    {
        
        customView.NameLabel.text=AMLocalizedString(@"Guest",nil);
        
    }
    
    customView.ProfileImage.layer.cornerRadius=17;
    customView.ProfileImage.clipsToBounds=YES;
    
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
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 7;
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    NSString *userid=[prefs valueForKey:@"UserId"];
//    if (userid.length==0)
//    {
//        return 9;
//    }
//    else
//    {
//        return 10;
//    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    
    JMLeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil)
    {
        cell = [[JMLeftMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        
        
        cell.menuImg = [[UIImageView alloc] init];
        cell.menuImg.frame = CGRectMake(30,14,20,20);
        cell.menuImg.image = [UIImage imageNamed:@"my-chanel"];
        cell.menuImg.tag=indexPath.row;
        [cell addSubview:cell.menuImg];
        
        
        
        cell.menuName = [[UILabel alloc] init];
        cell.menuName.frame = CGRectMake(62,14, cell.frame.size.width-70,20);
        cell.menuName.tag=indexPath.row;
        cell.menuName.textColor=[UIColor blackColor];
        cell.menuName.textAlignment = NSTextAlignmentLeft;
        cell.menuName.font = [UIFont fontWithName:ComicbkITalic size:12];
        [cell addSubview:cell.menuName];
        
        if (IsIphone5)
        {
            cell.menuImg.frame = CGRectMake(30,14,20,20);
            cell.menuName.frame = CGRectMake(62,14, cell.frame.size.width-70,20);
            cell.menuName.font = [UIFont fontWithName:@"ComicBook" size:12];
        }
        else if (IsIphone6)
        {
            cell.menuImg.frame = CGRectMake(30,16,22,22);
            cell.menuName.frame = CGRectMake(64,16, cell.frame.size.width-70,20);
            cell.menuName.font = [UIFont fontWithName:@"ComicBook" size:14];
        }
        else if (IsIphone6plus)
        {
            cell.menuImg.frame = CGRectMake(30,18,24,24);
            cell.menuName.frame = CGRectMake(66,18, cell.frame.size.width-70,20);
            cell.menuName.font = [UIFont fontWithName:@"ComicBook" size:16];
        }
        
        
        
        
        if (indexPath.row==0)
        {
            cell.menuName.text = [AMLocalizedString(@"MY CHANNEL",nil) uppercaseString];
            cell.menuImg.image = [UIImage imageNamed:@"my-chanel"];
        }
        else if (indexPath.row==1)
        {
            cell.menuName.text = [AMLocalizedString(@"MY FAVOURITES",nil)uppercaseString];;
            cell.menuImg.image = [UIImage imageNamed:@"favourite"];
            
           
        }
        else if (indexPath.row==2)
        {
            cell.menuName.text = AMLocalizedString(@"FOLLOWING",nil);
            cell.menuImg.image = [UIImage imageNamed:@"following"];
        }
        else if (indexPath.row==3)
        {
            cell.menuName.text = AMLocalizedString(@"RANKINGS",nil);
             cell.menuImg.image = [UIImage imageNamed:@"menucrown"];
            
        }
//        else if (indexPath.row==4)
//        {
//            cell.menuName.text = AMLocalizedString(@"HISTORY",nil);
//            cell.menuImg.image = [UIImage imageNamed:@"history"];
//        }
//        else if (indexPath.row==4)
//        {
//            cell.menuName.text = AMLocalizedString(@"PROFILE",nil);
//            cell.menuImg.image = [UIImage imageNamed:@"profile"];
//        }
        else if (indexPath.row==4)
        {
            cell.menuName.text = AMLocalizedString(@"UPLOAD A VIDEO",nil);
            cell.menuImg.image = [UIImage imageNamed:@"settings"];
        }
        else if (indexPath.row==5)
        {
            cell.menuName.text = AMLocalizedString(@"NOTIFICATIONS",nil);
            cell.menuImg.image = [UIImage imageNamed:@"bell"];
        }
        else if (indexPath.row==6)
        {
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"loggedIn"]) {
                cell.menuName.text = AMLocalizedString(@"LOG OUT",nil);
                cell.menuImg.image = [UIImage imageNamed:@"logout"];
            }
            else{
                cell.menuName.text = AMLocalizedString(@"LOG IN",nil);
                cell.menuImg.image = [UIImage imageNamed:@"logout"];
            }
      
        }
        
        
       
    }
    
    return cell;
    
}
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
//    if (currentSelectedIndexPath != nil)
//    {
//        
//        
//        [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:UIColorFromRGB(0x555F68)];
//    }
//    
//    return indexPath;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:UIColorFromRGB(0x636F7C)];
    
    [SideDelegate action_method:indexPath.row];
    
    
    
//    LeftMenuCell * cell = [_LeftTable cellForRowAtIndexPath:indexPath];
//    
//    if (indexPath.row==0)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"Add Property-1"];
//    }
//    if (indexPath.row==1)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"wallet-2"];
//    }
//    else if (indexPath.row==2)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"Explore"];
//    }
//    else if (indexPath.row==3)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"LocationSelected"];
//    }
//    else if (indexPath.row==4)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"ConnectSelected"];
//    }
//    else if (indexPath.row==5)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"New Campaign-1"];
//    }
//    else if (indexPath.row==6)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"star-1"];
//    }
//    else if (indexPath.row==7)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"like-2"];
//    }
//    else if (indexPath.row==8)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"Combined Shape Copy-1"];
//    }
//    else if (indexPath.row==9)
//    {
//        cell.menuImg.image = [UIImage imageNamed:@"Log out-1"];
//    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsIphone5)
    {
        return 48;
    }
    else if (IsIphone6)
    {
       return 54;
    }
    else if (IsIphone6plus)
    {
       return 60;
    }
    else
    {
        return 60;
    }
    
}
-(CGFloat)getFontSize:(CGFloat)size
{
    
    if (IsIphone5) {
        
        size+=1.0;
    }
    else
        if (IsIphone6) {
            
            size+=3.0;
        }
        else  if (IsIphone6plus) {
            
            size+=4.0;
        }
    
        else if (IsIpad)
        {
            size+=5.0;
        }
    return size;
}
@end
