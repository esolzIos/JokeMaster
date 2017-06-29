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
{
    BOOL liked;
}
@end

@implementation JMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self addMoreView:self.view];
    
    
    
    
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
    
    urlobj=[[UrlconnectionObject alloc] init];
    
    RecentVideoArray=[[NSMutableArray alloc] init];
    
    [self RecentVideoApi];
    
    
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
#pragma mark - Category button click
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
    return [RecentVideoArray count];
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    JokeCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jokeCell" forIndexPath:indexPath];
    
    [ccell.jokeThumb sd_setImageWithURL:[NSURL URLWithString:[[RecentVideoArray objectAtIndex:indexPath.row]objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
    
    return ccell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
    VC.VideoDictionary=[RecentVideoArray objectAtIndex:indexPath.row];
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
#pragma mark - tutorial view click
- (IBAction)tutorialClicked:(id)sender {
    
    [_tutorialView setHidden:YES];
    
}
#pragma mark - recent button click
- (IBAction)recentClicked:(id)sender {
    
    JMRecentlyUploadedViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMRecentlyUploadedViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)jokeDetailClicked:(id)sender {
    
    //    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //    [anim setToValue:[NSNumber numberWithFloat:0.0f]];
    //    [anim setFromValue:[NSNumber numberWithDouble:M_PI/16]]; // rotation angle
    //    [anim setDuration:0.1];
    //    [anim setRepeatCount:NSUIntegerMax];
    //    [anim setAutoreverses:YES];
    //    [[_ratingImage layer] addAnimation:anim forKey:@"iconShake"];
    
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.4;
    anim.toValue = [NSNumber numberWithFloat:0.8];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [anim setRepeatCount:NSUIntegerMax];
    [anim setAutoreverses:YES];
    
    [[_ratingImage layer] addAnimation:anim forKey:nil];
    
    
    if (liked) {
        [_likeImage setImage:[UIImage imageNamed:@"like"]];
        
    }
    else{
        [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
    }
    [_optionView setHidden:NO];
    
}
- (IBAction)ratingClicked:(id)sender {
    [_ratingImage.layer removeAllAnimations];
    
    [_ratingView setHidden:NO];
    
    
}
- (IBAction)likeClicked:(id)sender {
    
    
    if (!liked) {
        [_likeImage setImage:[UIImage imageNamed:@"like"]];
        liked=true;
        
        
    }
    else{
        [_likeImage setImage:[UIImage imageNamed:@"unlike"]];
        
        liked=false;
    }
    //[_optionView setHidden:YES];
    //  [_ratingImage.layer removeAllAnimations];
    
}
#pragma mark - play button click
- (IBAction)playClicked:(id)sender {
    
    
    [_optionView setHidden:YES];
    [_ratingImage.layer removeAllAnimations];
    JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
     VC.VideoDictionary=[RecentVideoArray objectAtIndex:0];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)shareClicked:(id)sender {
    [_ratingImage.layer removeAllAnimations];
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
- (IBAction)crossClicked:(id)sender {
    
    [_ratingView setHidden:YES];
    
}
#pragma mark -Recent Video list API
-(void)RecentVideoApi
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
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Videolisting?pageno=1&limit=10",GLOBALAPI];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 //  [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[NSString stringWithFormat:@"%@",[responseDict objectForKey:@"status"]] isEqualToString:@"Success"])
                     {
                         RecentVideoArray=[[responseDict objectForKey:@"details"] mutableCopy];
                         
                         
                         if (RecentVideoArray.count>0)
                         {
                             _tvView.hidden=NO;
                             _tutorialView.hidden=NO;
                             
                             if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"HomeVisited"] boolValue]==YES)
                             {
                                 _tutorialView.hidden=YES;
                             }
                             else
                             {
                                 _tutorialView.hidden=NO;
                             }
                             
                             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HomeVisited"];
                             
                             
                             
                             _VideoNameLabel.text=[[RecentVideoArray objectAtIndex:0]objectForKey:@"videoname"];
                             _VideoCreaterNameLabel.text=[[RecentVideoArray objectAtIndex:0]objectForKey:@"username"];
                             _VideoRatingLabel.text=[NSString stringWithFormat:@"%@/5",[[RecentVideoArray objectAtIndex:0]objectForKey:@"rating"]];
                             
                             
                             _VideoRatingView.maximumValue = 5;
                             _VideoRatingView.minimumValue = 0;
                             _VideoRatingView.value =[[[RecentVideoArray objectAtIndex:0]objectForKey:@"rating"] floatValue];
                             _VideoRatingView.userInteractionEnabled=NO;
                             //    _RatingView.tintColor = [UIColor clearColor];
                             _VideoRatingView.allowsHalfStars = YES;
                             _VideoRatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                             _VideoRatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                             
                             
                             [_videoThumb sd_setImageWithURL:[NSURL URLWithString:[[RecentVideoArray objectAtIndex:0]objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
                             
                             [_jokeCollectionView reloadData];
                         }
                         
                     }
                     else
                     {
                         _tvView.hidden=YES;
                         _tutorialView.hidden=YES;
                         
                         
                         
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     _tvView.hidden=YES;
                     _tutorialView.hidden=YES;
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     
                 }
                 else
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     _tvView.hidden=YES;
                     _tutorialView.hidden=YES;
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       // [self checkLoader];
                                       self.view.userInteractionEnabled = YES;
                                       _tutorialView.hidden=YES;
                                       NSLog(@"Failure");
                                       //                                       [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                                       _tvView.hidden=YES;
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       
                                   }
             ];
        }];
    }
    else
    {
        _tvView.hidden=YES;
        _tutorialView.hidden=YES;
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
    }
}
@end
