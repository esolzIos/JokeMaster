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
- (IBAction)categoryClicked:(id)sender {
}

#pragma mark collection view delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    JokeCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jokeCell" forIndexPath:indexPath];
    
    return ccell;
}

 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
    
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
}
- (IBAction)shareClicked:(id)sender {
    
      [_optionView setHidden:YES];
}

-(void)langClicked
{


}
@end
