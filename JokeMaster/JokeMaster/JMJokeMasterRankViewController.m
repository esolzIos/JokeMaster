//
//  JMJokeMasterRankViewController.m
//  JokeMaster
//
//  Created by priyanka on 16/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMJokeMasterRankViewController.h"
#import "JMProfileViewController.h"
@interface JMJokeMasterRankViewController ()
{
    // int listcount;
    
    NSMutableArray *swipedRows;
    
    NSURLSession *session;
    BOOL firedOnce,fontSet;
    NSDictionary *jsonResponse;
    AppDelegate *appDelegate;
    
    
    NSMutableArray *videoArr;
    int totalCount,page;
    
}
@end

@implementation JMJokeMasterRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self addMoreView:self.view];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    swipedRows=[[NSMutableArray alloc]init];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    // Do any additional setup after loading the view.
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
        
        
        
       // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/Useraction/userankinglisting?page=1&limit=15
        
        url=[NSString stringWithFormat:@"%@%@Useraction/userankinglisting?page=%d&limit=15&mode=%@",GLOBALAPI,INDEX,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
        
        
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
                        
                        
                        
                        NSArray    *resultArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        totalCount=[[jsonResponse objectForKey:@"totalcount"]intValue];
                        
                        
                        
                        [_loaderView setHidden:YES];
                        // [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in resultArr) {
                            
                            [videoArr addObject:Dict];
                            
                            
                        }
                        
                        
                        
                        if (videoArr.count>0) {
                            
                            
                            [_RankTable reloadData];
                            
                        }
                        else{
                            
                            [_RankTable setUserInteractionEnabled:NO];
                            
                        }
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
        
        // [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
    
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
  
//    DebugLog(@"tag %ld",(long)cell.WhiteView.tag);
//    
//    if (oneTime==NO)
//    {
//        WhiteViewX=cell.WhiteView.frame.origin.x;
//        oneTime=YES;
//    }
    
    [self setRoundCornertoView:cell.ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.36];
    
    
    NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    
    if ([swipedRows containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.WhiteView.frame =CGRectMake(-50.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);
    }
    else{
        cell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);
    }
    
    [cell.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
     [cell.RankLabel setText:[NSString stringWithFormat:@"RANK %@",[videoDict objectForKey:@"rank"]]];
    
    [cell.ProfileNameLabel setText:[videoDict objectForKey:@"username"]];
    
    [cell.RatingLabel setText:[NSString stringWithFormat:@"%@/5",[videoDict objectForKey:@"score"]]];
    
    
    [self setRoundCornertoView:cell.profileFrame withBorderColor:[UIColor clearColor] WithRadius:0.2];
    [self setRoundCornertoView:cell.ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    cell.RatingView.maximumValue = 5;
    cell.RatingView.minimumValue = 0;
    cell.RatingView.value =[[videoDict objectForKey:@"score"] floatValue];
    cell.RatingView.userInteractionEnabled=NO;
    //    _RatingView.tintColor = [UIColor clearColor];
    cell.RatingView.allowsHalfStars = YES;
    cell.RatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.RatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     cell.RatingView.accurateHalfStars = YES;
     cell.RatingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (indexPath.row==0)
    {
        cell.CrownImage.hidden=NO;
       
      
    }
    else
    {
        cell.CrownImage.hidden=YES;
    }
    
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    
    JMProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
    VC.ProfileUserId=[videoDict objectForKey:@"user_id"];
    
    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
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
    
    
    if (scrollView==_RankTable && totalCount>videoArr.count)
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
