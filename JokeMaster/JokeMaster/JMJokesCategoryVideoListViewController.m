//
//  JMJokesCategoryVideoListViewController.m
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMJokesCategoryVideoListViewController.h"
#import "JMRecentlyUploadedViewController.h"
#import "JMCategoryVideoListViewController.h"
@interface JMJokesCategoryVideoListViewController ()

@end

@implementation JMJokesCategoryVideoListViewController
@synthesize ChooseCatImage,ChooseCategoryBtn,ChooseCategoryView,ChooseCategoryLabel,MainScroll,RecentVideoCollectionView,MenuBaseView,TransparentView,CategoryTable,CrossView,RecentlyUploadedBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addMoreView:self.view];
    
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
    
    
    [RecentlyUploadedBtn.titleLabel setFont:[UIFont fontWithName:RecentlyUploadedBtn.titleLabel.font.fontName size:[self getFontSize:RecentlyUploadedBtn.titleLabel.font.pointSize]]];
    
    [ChooseCategoryLabel setFont:[UIFont fontWithName:ChooseCategoryLabel.font.fontName size:[self getFontSize:ChooseCategoryLabel.font.pointSize]]];
    
    [RecentlyUploadedBtn setTitle:AMLocalizedString(@"RECENTLY UPLOADED VIDEOS", nil) forState:UIControlStateNormal];
    
    urlobj=[[UrlconnectionObject alloc] init];
    CategoryArray=[[NSMutableArray alloc] init];
    
    [self CategoryApi];
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
        return CGSizeMake(self.view.frame.size.width/3,105);
    }
    else if (IsIphone6)
    {
        return CGSizeMake(self.view.frame.size.width/3,123);
    }
    else
    {
        return CGSizeMake(self.view.frame.size.width/3,135);
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [CategoryArray count];;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
    
    
    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    
    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:9.0]]];
    
    cell.CategoryNameLabel.text = [[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"name"] uppercaseString];
    //
    [cell.VideoThumpnailImage sd_setImageWithURL:[NSURL URLWithString:[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"image"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
    
    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
    cell.VideoThumpnailImage.clipsToBounds=YES;
    //
    //    cell.categoryImage.layer.masksToBounds = YES;
    //    cell.categoryImage.layer.cornerRadius=5.0;
    //
    //    cell.OverlayView.layer.cornerRadius=5.0;
    
    return cell;
}

- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    JMCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMVideoList"];
    VC.CategoryId=[NSString stringWithFormat:@"%@",[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
    VC.CategoryName=[NSString stringWithFormat:@"%@",[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    
    
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
    
    JMCategoryCell *cell = [CategoryTable cellForRowAtIndexPath:indexPath];
    
    [cell.CheckButton setHighlighted:YES];
    [cell.CheckButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)RecentlyUploadedVideoTapped:(id)sender
{
    JMRecentlyUploadedViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMRecentlyUploadedViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
#pragma mark -Category list API
-(void)CategoryApi
{
    
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.view.userInteractionEnabled = NO;
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/video/category",GLOBALAPI];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
//                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         CategoryArray=[[responseDict objectForKey:@"details"] mutableCopy];
                         
                         
                         if (CategoryArray.count>0)
                         {
                             
                             
                             [RecentVideoCollectionView reloadData];
                         }
                         else
                         {
                             [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"No Category Found",nil)];
                         }
                         
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     
                 }
                 else
                 {
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       [self checkLoader];
                                       self.view.userInteractionEnabled = YES;
                                       NSLog(@"Failure");
                                       
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       
                                   }
             ];
        }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
    }
}
@end
