//
//  JMRecentlyUploadedViewController.m
//  JokeMaster
//
//  Created by priyanka on 10/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMRecentlyUploadedViewController.h"
#import "UrlconnectionObject.h"
@interface JMRecentlyUploadedViewController ()
{
    NSURLSession *session;
    BOOL firedOnce,catFonteSet;
    NSDictionary *jsonResponse;
    AppDelegate *appDelegate;


    NSMutableArray *videoArr;
    NSString *categoryId;
    int totalCount,page;
    UIFont *catFont,*videoFont;

}
@end

@implementation JMRecentlyUploadedViewController
@synthesize ChooseCatImage,ChooseCategoryBtn,ChooseCategoryView,ChooseCategoryLabel,MainScroll,RecentVideoCollectionView,MenuBaseView,TransparentView,CategoryTable,CrossView,LoaderView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addMoreView:self.view];
    self.HeaderView.HeaderLabel.text= AMLocalizedString(@"Recently Uploaded",nil);
    
    ChooseCategoryLabel.frame=CGRectMake(ChooseCatImage.frame.origin.x-ChooseCategoryLabel.frame.size.width-6, ChooseCategoryLabel.frame.origin.y, ChooseCategoryLabel.frame.size.width, ChooseCategoryLabel.frame.size.height);
    
    ChooseCategoryLabel.text=AMLocalizedString(@"CHOOSE CATEGORY",nil);
    
   // LoaderView.layer.cornerRadius=8.0;
    
    if (IsIphone6)
    {
        RecentVideoCollectionView.frame=CGRectMake(RecentVideoCollectionView.frame.origin.x, RecentVideoCollectionView.frame.origin.y+10, RecentVideoCollectionView.frame.size.width,RecentVideoCollectionView.frame.size.height);
    }
    else if (IsIphone6plus)
    {
        RecentVideoCollectionView.frame=CGRectMake(RecentVideoCollectionView.frame.origin.x, RecentVideoCollectionView.frame.origin.y+16, RecentVideoCollectionView.frame.size.width, RecentVideoCollectionView.frame.size.height);
    }
    
    MenuViewY=MenuBaseView.frame.origin.y;
    
    TransparentView.frame = CGRectMake(0, self.view.frame.size.height, TransparentView.frame.size.width, TransparentView.frame.size.height);
    MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
    
    urlobj=[[UrlconnectionObject alloc] init];

    
    [ChooseCategoryLabel setFont:[UIFont fontWithName:ChooseCategoryLabel.font.fontName size:[self getFontSize:ChooseCategoryLabel.font.pointSize]]];
    
    
    
       appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
}

-(void)viewWillAppear:(BOOL)animated
{
 
    categoryId=@"";
  CategoryArray=[[NSMutableArray alloc] init];
    RecentVideoArray=[[NSMutableArray alloc] init];
    page=1;
    totalCount=0;
    
   [self RecentVideoApi];
  
}
- (IBAction)loaderClicked:(id)sender {
    
    
   // categoryId=@"";
    CategoryArray=[[NSMutableArray alloc] init];
    RecentVideoArray=[[NSMutableArray alloc] init];
    page=1;
    totalCount=0;
    
     [self RecentVideoApi];
    
    
    
    
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
     return CGSizeMake(self.view.frame.size.width/3,120.0/480.0*FULLHEIGHT);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [RecentVideoArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
    
    
    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell.VideoThumpnailImage sd_setImageWithURL:[NSURL URLWithString:[[RecentVideoArray objectAtIndex:indexPath.row]objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];
    
    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
    cell.VideoThumpnailImage.clipsToBounds=YES;
    
    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:9.0]]];
    
    
    cell.CategoryNameLabel.text = [[[RecentVideoArray objectAtIndex:indexPath.row]objectForKey:@"videoname" ] uppercaseString];
    
    //   NSLog(@"%@",[arrCategory objectAtIndex:indexPath.row]);
    
    //    cell.categoryLbl.text = [[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"category_name" ] uppercaseString];
    //
    //    [cell.categoryImage sd_setImageWithURL:[NSURL URLWithString:[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"picture" ]] placeholderImage:[UIImage imageNamed: @"NoJob"]];
    //
    //    cell.categoryImage.layer.masksToBounds = YES;
    //    cell.categoryImage.layer.cornerRadius=5.0;
    //
    //    cell.OverlayView.layer.cornerRadius=5.0;
    
    cell.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    [UIView animateWithDuration:0.3/1.5 animations:^{
        cell.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            cell.contentView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                cell.contentView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    JMPlayVideoViewController *VC=[appDelegate.storyBoard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
     VC.VideoId=[[RecentVideoArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (scrollView==RecentVideoCollectionView && totalCount>RecentVideoArray.count)
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
                [self RecentVideoApi];
                
           
        
        }
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
#pragma mark - Choose Category
- (IBAction)ChooseCategoryTapped:(id)sender
{
    TransparentView.hidden=NO;
    MenuBaseView.hidden=NO;
    
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         if (CategoryArray.count>0)
                         {
                             TransparentView.frame = CGRectMake(0, 0, TransparentView.frame.size.width, TransparentView.frame.size.height);
                             MenuBaseView.frame = CGRectMake(0,MenuViewY, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
                             
                              [CategoryTable reloadData];
                         }
                         else
                         {
                             [self CategoryApi];
                         }
                         
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
                     completion:^(BOOL finished)
     {
         //                         JMJokesCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMJokesCategoryVideoListViewController"];
         //
         //                         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
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
    
    
//    
//    cell.CategoryLabel.text=[[CategoryArray objectAtIndex:indexPath.row] valueForKey:@"name"];
//    
//    //    [cell.CategoryLabel setFont:[UIFont fontWithName:cell.CategoryLabel.font.fontName size:[self getFontSize:cell.CategoryLabel.font.pointSize]]];
//    
//    if (IsIphone5)
//    {
//        [cell.CategoryLabel setFont:[UIFont fontWithName:cell.CategoryLabel.font.fontName size:16]];
//    }
//    else if (IsIphone6)
//    {
//        [cell.CategoryLabel setFont:[UIFont fontWithName:cell.CategoryLabel.font.fontName size:18]];
//    }
//    else if (IsIphone6plus)
//    {
//        [cell.CategoryLabel setFont:[UIFont fontWithName:cell.CategoryLabel.font.fontName size:20]];
//    }
//    
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
    cell.CategoryLabel.text=[[[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
    
    
    if (!catFonteSet) {
        catFont=[UIFont fontWithName:cell.CategoryLabel.font.fontName size:[self getFontSize:cell.CategoryLabel.font.pointSize]];
        
        catFonteSet=true;
    }
    [cell.CategoryLabel setFont:catFont];
    
    
    if ([categoryId isEqualToString:[[CategoryArray objectAtIndex:indexPath.row] valueForKey:@"id"]])
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"tick"];
    }
    else
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMCategoryCell *cell = [CategoryTable cellForRowAtIndexPath:indexPath];
    
    if (![categoryId isEqualToString:[[CategoryArray objectAtIndex:indexPath.row] valueForKey:@"id"]])
    {
        categoryId=[[CategoryArray objectAtIndex:indexPath.row] valueForKey:@"id"];
        cell.CheckImage.image = [UIImage imageNamed:@"tick"];
    }
    else
    {
        categoryId=@"";
        cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
    }
    
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
//                     animations:^{
//                         TransparentView.frame = CGRectMake(0, self.view.frame.size.height, TransparentView.frame.size.width, TransparentView.frame.size.height);
//                         MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
//                     }
//                     completion:^(BOOL finished)
//     {
//         JMCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMVideoList"];
//         VC.CategoryId=[NSString stringWithFormat:@"%@",[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"id"]];
//         VC.CategoryName=[NSString stringWithFormat:@"%@",[[CategoryArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
//         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    
//         [cell.CheckButton setHighlighted:NO];
//         [cell.CheckButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    // }];
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         TransparentView.frame = CGRectMake(0, self.view.frame.size.height, TransparentView.frame.size.width, TransparentView.frame.size.height);
                         MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
                     }
                     completion:^(BOOL finished)
     {
         
         
         [RecentVideoArray removeAllObjects];
             [RecentVideoCollectionView reloadData];
         page=1;
         totalCount=0;
         [self RecentVideoApi];
         
     }];

    
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
            
            
                  urlString=[NSString stringWithFormat:@"%@index.php/video/category?language=%@&mode=%@",GLOBALAPI,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
//            urlString=[NSString stringWithFormat:@"%@index.php/video/category?mode=%@",GLOBALAPI,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
//            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         CategoryArray=[[NSMutableArray alloc]init];
                         
                         NSMutableDictionary *zerodict=[[NSMutableDictionary alloc]init];
                         
                         [zerodict setObject:AMLocalizedString(@"All", nil)  forKey:@"name"];
                         [zerodict setObject:@"" forKey:@"id"];
                         [zerodict setObject:@"" forKey:@"image"];
                         
                         [CategoryArray addObject:zerodict];
                         
                         
                         for (NSDictionary *dict in [[responseDict objectForKey:@"details"] mutableCopy]) {
                             
                             [CategoryArray addObject:dict];
                             
                             
                         } 
                         
                         
                         
                         
                         if (CategoryArray.count>0)
                         {
                             [UIView animateWithDuration:0.5
                                                   delay:0.1
                                                 options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                                              animations:^{
                                                  TransparentView.frame = CGRectMake(0, 0, TransparentView.frame.size.width, TransparentView.frame.size.height);
                                                  MenuBaseView.frame = CGRectMake(0,MenuViewY, MenuBaseView.frame.size.width, MenuBaseView.frame.size.height);
                                                  
                                                  [CategoryTable reloadData];
                                              }
                                              completion:^(BOOL finished){
                                              }];
                         }
                         
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         //                         [[[UIAlertView alloc]initWithTitle:@"Error!" message:[responseDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     
                 }
                 else
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       [self checkLoader];
                                       self.view.userInteractionEnabled = YES;
                                       NSLog(@"Failure");
                                       //                                       [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                                       
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       
                                   }
             ];
        }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
        //        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark -Recent Video list API
-(void)RecentVideoApi
{
    
    [_loaderHUDView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        //   [SVProgressHUD show];
        
        
            NSString *urlString;
            
            
            
            urlString=[NSString stringWithFormat:@"%@%@Video?categoryid=%@&language=%@&country=%@&userid=&page=%d&limit=15&mode=%@",GLOBALAPI,INDEX,categoryId,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"],[[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"],page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
            
            
            
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
                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
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
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    //  [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                            [_loaderHUDView setHidden:YES];
                        
                       //  RecentVideoArray=[[responseDict objectForKey:@"details"] mutableCopy];
                         
                         totalCount=[[jsonResponse objectForKey:@"totalcount"]intValue];
                         
                         NSMutableArray *TempArray=[[NSMutableArray alloc] init];
                         TempArray=[[jsonResponse objectForKey:@"videoDetails"] mutableCopy];
                         
                            [_novidLbl setHidden:YES];
                         
                         if (TempArray.count>0)
                         {
                  
                           //  LoaderView.hidden=YES;
                             for ( NSDictionary *tempDict1 in  TempArray)
                             {
                                 [RecentVideoArray addObject:tempDict1];
                                 
                             }
                         //    [RecentVideoArray addObject:[responseDict objectForKey:@"details"]];
                             [RecentVideoCollectionView reloadData];
                         }
                         else
                         {
                        
                           //  LoaderView.hidden=YES;
                         }
                         
                     }
                    else{
                                [_loaderHUDView setHidden:YES];
                        
                        if (RecentVideoArray.count>0) {
                            
                       
                                 [_novidLbl setHidden:YES];
                        }
                        else{
                            
                    
                            [_novidLbl setHidden:NO];
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
        // [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
}
@end
