//
//  JMRecentlyUploadedViewController.m
//  JokeMaster
//
//  Created by priyanka on 10/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMRecentlyUploadedViewController.h"

@interface JMRecentlyUploadedViewController ()

@end

@implementation JMRecentlyUploadedViewController
@synthesize ChooseCatImage,ChooseCategoryBtn,ChooseCategoryView,ChooseCategoryLabel,MainScroll,RecentVideoCollectionView,MenuBaseView,TransparentView,CategoryTable,CrossView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ChooseCategoryLabel.frame=CGRectMake(ChooseCatImage.frame.origin.x-ChooseCategoryLabel.frame.size.width-6, ChooseCategoryLabel.frame.origin.y, ChooseCategoryLabel.frame.size.width, ChooseCategoryLabel.frame.size.height);
    
    ChooseCategoryLabel.text=AMLocalizedString(@"CHOOSE CATEGORY",nil);
    
    if (IsIphone6)
    {
        RecentVideoCollectionView.frame=CGRectMake(RecentVideoCollectionView.frame.origin.x, RecentVideoCollectionView.frame.origin.y+10, RecentVideoCollectionView.frame.size.width, RecentVideoCollectionView.frame.size.height);
    }
    else if (IsIphone6plus)
    {
        RecentVideoCollectionView.frame=CGRectMake(RecentVideoCollectionView.frame.origin.x, RecentVideoCollectionView.frame.origin.y+16, RecentVideoCollectionView.frame.size.width, RecentVideoCollectionView.frame.size.height);
    }
    
    MenuViewY=MenuBaseView.frame.origin.y;
    
    TransparentView.frame = CGRectMake(0, self.view.frame.size.height, TransparentView.frame.size.width, TransparentView.frame.size.height);
    MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
    
    CategoryArray=[[NSMutableArray alloc] initWithObjects:@"LATEST",@"SEXUAL JOKES",@"ANIMAL JOKES",@"DOCTORS JOKES",@"GIRLFRIEND JOKES",@"STUPID JOKES", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - CollectionView delegates

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsIphone5)
    {
        return CGSizeMake(self.view.frame.size.width/3,90);
    }
    else if (IsIphone6)
    {
        return CGSizeMake(self.view.frame.size.width/3,104);
    }
    else
    {
        return CGSizeMake(self.view.frame.size.width/3,112);
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
    
    
    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
    cell.VideoThumpnailImage.clipsToBounds=YES;
    
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
#pragma mark - Choose Category
- (IBAction)ChooseCategoryTapped:(id)sender
{
    TransparentView.hidden=NO;
    MenuBaseView.hidden=NO;
 
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         TransparentView.frame = CGRectMake(0, 0, TransparentView.frame.size.width, TransparentView.frame.size.height);
                         MenuBaseView.frame = CGRectMake(0,MenuViewY, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
  
}
#pragma mark - Category view hide
- (IBAction)CategoryCrossTapped:(id)sender
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         TransparentView.frame = CGRectMake(0, self.view.frame.size.height, TransparentView.frame.size.width, TransparentView.frame.size.height);
                         MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
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
    
    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"language"]] isEqualToString:@"he"])
    {
        cell.CategoryLabel.textAlignment=NSTextAlignmentRight;
    }
    else
    {
        cell.CategoryLabel.textAlignment=NSTextAlignmentLeft;
    }
    
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
    UIImageView *tickImage = (UIImageView* )[CategoryTable viewWithTag:tag+500];
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
