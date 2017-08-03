//
//  JMProfileVidViewController.m
//  JokeMaster
//
//  Created by santanu on 27/07/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMProfileVidViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "JMUploadVideoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import "DZNPhotoEditorViewController.h"
#import "UIImagePickerController+Edit.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "UrlconnectionObject.h"
#import "JMPlayVideoViewController.h"
@interface JMProfileVidViewController ()
{
    
       NSURLSession *session;
    BOOL firedOnce,catFonteSet;
    NSDictionary *jsonResponse;
    AppDelegate *appDelegate;

    UrlconnectionObject *urlobj;
    NSMutableArray *videoArr;

    int totalCount,page;
    UIFont *catFont,*videoFont;
}

@end

@implementation JMProfileVidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMoreView:self.view];
    
       self.HeaderView.HeaderLabel.text=_categoryName;
    MenuViewY=_MenuBaseView.frame.origin.y;
    
    _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
    _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    urlobj=[[UrlconnectionObject alloc] init];
    
    CategoryArray=[[NSMutableArray alloc] init];
    
    [_userName setFont:[UIFont fontWithName:_userName.font.fontName size:[self getFontSize:_userName.font.pointSize]]];
    
    [_scoreLbl setFont:[UIFont fontWithName:_scoreLbl.font.fontName size:[self getFontSize:_scoreLbl.font.pointSize]]];
    
    
    [_membershipDate setFont:[UIFont fontWithName:_membershipDate.font.fontName size:[self getFontSize:_membershipDate.font.pointSize]]];
    
    [_CategoryLabel setFont:[UIFont fontWithName:_CategoryLabel.font.fontName size:[self getFontSize:_CategoryLabel.font.pointSize]]];
    
    
  [_profileCountryLbl setFont:[UIFont fontWithName:_profileCountryLbl.font.fontName size:[self getFontSize:_profileCountryLbl.font.pointSize]]];
    
    
    


      //  self.HeaderView.HeaderLabel.text=_categoryName;

    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    jsonResponse=[[NSDictionary alloc]init];
    videoArr=[[NSMutableArray alloc]init];
  
    page=1;
    totalCount=0;
    [_userName setText:[NSString stringWithFormat:@"%@",[_ProfileUserName capitalizedString]]];
    
 [_profileImage sd_setImageWithURL:[NSURL URLWithString:_ProfileuserImage] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    [_countryImage sd_setImageWithURL:[NSURL URLWithString:_ProfileFlag] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
        [_profileCountryLbl setText:[NSString stringWithFormat:@"%@",_ProfileCountry]];
    
    [self loadVideos];
    
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
    
   return CGSizeMake(self.view.frame.size.width/3,130.0/480.0*FULLHEIGHT);
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return videoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
    
    
    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
    cell.VideoThumpnailImage.clipsToBounds=YES;
    
    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:9.0]]];
    
    //   NSLog(@"%@",[arrCategory objectAtIndex:indexPath.row]);
    
    cell.CategoryNameLabel.text = [[[videoArr objectAtIndex:indexPath.row]objectForKey:@"videoname" ] uppercaseString];
    
    [cell.VideoThumpnailImage sd_setImageWithURL:[NSURL URLWithString:[[videoArr objectAtIndex:indexPath.row]objectForKey:@"videoimagename" ]] placeholderImage:[UIImage imageNamed: @"noimage"]];
    //
    //    cell.categoryImage.layer.masksToBounds = YES;
    //    cell.categoryImage.layer.cornerRadius=5.0;
    //
    //    cell.OverlayView.layer.cornerRadius=5.0;
    
    return cell;
}

- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{

    
        JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
        VC.VideoId=[[videoArr objectAtIndex:indexPath.row] valueForKey:@"id"];
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




#pragma mark - video list API

-(void)loadVideos
{
    
     [_loaderView setHidden:NO];
    
    
    if([self networkAvailable])
    {
       // [SVProgressHUD show];
        
        
        NSString *urlString;
        
     urlString=[NSString stringWithFormat:@"%@%@Video?categoryid=%@&language=&country=&userid=%@&page=%d&limit=15&mode=%@",GLOBALAPI,INDEX,_categoryId,_ProfileUserId,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        DebugLog(@"Send string Url%@",urlString);
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error = %@", error);
                
                //                [_gifImage setHidden:YES];
                //                [_noVideoView setHidden:NO];
                //                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                //                [_loaderBtn setHidden:NO];
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                [SVProgressHUD showInfoWithStatus:@"some error occured"];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                 //   [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                                        [_gifImage setHidden:YES];
                                        [_noVideoView setHidden:NO];
                                          [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                                        [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        //[SVProgressHUD dismiss];
                        
                         [_loaderView setHidden:YES];
                        
                           totalCount=[[jsonResponse objectForKey:@"totalcount"] intValue];
                        
                        NSArray     *resultArr=[[jsonResponse objectForKey:@"videoDetails"] mutableCopy];
                        
                        
                        for(NSDictionary *dict in resultArr) {
                            [videoArr addObject:dict];
                            
                        }
                        
                        
                        if (videoArr.count>0)
                        {
                            [_noVidLbl setHidden:YES];
                            
                            DebugLog(@"%f",(float)videoArr.count/3.0);
                            
                            DebugLog(@"%f",ceil((float)videoArr.count/3.0));
                            
                            
                            float collectionHeight= (130.0/480.0*FULLHEIGHT)*ceil(((float)videoArr.count/3.0));
                            
                            
                            [_categoryCollectionView setFrame:CGRectMake(_categoryCollectionView.frame.origin.x, _categoryCollectionView.frame.origin.y, FULLWIDTH, collectionHeight)];
                            
                            
                            [_MainScroll setContentSize:CGSizeMake(FULLWIDTH, 150.0/480.0*FULLHEIGHT + _categoryCollectionView.frame.size.height)];
                            
                            [_categoryCollectionView  reloadData];
                        }
                        
                    }
                    else{
                      //  [SVProgressHUD dismiss];
                        if (videoArr.count>0) {
                            
                              [_loaderView setHidden:YES];
                            
                            
                            [_noVidLbl setHidden:YES];
                        }
                        else{
                            
                            
                            [_noVidLbl setHidden:NO];
                            
                            //  [SVProgressHUD showInfoWithStatus:@"No videos Found"];
                            
                                                        [_gifImage setHidden:YES];
                                                        [_noVideoView setHidden:NO];
                                                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
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
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
        // [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // DebugLog(@"Table Y Position:%f",_StockTable.frame.origin.y);
    if (scrollView==_MainScroll && totalCount>videoArr.count)
    {
        
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        
        float reload_distance = -60.0f;
        if(y > h + reload_distance)
        {
            
            
            
            if (!firedOnce) {
                [_categoryCollectionView setUserInteractionEnabled:NO];
                
                firedOnce=true;
                page++;
                
                [self loadVideos];
                
            }
        }
    }
}
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_noVideoView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
    jsonResponse=[[NSDictionary alloc]init];
    videoArr=[[NSMutableArray alloc]init];
  
    page=1;
    totalCount=0;
    [self loadVideos];
    
    
    
}
@end

