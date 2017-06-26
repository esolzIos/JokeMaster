//
//  JMSearchViewController.m
//  JokeMaster
//
//  Created by santanu on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMSearchViewController.h"
#import "JMRecentlyUploadedViewController.h"
@interface JMSearchViewController ()

@end

@implementation JMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self.searchHeaderView.searchBtn addTarget:self action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addMoreView:self.view];
    
    
        [_RecentlyUploadedBtn setTitle:AMLocalizedString(@"RECENTLY UPLOADED VIDEOS", nil) forState:UIControlStateNormal];
    
    // header label font according to screen size
    [self.searchHeaderView.searchText setFont:[UIFont fontWithName:self.searchHeaderView.searchText.font.fontName size:[self getFontSize:self.searchHeaderView.searchText.font.pointSize]]];
    
     [_RecentlyUploadedBtn.titleLabel setFont:[UIFont fontWithName:_RecentlyUploadedBtn.titleLabel.font.fontName size:[self getFontSize:_RecentlyUploadedBtn.titleLabel.font.pointSize]]];
    
       self.searchHeaderView.searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"SEARCH BY NAME", nil) attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchClicked
{


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

- (IBAction)ratingClicked:(id)sender
{

}

- (IBAction)RecentlyUploadedVideoTapped:(id)sender
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

@end
