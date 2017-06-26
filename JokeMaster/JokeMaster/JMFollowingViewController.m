//
//  JMFollowingViewController.m
//  JokeMaster
//
//  Created by priyanka on 16/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMFollowingViewController.h"

@interface JMFollowingViewController ()
{
    int listcount;
    
    NSMutableArray *swipedRows;
}
@end

@implementation JMFollowingViewController
@synthesize FollowTable,mainscroll;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    swiped=NO;
    //    PreviousTag=-100;
    ///oneTime=NO;
    listcount=30;
    
        [self addMoreView:self.view];
    
        swipedRows=[[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   return listcount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"JMFavouriteCell";
    
    JMFavouriteCell *cell = (JMFavouriteCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsIphone4 || IsIphone5)
    {
        return 95;
    }
    else if (IsIphone6)
    {
        return 108;
    }
    else if (IsIphone6plus)
    {
        return 120;
    }
    else
    {
        return 100;
    }
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(JMFavouriteCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.WhiteView.tag=indexPath.row+500;
//    DebugLog(@"tag %ld",(long)cell.WhiteView.tag);
//    
//    if (oneTime==NO)
//    {
//        WhiteViewX=cell.WhiteView.frame.origin.x;
//        oneTime=YES;
//    }
    
    
    
    if ([swipedRows containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.WhiteView.frame =CGRectMake(-50.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);
    }
    else{
        cell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);
    }
    
    [cell.deleteBtn addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRoundCornertoView:cell.ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.36];
    
    //    [cell.ProfileNameLabel setFont:[UIFont fontWithName:cell.ProfileNameLabel.font.fontName size:[self getFontSize:cell.ProfileNameLabel.font.pointSize]]];
    //    [cell.JokesNameLabel setFont:[UIFont fontWithName:cell.JokesNameLabel.font.fontName size:[self getFontSize:cell.JokesNameLabel.font.pointSize]]];
    //    [cell.RatingLabel setFont:[UIFont fontWithName:cell.RatingLabel.font.fontName size:[self getFontSize:cell.RatingLabel.font.pointSize]]];
    
    
    cell.RatingView.maximumValue = 5;
    cell.RatingView.minimumValue = 0;
    cell.RatingView.value = 4.5;
    cell.RatingView.userInteractionEnabled=NO;
    //    _RatingView.tintColor = [UIColor clearColor];
    cell.RatingView.allowsHalfStars = YES;
    cell.RatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.RatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    gestureRecognizer.view.tag=cell.WhiteView.tag;
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [cell.WhiteView addGestureRecognizer:gestureRecognizer];
    
    
    UISwipeGestureRecognizer *rightgestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightswipeHandler:)];
    rightgestureRecognizer.view.tag=cell.WhiteView.tag;
    [rightgestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [cell.WhiteView addGestureRecognizer:rightgestureRecognizer];
}
-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    JMFavouriteCell *cCell=(JMFavouriteCell *)recognizer.view.superview.superview;
    
    if (![swipedRows containsObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]]) {
        
        //    NSIndexPath *index=[FollowTable indexPathForCell:cCell];
        //    if (swiped==NO)
        //    {
        //
        //    }
        //    else
        //    {
        // UIView *ContentView=(UIView *)[FollowTable viewWithTag:PreviousTag];
        [UIView animateWithDuration:0.5 animations:^{
            //            cCell.WhiteView.frame =CGRectMake(WhiteViewX,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
            
            cCell.WhiteView.frame =CGRectMake(-50.0/320.0*FULLWIDTH,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
        } completion:^(BOOL finished) {
            
            [swipedRows addObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]];
        }];
        // }
        
        //    UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:recognizer.view.tag];
        //
        //    [UIView animateWithDuration:0.5 animations:^{
        //
        //        ContentView.frame =CGRectMake(-50, ContentView.frame.origin.y, ContentView.frame.size.width, ContentView.frame.size.height);
        //    } completion:^(BOOL finished) {
        //        
        //        swiped=YES;
        //        PreviousTag=recognizer.view.tag;
        //    }];
        
    }
}
-(void)rightswipeHandler:(UISwipeGestureRecognizer *)recognizer {
    
    
    JMFavouriteCell *cCell=(JMFavouriteCell *)recognizer.view.superview.superview;
    
    if ([swipedRows containsObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]]) {
        
        
        
        //  UIView *ContentView=(UIView *)[FollowTable viewWithTag:recognizer.view.tag];
        //  CGRect finalFrame = CGRectMake(0, -100, 320, 301);
        [UIView animateWithDuration:0.5 animations:^{
            //  ContentView.frame = finalFrame;
            cCell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
        } completion:^(BOOL finished) {
            // swiped=NO;
            // PreviousTag=-100;
            
            [swipedRows removeObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]];
        }];
    }
}

-(void)deleteRow:(UIButton *)btn{
    
    listcount--;
    
    JMFavouriteCell *cCell=(JMFavouriteCell *)btn.superview.superview.superview;
    
    [swipedRows removeObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]];
    
    NSIndexPath *index=[FollowTable indexPathForCell:cCell];
    
    //  NSIndexPath *index=[NSIndexPath indexPathWithIndex:btn.tag];
    [FollowTable beginUpdates];
    [FollowTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
    
    [FollowTable endUpdates];
    
    
}
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    // [[UIButton appearance] setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"                 " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                                    {
//                                        // row=indexPath.row;
//                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do You Want To Delete This Property?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
//                                        [alertView show];
//
//                                    }];
//        delete.backgroundColor = [UIColor blueColor];
//
//  //  delete.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Delete"]];
//
//
//
//    return @[delete]; //array with all the buttons you want. 1,2,3, etc...
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
