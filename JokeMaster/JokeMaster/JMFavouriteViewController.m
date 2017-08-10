//
//  JMFavouriteViewController.m
//  JokeMaster
//
//  Created by priyanka on 14/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMFavouriteViewController.h"
#import "JMProfileViewController.h"
#import "JMPlayVideoViewController.h"
@interface JMFavouriteViewController ()
{
    //int listcount;
    
    NSMutableArray *swipedRows;
    
    NSURLSession *session;
    BOOL firedOnce,fontSet;
    NSDictionary *jsonResponse;
    AppDelegate *appDelegate;
    

    NSMutableArray *videoArr;
    int totalCount,page;


}
@end

@implementation JMFavouriteViewController
@synthesize mainscroll,FavouriteTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:100];
//    WhiteViewX=ContentView.frame.origin.x;
        [self addMoreView:self.view];
    
//    swiped=NO;
//    PreviousTag=-100;
    ///oneTime=NO;
    //listcount=30;
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    swipedRows=[[NSMutableArray alloc]init];
    
    
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
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/useraction/favouritelisting?userid=1&page=1&limit=1
        url=[NSString stringWithFormat:@"%@%@useraction/favouritelisting?userid=%@&page=%d&limit=15&mode=%@",GLOBALAPI,INDEX,appDelegate.userId,page,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
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
                        
                        
                        
                    NSArray    *resultArr=[[jsonResponse objectForKey:@"videodetails"] copy];
                        
                        totalCount=[[jsonResponse objectForKey:@"totalcount"]intValue];
                        
                              [_loaderView setHidden:YES];
                        
                      //  [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in resultArr) {
                            
                            [videoArr addObject:Dict];
                            
                            
                        }
                        
                        
                        
                        if (videoArr.count>0) {
                            
                            
                                [FavouriteTable reloadData];
                                
                            }
                        else{
                            
                            [FavouriteTable setUserInteractionEnabled:NO];
                            
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
        
      //  [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
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
   // return 95.0/480.0*FULLHEIGHT;
    
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(JMFavouriteCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    
    [cell.ProfileNameLabel setFont:[UIFont fontWithName:cell.ProfileNameLabel.font.fontName size:[self getFontSize:10]]];
    [cell.JokesNameLabel setFont:[UIFont fontWithName:cell.JokesNameLabel.font.fontName size:[self getFontSize:9]]];
    [cell.RatingLabel setFont:[UIFont fontWithName:cell.RatingLabel.font.fontName size:[self getFontSize:9]]];
    

    
      [cell.ProfileImage sd_setImageWithURL:[NSURL URLWithString:[videoDict objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    [cell.JokesNameLabel setText:[videoDict objectForKey:@"username"]];
    
        [cell.ProfileNameLabel setText:[videoDict objectForKey:@"videoname"]];
    
         [cell.RatingLabel setText:[NSString stringWithFormat:@"%.2f/5",[[videoDict objectForKey:@"averagerating"] floatValue]]];
    
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
    
    JMPlayVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMPlayVideoViewController"];
       VC.VideoId=[videoDict valueForKey:@"id"];
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    
    JMFavouriteCell *cCell=(JMFavouriteCell *)recognizer.view.superview.superview;
    
          if (![swipedRows containsObject:[NSString stringWithFormat:@"%ld",[FavouriteTable indexPathForCell:cCell].row]]) {
    
//    NSIndexPath *index=[FavouriteTable indexPathForCell:cCell];
//    if (swiped==NO)
//    {
//        
//    }
//    else
//    {
       // UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:PreviousTag];
        [UIView animateWithDuration:0.5 animations:^{
//            cCell.WhiteView.frame =CGRectMake(WhiteViewX,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
            
              cCell.WhiteView.frame =CGRectMake(-50.0/320.0*FULLWIDTH,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
        } completion:^(BOOL finished) {
            
            [swipedRows addObject:[NSString stringWithFormat:@"%ld",[FavouriteTable indexPathForCell:cCell].row]];
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
    
      if ([swipedRows containsObject:[NSString stringWithFormat:@"%ld",[FavouriteTable indexPathForCell:cCell].row]]) {
    

    
  //  UIView *ContentView=(UIView *)[FavouriteTable viewWithTag:recognizer.view.tag];
    //  CGRect finalFrame = CGRectMake(0, -100, 320, 301);
    [UIView animateWithDuration:0.5 animations:^{
        //  ContentView.frame = finalFrame;
        cCell.WhiteView.frame =CGRectMake(23.0/320.0*FULLWIDTH,  cCell.WhiteView.frame.origin.y,  cCell.WhiteView.frame.size.width,  cCell.WhiteView.frame.size.height);
    } completion:^(BOOL finished) {
       // swiped=NO;
       // PreviousTag=-100;
        
         [swipedRows removeObject:[NSString stringWithFormat:@"%ld",[FavouriteTable indexPathForCell:cCell].row]];
    }];
      }
}

-(void)deleteRow:(UIButton *)btn{
    
    //listcount--;
    
    JMFavouriteCell *cCell=(JMFavouriteCell *)btn.superview.superview.superview;
    
    [swipedRows removeObject:[NSString stringWithFormat:@"%ld",[FavouriteTable indexPathForCell:cCell].row]];
    
    NSIndexPath *index=[FavouriteTable indexPathForCell:cCell];
    
    
     NSDictionary *videoDict=[videoArr objectAtIndex:index.row];
    
    if([self networkAvailable])
    {
        
        [btn setUserInteractionEnabled:NO];
        
        
        
        
        [SVProgressHUD show];
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/useraction/likeunlikevideo?videoid=21&userid=1
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@useraction/likeunlikevideo",GLOBALAPI,INDEX]];
        
        // configure the request
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        

        
        NSString *sendData = @"videoid=";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",[videoDict objectForKey:@"id"]]];
        
        sendData = [sendData stringByAppendingString:@"&userid="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",appDelegate.userId]];
        
              sendData = [sendData stringByAppendingString:@"&mode="];
        sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
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
                        
                        
                        [FavouriteTable beginUpdates];
                        [FavouriteTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
                        
                        
                        [videoArr removeObjectAtIndex:index.row];
                        
                        [FavouriteTable endUpdates];
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
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:AMLocalizedString(@"Check your Internet connection",nil)] ;
    }
    

    
    
    
    //  NSIndexPath *index=[NSIndexPath indexPathWithIndex:btn.tag];

    
    
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
    
    
    if (scrollView==FavouriteTable && totalCount>videoArr.count)
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
