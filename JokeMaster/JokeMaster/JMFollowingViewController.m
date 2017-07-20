//
//  JMFollowingViewController.m
//  JokeMaster
//
//  Created by priyanka on 16/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMFollowingViewController.h"
#import "JMProfileViewController.h"
@interface JMFollowingViewController ()
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

@implementation JMFollowingViewController
@synthesize FollowTable,mainscroll;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    swiped=NO;
    //    PreviousTag=-100;
    ///oneTime=NO;
   // listcount=30;
    
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
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/Follow/followerlisting?userid=3&page=1&limit=15
        
        url=[NSString stringWithFormat:@"%@%@Follow/followerlisting?userid=%@&page=%d&limit=15&mode=%@",GLOBALAPI,INDEX,appDelegate.userId,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
        
        
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
                        
                        
                        
                        NSArray    *resultArr=[[jsonResponse objectForKey:@"userdetails"] copy];
                        
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
    
    if ([swipedRows containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
        cell.WhiteView.frame =CGRectMake(-50.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);
    }
    else{
        cell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cell.WhiteView.frame.origin.y,  cell.WhiteView.frame.size.width,  cell.WhiteView.frame.size.height);
    }
    
    [cell.deleteBtn addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRoundCornertoView:cell.profileFrame withBorderColor:[UIColor clearColor] WithRadius:0.2];
       [self setRoundCornertoView:cell.ProfileImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    //    [cell.ProfileNameLabel setFont:[UIFont fontWithName:cell.ProfileNameLabel.font.fontName size:[self getFontSize:cell.ProfileNameLabel.font.pointSize]]];
    //    [cell.JokesNameLabel setFont:[UIFont fontWithName:cell.JokesNameLabel.font.fontName size:[self getFontSize:cell.JokesNameLabel.font.pointSize]]];
    //    [cell.RatingLabel setFont:[UIFont fontWithName:cell.RatingLabel.font.fontName size:[self getFontSize:cell.RatingLabel.font.pointSize]]];
    
    
    [cell.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    [cell.JokesNameLabel setText:[videoDict objectForKey:@"rank"]];
    
    [cell.ProfileNameLabel setText:[videoDict objectForKey:@"name"]];
    
    [cell.RatingLabel setText:[NSString stringWithFormat:@"%@/5",[videoDict objectForKey:@"score"]]];

    
    
    cell.RatingView.maximumValue = 5;
    cell.RatingView.minimumValue = 0;
    cell.RatingView.value = [[videoDict objectForKey:@"score"] floatValue];
    cell.RatingView.userInteractionEnabled=NO;
    //    _RatingView.tintColor = [UIColor clearColor];
    cell.RatingView.allowsHalfStars = YES;
    cell.RatingView.emptyStarImage = [[UIImage imageNamed:@"emotion"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cell.RatingView.filledStarImage = [[UIImage imageNamed:@"emotion2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  cell.RatingView.accurateHalfStars = YES;
    cell.RatingView.halfStarImage = [[UIImage imageNamed:@"emotion1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    gestureRecognizer.view.tag=cell.WhiteView.tag;
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [cell.WhiteView addGestureRecognizer:gestureRecognizer];
    
    
    UISwipeGestureRecognizer *rightgestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightswipeHandler:)];
    rightgestureRecognizer.view.tag=cell.WhiteView.tag;
    [rightgestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [cell.WhiteView addGestureRecognizer:rightgestureRecognizer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *videoDict=[videoArr objectAtIndex:indexPath.row];
    
    JMProfileViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMProfile"];
    VC.ProfileUserId=[videoDict objectForKey:@"followingid"];
    
    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
}
-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    JMFavouriteCell *cCell=(JMFavouriteCell *)recognizer.view.superview.superview;
    
    if (![swipedRows containsObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]]) {
        
        //    NSIndexPath *index=[FollowTable indexPathForCell:cCell];
        //    if (swiped==NO)
        //    {
        //
        //    }
        //    else
        //    {
        // UIView *ContentView=(UIView *)[FollowTable viewWithTag:PreviousTag];
        [UIView animateWithDuration:0.5 animations:^{
            //            cCell.WhiteView.frame =CGRectMake(WhiteViewX,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
            
            cCell.WhiteView.frame =CGRectMake(-50.0/320.0*FULLWIDTH,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
        } completion:^(BOOL finished) {
            
            [swipedRows addObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]];
        }];
        // }
        
        //    UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:recognizer.view.tag];
        //
        //    [UIView animateWithDuration:0.5 animations:^{
        //
        //        ContentView.frame =CGRectMake(-50, ContentView.frame.origin.y, ContentView.frame.size.width, ContentView.frame.size.height);
        //    } completion:^(BOOL finished) {
        //        
        //        swiped=YES;
        //        PreviousTag=recognizer.view.tag;
        //    }];
        
    }
}
-(void)rightswipeHandler:(UISwipeGestureRecognizer *)recognizer {
    
    
    JMFavouriteCell *cCell=(JMFavouriteCell *)recognizer.view.superview.superview;
    
    if ([swipedRows containsObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]]) {
        
        
        
        //  UIView *ContentView=(UIView *)[FollowTable viewWithTag:recognizer.view.tag];
        //  CGRect finalFrame = CGRectMake(0, -100, 320, 301);
        [UIView animateWithDuration:0.5 animations:^{
            //  ContentView.frame = finalFrame;
            cCell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
        } completion:^(BOOL finished) {
            // swiped=NO;
            // PreviousTag=-100;
            
            [swipedRows removeObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]];
        }];
    }
}

-(void)deleteRow:(UIButton *)btn{
    
   // listcount--;
    
    JMFavouriteCell *cCell=(JMFavouriteCell *)btn.superview.superview.superview;
    
    [swipedRows removeObject:[NSString stringWithFormat:@"%ld",[FollowTable indexPathForCell:cCell].row]];
    
    NSIndexPath *index=[FollowTable indexPathForCell:cCell];
    
    //  NSIndexPath *index=[NSIndexPath indexPathWithIndex:btn.tag];
    NSDictionary *videoDict=[videoArr objectAtIndex:index.row];
    
    if([self networkAvailable])
    {
        
        [btn setUserInteractionEnabled:NO];
        
        
        
        
        [SVProgressHUD show];
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/follow/followunfollowuser?follower_id=32&following_id=40
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@follow/followunfollowuser",GLOBALAPI,INDEX]];
        
        // configure the request
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        
        
        NSString *sendData = @"follower_id=";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userId]];
        
        sendData = [sendData stringByAppendingString:@"&following_id="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",[videoDict objectForKey:@"followingid"]]];
        
        sendData = [sendData stringByAppendingString:@"&mode="];
        sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
        
        sendData = [sendData stringByAppendingString:@"&pushmode="];
        sendData = [sendData stringByAppendingString: PUSHTYPE];
        
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSMutableData *theBodyData = [NSMutableData data];
        
        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
        
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [SVProgressHUD showErrorWithStatus:@"Some error occured"];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *Response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                [btn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"Some error occured"];
                    
                    
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    
                    [SVProgressHUD dismiss];
                    
                    NSLog(@"result = %@",Response);
                    
                    
                    if ([[Response objectForKey:@"status"]boolValue]) {
                        
                        
                        [FollowTable beginUpdates];
                        [FollowTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
                        
                        
                        [videoArr removeObjectAtIndex:index.row];
                        
                        [FollowTable endUpdates];
                    }
                    
                    else{
                        
                        [SVProgressHUD showInfoWithStatus:[Response objectForKey:@"message"]];
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
                
                
                
            }
        }];
        
        
        [task resume];
        
        
    }
    else{
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
    }
    

    
    
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
