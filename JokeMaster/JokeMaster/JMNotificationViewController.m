//
//  JMNotificationViewController.m
//  JokeMaster
//
//  Created by santanu on 03/08/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMNotificationViewController.h"
#import "JMProfileViewController.h"
#import "JMPlayVideoViewController.h"
@interface JMNotificationViewController ()
{
    // int listcount;
    
  
    
    NSURLSession *session;
    BOOL firedOnce,fontSet;
    NSDictionary *jsonResponse;
    AppDelegate *appDelegate;
    
    
    NSMutableArray *videoArr;
    int totalCount,page;
    
}
@end

@implementation JMNotificationViewController
@synthesize FollowTable,mainscroll;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
       appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
}
-(void)appendPushView
{
    [self addPushView:self.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    videoArr=[[NSMutableArray alloc]init];
    
    page=1;
    totalCount=0;
    
    [self loadData];
    
    
}

-(void)loadData
{
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        //   [SVProgressHUD show];
        
        
        
        NSString *url;
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/Useraction/getNotification?userid=14&page=1&limit=10&mode=1
        
        url=[NSString stringWithFormat:@"%@%@Useraction/getNotification?userid=%@&page=%d&limit=15&mode=%@",GLOBALAPI,INDEX,appDelegate.userId,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
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
                        
                        
                        
                        NSArray    *resultArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        totalCount=[[jsonResponse objectForKey:@"totalcount"]intValue];
                        
                        
                        [_loaderView setHidden:YES];
                        // [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in resultArr) {
                            
                            [videoArr addObject:Dict];
                            
                            
                        }
                        
                        
                        
                        if (videoArr.count>0) {
                            
                            
                            [FollowTable reloadData];
                            
                        }
                        else{
                            
                            [FollowTable setUserInteractionEnabled:NO];
                            
                        }
                    }
                    else{
                        
                        if (videoArr.count>0) {
                            
                            [_loaderView setHidden:YES];
                            
                        }
                        else{
                            
                            
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(JMFavouriteCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    cell.WhiteView.tag=indexPath.row+500;
    //    DebugLog(@"tag %ld",(long)cell.WhiteView.tag);
    //
    //    if (oneTime==NO)
    //    {
    //        WhiteViewX=cell.WhiteView.frame.origin.x;
    //        oneTime=YES;
    //    }
    
    NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    

    
    [self setRoundCornertoView:cell.profileFrame withBorderColor:[UIColor clearColor] WithRadius:0.2];
    [self setRoundCornertoView:cell.ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    //    [cell.ProfileNameLabel setFont:[UIFont fontWithName:cell.ProfileNameLabel.font.fontName size:[self getFontSize:cell.ProfileNameLabel.font.pointSize]]];
    //    [cell.JokesNameLabel setFont:[UIFont fontWithName:cell.JokesNameLabel.font.fontName size:[self getFontSize:cell.JokesNameLabel.font.pointSize]]];
    //    [cell.RatingLabel setFont:[UIFont fontWithName:cell.RatingLabel.font.fontName size:[self getFontSize:cell.RatingLabel.font.pointSize]]];
    
    
    [cell.RankLabel setFont:[UIFont fontWithName:cell.RankLabel.font.fontName size:[self getFontSize:7.0]]];
    
    [cell.ProfileNameLabel setFont:[UIFont fontWithName:cell.ProfileNameLabel.font.fontName size:[self getFontSize:10.0]]];
    
    [cell.RatingLabel setFont:[UIFont fontWithName:cell.RatingLabel.font.fontName size:[self getFontSize:9.0]]];
    
    [cell.CountryName setFont:[UIFont fontWithName:cell.CountryName.font.fontName size:[self getFontSize:7.0]]];
    
    [cell.countryImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"countryimage"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    [cell.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"senderimage"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    
    
    [cell.RankLabel setText:[NSString stringWithFormat:@"RANK %@",[videoDict objectForKey:@"rank"]]];
    
    [cell.ProfileNameLabel setText:[videoDict objectForKey:@"sendername"]];
    
    [cell.CountryName setText:[NSString stringWithFormat:@"%@",[videoDict objectForKey:@"message"]]];
    
    
    
//    cell.RatingView.maximumValue = 5;
//    cell.RatingView.minimumValue = 0;
//    cell.RatingView.value = [[videoDict objectForKey:@"score"] floatValue];
//    cell.RatingView.userInteractionEnabled=NO;
//    //    _RatingView.tintColor = [UIColor clearColor];
//    cell.RatingView.allowsHalfStars = YES;
//    cell.RatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    cell.RatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    cell.RatingView.accurateHalfStars = YES;
//    cell.RatingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    
    
    if ( [[videoDict objectForKey:@"type"]intValue]==1) {
        
        

        //
        JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
        VC.VideoId=[videoDict valueForKey:@"videoid"];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    else
        if ( [[videoDict objectForKey:@"type"]intValue]==2) {
            
            
   
            //
            JMProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
            VC.ProfileUserId=[videoDict valueForKey:@"senderid"];
            
            
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }

    
//    JMProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
//    VC.ProfileUserId=[videoDict objectForKey:@"followingid"];
//
//    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
}

#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    // [[UIButton appearance] setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"                 " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
//                                    {
//                                        // row=indexPath.row;
//                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" Do You Want To Delete This Property?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
//                                        [alertView show];
//
//                                    }];
//        delete.backgroundColor = [UIColor blueColor];
//
//  //  delete.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Delete"]];
//
//
//
//    return @[delete]; //array with all the buttons you want. 1,2,3, etc...
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_noVideoView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
    videoArr=[[NSMutableArray alloc]init];
    
    page=1;
    totalCount=0;
    
    [self loadData];
    
    
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (scrollView==FollowTable && totalCount>videoArr.count)
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
            [self loadData];
            
            
            
        }
    }
}
@end
