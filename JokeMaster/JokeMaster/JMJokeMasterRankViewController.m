//
//  JMJokeMasterRankViewController.m
//  JokeMaster
//
//  Created by priyanka on 16/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMJokeMasterRankViewController.h"

@interface JMJokeMasterRankViewController ()

@end

@implementation JMJokeMasterRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        return 120;
    }
    else
    {
        return 100;
    }
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(JMFavouriteCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    DebugLog(@"tag %ld",(long)cell.WhiteView.tag);
    
    if (oneTime==NO)
    {
        WhiteViewX=cell.WhiteView.frame.origin.x;
        oneTime=YES;
    }
    
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
    
    if (indexPath.row==0)
    {
        cell.CrownImage.hidden=NO;
       
      
    }
    else
    {
        cell.CrownImage.hidden=YES;
    }
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
