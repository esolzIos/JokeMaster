//
//  JMHomeViewController.m
//  JokeMaster
//
//  Created by priyanka on 08/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMRecentlyUploadedViewController.h"
@interface JMHomeViewController ()

@end

@implementation JMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
        [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    
    [_jokeTitle setFont:[UIFont fontWithName:_jokeTitle.font.fontName size:[self getFontSize:_jokeTitle.font.pointSize]]];
    
    [_categoryBtnlbl setFont:[UIFont fontWithName:_categoryBtnlbl.font.fontName size:[self getFontSize:_categoryBtnlbl.font.pointSize]]];
    
    [_recentBtn.titleLabel setFont:[UIFont fontWithName:_recentBtn.titleLabel.font.fontName size:[self getFontSize:_recentBtn.titleLabel.font.pointSize]]];
    
    
    [_jokeTitle setText:AMLocalizedString(@"JOKE OF THE DAY", nil)];
    
    [_categoryBtnlbl setText:AMLocalizedString(@"CHOOSE CATEGORY", nil)];
    
    [_recentBtn setTitle:AMLocalizedString(@"RECENTLY UPLOADED VIDEOS", nil) forState:UIControlStateNormal];
    
    
       [self.HeaderView.langBtn addTarget:self action:@selector(langClicked) forControlEvents:UIControlEventTouchUpInside];
    
//    MenuViewY=_MenuBaseView.frame.origin.y;
//    
//    _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
//    _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
//    
//    CategoryArray=[[NSMutableArray alloc] initWithObjects:@"LATEST",@"SEXUAL JOKES",@"ANIMAL JOKES",@"DOCTORS JOKES",@"GIRLFRIEND JOKES",@"STUPID JOKES", nil];
    
    
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
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)categoryClicked:(id)sender
{
//    _TransparentView.hidden=NO;
//    _MenuBaseView.hidden=NO;
//    
//    
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
//                     animations:^{
//                         _TransparentView.frame = CGRectMake(0, 0, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
//                         _MenuBaseView.frame = CGRectMake(0,MenuViewY, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
//                     }
//                     completion:^(BOOL finished){
//                     }];
    
    JMJokesCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMJokesCategoryVideoListViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

#pragma mark collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    JokeCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jokeCell" forIndexPath:indexPath];
    
    return ccell;
}

 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
        JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
        
        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }

    
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){



}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    return CGSizeMake(125.0f/320.0*FULLWIDTH, 90.0f/480.0*FULLHEIGHT);
}

- (IBAction)tutorialClicked:(id)sender {
    
    [_tutorialView setHidden:YES];
    
}
- (IBAction)recentClicked:(id)sender {
    
    JMRecentlyUploadedViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMRecentlyUploadedViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)jokeDetailClicked:(id)sender {
    
    [_optionView setHidden:NO];
    
}
- (IBAction)ratingClicked:(id)sender {
    
}
- (IBAction)likeClicked:(id)sender {
    
    [_optionView setHidden:YES];
    
 
}
- (IBAction)playClicked:(id)sender {
    
    
      [_optionView setHidden:YES];
    JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)shareClicked:(id)sender {
    
      [_optionView setHidden:YES];
}

-(void)langClicked
{


}
//#pragma mark - Category view hide
//- (IBAction)CategoryCrossTapped:(id)sender
//{
//    
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
//                     animations:^{
//                         _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
//                         _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
//                         
//                     }
//                     completion:^(BOOL finished){
//                         
//                         JMJokesCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMJokesCategoryVideoListViewController"];
//                         
//                         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//                         
//                     }];
//}
@end
