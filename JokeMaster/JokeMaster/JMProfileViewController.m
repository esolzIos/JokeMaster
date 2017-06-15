//
//  JMProfileViewController.m
//  JokeMaster
//
//  Created by santanu on 15/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMProfileViewController.h"

@interface JMProfileViewController ()

@end

@implementation JMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      CategoryArray=[[NSMutableArray alloc] initWithObjects:@"LATEST",@"SEXUAL JOKES",@"ANIMAL JOKES",@"DOCTORS JOKES",@"GIRLFRIEND JOKES",@"STUPID JOKES", nil];
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
    
    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:cell.CategoryNameLabel.font.pointSize]]];
    
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
}
@end
