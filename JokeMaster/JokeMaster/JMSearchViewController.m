//
//  JMSearchViewController.m
//  JokeMaster
//
//  Created by santanu on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMSearchViewController.h"
#import "JMRecentlyUploadedViewController.h"
@interface JMSearchViewController ()<UITextFieldDelegate>
{
    NSString *searchedText;
     UrlconnectionObject *urlobj;
        int totalCount,page;
        UIFont  *videoFont;
        NSMutableArray *videoArr;
    
    NSURLSession *session;
    BOOL firedOnce,fontSet;
    NSDictionary *jsonResponse;
    AppDelegate *appDelegate;
    

}
@end

@implementation JMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
      [self.searchHeaderView.searchBtn addTarget:self action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addMoreView:self.view];
    

    [self.searchHeaderView.searchText setDelegate:self];
    
    
    // header label font according to screen size

    

    
       self.searchHeaderView.searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"SEARCH BY NAME", nil) attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    
       [self.searchHeaderView.searchText setFont:[UIFont fontWithName:self.searchHeaderView.searchText.font.fontName size:[self getFontSize:self.searchHeaderView.searchText.font.pointSize]]];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
  page=1;
    totalCount=0;
     urlobj=[[UrlconnectionObject alloc] init];
    videoArr=[[NSMutableArray alloc]init];
    
}
-(void)searchClicked
{
    
    searchedText=self.searchHeaderView.searchText.text;
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        // [SVProgressHUD show];
        
        
            NSString *urlString;
            
            //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/search?searchValue=test1&language=1&country=99&page=1&limit=15
            
            urlString=[NSString stringWithFormat:@"%@%@search?searchValue=%@&language=%@&country=%@&page=%d&limit=30&mode=%@",GLOBALAPI,INDEX,searchedText,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"],page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [_gifImage setHidden:YES];
                [_noVideoView setHidden:NO];
                [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                [_loaderBtn setHidden:NO];
                
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                    [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                    [_loaderBtn setHidden:NO];
                    
                    //  [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        [_loaderView setHidden:YES];
                        
                        
                         //  RecentVideoArray=[[responseDict objectForKey:@"details"] mutableCopy];
                         
                         totalCount=[[jsonResponse objectForKey:@"totalcount"]intValue];
                         
                         NSMutableArray *TempArray=[[NSMutableArray alloc] init];
                         TempArray=[[jsonResponse objectForKey:@"videoDetails"] mutableCopy];
                         
                         
                         
                         if (TempArray.count>0)
                         {
                             

                             for ( NSDictionary *tempDict1 in  TempArray)
                             {
                                 [videoArr addObject:tempDict1];
                                 
                             }
                     
                            
                         }
                         [_jokeTable reloadData];
                         
                     }
                    else{
                        
                        if (videoArr.count>0) {
                            
                            [_loaderView setHidden:YES];
                            
                        }
                        else{
                            
                            
                            [_gifImage setHidden:YES];
                            [_noVideoView setHidden:NO];
                            [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n Click to retry",[jsonResponse objectForKey:@"message"]]];
                            [_loaderBtn setHidden:NO];
                        }
                        
                        
                    }
                    
                }
                
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"Check your Internet connection\n\n Click to retry"]];
        [_loaderBtn setHidden:NO];
        
        //  [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }


}

#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//#pragma mark - CollectionView delegates
//
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
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
//    
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return videoArr.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
//    
//    
//    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    
//      [cell.VideoThumpnailImage sd_setImageWithURL:[NSURL URLWithString:[[videoArr objectAtIndex:indexPath.row]objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
//    
//    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
//    cell.VideoThumpnailImage.clipsToBounds=YES;
//    
//    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:9.0]]];
//    
//    //   NSLog(@"%@",[arrCategory objectAtIndex:indexPath.row]);
//    
//    cell.CategoryNameLabel.text = [[[videoArr objectAtIndex:indexPath.row]objectForKey:@"videoname" ] uppercaseString];
//    //
//    //    [cell.categoryImage sd_setImageWithURL:[NSURL URLWithString:[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"picture" ]] placeholderImage:[UIImage imageNamed: @"NoJob"]];
//    //
//    //    cell.categoryImage.layer.masksToBounds = YES;
//    //    cell.categoryImage.layer.cornerRadius=5.0;
//    //
//    //    cell.OverlayView.layer.cornerRadius=5.0;
//    
//    return cell;
//}
//
//- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
//    VC.VideoId=[[videoArr objectAtIndex:indexPath.row] valueForKey:@"id"];
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
//    
//    
//}
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return videoArr.count;
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
    // return 95.0/480.0*FULLHEIGHT;
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(JMFavouriteCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    
    

        cell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);

    
    
    
    [self setRoundCornertoView:cell.profileFrame withBorderColor:[UIColor clearColor] WithRadius:0.2];
    [self setRoundCornertoView:cell.ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    

    
    
    [cell.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    [cell.JokesNameLabel setText:[videoDict objectForKey:@"username"]];
    
    [cell.ProfileNameLabel setText:[videoDict objectForKey:@"videoname"]];
    
    [cell.RatingLabel setText:[NSString stringWithFormat:@"%@/5",[videoDict objectForKey:@"averagerating"]]];
    
    [cell.RatingLabel setHidden:YES];
    
    [cell.countryImage setHidden:NO];
    
    [cell.countryImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"country_image"]]];
    
    
    cell.RatingView.maximumValue = 5;
    cell.RatingView.minimumValue = 0;
    cell.RatingView.value =[[videoDict objectForKey:@"averagerating"] floatValue];
    cell.RatingView.userInteractionEnabled=NO;
    //    _RatingView.tintColor = [UIColor clearColor];
    cell.RatingView.allowsHalfStars = YES;
    cell.RatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.RatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    cell.RatingView.accurateHalfStars = YES;
    cell.RatingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    
    JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
    VC.VideoId=[videoDict valueForKey:@"id"];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    

}

- (IBAction)ratingClicked:(id)sender
{

}

- (IBAction)RecentlyUploadedVideoTapped:(id)sender
{

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    searchedText=textField.text;
    
    [textField resignFirstResponder];
    
    page=1;
    totalCount=0;
    [videoArr removeAllObjects];
    
    
    [self searchClicked];
    
    

    return  YES;
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (scrollView==_jokeTable && totalCount>videoArr.count)
    {
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        
        float reload_distance = -10.0f;
        
        
        if(y > h + reload_distance)
        {
            

            page += 1;
            [self searchClicked];
            
            
            
            
        }
    }
}
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_noVideoView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
  
    page=1;
    totalCount=0;
    [videoArr removeAllObjects];
    
    
    [self searchClicked];

    
    
    
    
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
