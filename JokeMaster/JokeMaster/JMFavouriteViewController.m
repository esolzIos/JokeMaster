//
//  JMFavouriteViewController.m
//  JokeMaster
//
//  Created by priyanka on 14/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMFavouriteViewController.h"

@interface JMFavouriteViewController ()

@end

@implementation JMFavouriteViewController
@synthesize mainscroll,FavouriteTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:100];
//    WhiteViewX=ContentView.frame.origin.x;
    
    
    swiped=NO;
    PreviousTag=-100;
    oneTime=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 30;
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
        return 100;
    }
    else
    {
        return 100;
    }
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(JMFavouriteCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.WhiteView.tag=indexPath.row+500;
    DebugLog(@"tag %ld",(long)cell.WhiteView.tag);
    
    if (oneTime==NO)
    {
        WhiteViewX=cell.WhiteView.frame.origin.x;
        oneTime=YES;
    }
    
    
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
    
    
    if (swiped==NO)
    {
        
    }
    else
    {
        UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:PreviousTag];
        [UIView animateWithDuration:0.5 animations:^{
            ContentView.frame =CGRectMake(WhiteViewX, ContentView.frame.origin.y, ContentView.frame.size.width, ContentView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:recognizer.view.tag];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        ContentView.frame =CGRectMake(-50, ContentView.frame.origin.y, ContentView.frame.size.width, ContentView.frame.size.height);
    } completion:^(BOOL finished) {
        
        swiped=YES;
        PreviousTag=recognizer.view.tag;
    }];
    
    
}
-(void)rightswipeHandler:(UISwipeGestureRecognizer *)recognizer {
    
    
    UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:recognizer.view.tag];
    //  CGRect finalFrame = CGRectMake(0, -100, 320, 301);
    [UIView animateWithDuration:0.5 animations:^{
        //  ContentView.frame = finalFrame;
        ContentView.frame =CGRectMake(WhiteViewX, ContentView.frame.origin.y, ContentView.frame.size.width, ContentView.frame.size.height);
    } completion:^(BOOL finished) {
        swiped=NO;
        PreviousTag=-100;
    }];
    
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

@end
