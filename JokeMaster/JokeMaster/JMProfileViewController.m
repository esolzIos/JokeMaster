//
//  JMProfileViewController.m
//  JokeMaster
//
//  Created by santanu on 15/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMProfileViewController.h"
#import "JMUploadVideoViewController.h"
@interface JMProfileViewController ()

@end

@implementation JMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MenuViewY=_MenuBaseView.frame.origin.y;
    
    _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
    _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
    


    
      CategoryArray=[[NSMutableArray alloc] initWithObjects:@"LATEST",@"SEXUAL",@"ANIMAL",@"DOCTOR",@"GIRLFRIEND",@"STUPID", nil];
    
    [_userName setFont:[UIFont fontWithName:_userName.font.fontName size:[self getFontSize:_userName.font.pointSize]]];
    
     [_scoreLbl setFont:[UIFont fontWithName:_scoreLbl.font.fontName size:[self getFontSize:_scoreLbl.font.pointSize]]];
    
    
      [_membershipDate setFont:[UIFont fontWithName:_membershipDate.font.fontName size:[self getFontSize:_membershipDate.font.pointSize]]];
    
       [_CategoryLabel setFont:[UIFont fontWithName:_CategoryLabel.font.fontName size:[self getFontSize:_CategoryLabel.font.pointSize]]];
    
    // Do any additional setup after loading the view.
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
#pragma mark - CollectionView delegates

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (IsIphone5)
//    {
//        return CGSizeMake(self.view.frame.size.width/3,105);
//    }
//    else if (IsIphone6)
//    {
//        return CGSizeMake(self.view.frame.size.width/3,123);
//    }
//    else
//    {
//        return CGSizeMake(self.view.frame.size.width/3,135);
//    }
    
 return CGSizeMake(self.view.frame.size.width/3,105.0/480.0*FULLHEIGHT);
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
    
    
    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
    cell.VideoThumpnailImage.clipsToBounds=YES;
    
    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:9.0]]];
    
    //   NSLog(@"%@",[arrCategory objectAtIndex:indexPath.row]);
    
    //    cell.categoryLbl.text = [[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"category_name" ] uppercaseString];
    //
    //    [cell.categoryImage sd_setImageWithURL:[NSURL URLWithString:[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"picture" ]] placeholderImage:[UIImage imageNamed: @"NoJob"]];
    //
    //    cell.categoryImage.layer.masksToBounds = YES;
    //    cell.categoryImage.layer.cornerRadius=5.0;
    //
    //    cell.OverlayView.layer.cornerRadius=5.0;
    
    return cell;
}

- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)followClicked:(id)sender {
    JMUploadVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMUploadVideoViewController"];
               [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)categoryClicked:(id)sender {
    _TransparentView.hidden=NO;
    _MenuBaseView.hidden=NO;
    
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         _TransparentView.frame = CGRectMake(0, 0, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
                         _MenuBaseView.frame = CGRectMake(0,MenuViewY, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];

}

- (IBAction)CategoryCrossTapped:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
                         _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                         
                     }];
}
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [CategoryArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"JMCategoryCell";
    
    JMCategoryCell *cell = (JMCategoryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.CategoryLabel.text=[CategoryArray objectAtIndex:indexPath.row];
    
    [cell.CategoryLabel setFont:[UIFont fontWithName:cell.CategoryLabel.font.fontName size:[self getFontSize:cell.CategoryLabel.font.pointSize]]];
    
    //    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"language"]] isEqualToString:@"he"])
    //    {
    //        cell.CategoryLabel.textAlignment=NSTextAlignmentRight;
    //    }
    //    else
    //    {
    //        cell.CategoryLabel.textAlignment=NSTextAlignmentLeft;
    //    }
    
    cell.CheckImage.tag=indexPath.row+500;
    cell.CheckButton.tag=indexPath.row;
    [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    //    if (IsIphone5 || IsIphone4)
    //    {
    //        return 50;
    //    }
    //    else
    //    {
    //        return 60;
    //    }
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(JMCategoryCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - Check button tapped on table
-(void)CheckButtonTap:(UIButton *)btn
{
    NSInteger tag=btn.tag;
    UIImageView *tickImage = (UIImageView* )[_CategoryTable viewWithTag:tag+500];
    if (btn.selected==NO)
    {
        btn.selected=YES;
        tickImage.image = [UIImage imageNamed:@"tick"];
    }
    else
    {
        btn.selected=NO;
        tickImage.image = [UIImage imageNamed:@"uncheck"];
    }
    
    
    
}

@end
