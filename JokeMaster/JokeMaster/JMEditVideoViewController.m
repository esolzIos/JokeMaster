//
//  JMEditVideoViewController.m
//  JokeMaster
//
//  Created by santanu on 02/08/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMEditVideoViewController.h"
#import "AFNetworking.h"
#import "CountryCell.h"
@interface JMEditVideoViewController ()<UIPickerViewDelegate,UITextFieldDelegate,NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UITextFieldDelegate,NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>
{


    int rowSelected;
    bool langPickerOpen,catPickerOpen;
    NSMutableArray *langArr,*codeArr,*categoryArr;

    NSString *langSelected,*categorySelected;
    AppDelegate *app;
}
@property (nonatomic, retain) NSMutableData *dataToDownload;
@property (nonatomic) float downloadSize;
@end

@implementation JMEditVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.videoName.text=[_videoDict objectForKey:@"videoname"];
    

    [self.videoThumb sd_setImageWithURL:[NSURL URLWithString:[_videoDict objectForKey:@"videoimagename"]] placeholderImage:[UIImage imageNamed: @"noimage"]];

    
    
    

    
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self setRoundCornertoView:_loadingView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _videoName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Video Name",nil) attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self addMoreView:self.view];
    
    
    
    [_languagePicker setDelegate:self];
    
    
    [_jokeLang setFont:[UIFont fontWithName:_jokeLang.font.fontName size:[self getFontSize:_jokeLang.font.pointSize]]];
    [_categoryLbl setFont:[UIFont fontWithName:_categoryLbl.font.fontName size:[self getFontSize:_categoryLbl.font.pointSize]]];
   
    [_loadingLbl setFont:[UIFont fontWithName:_loadingLbl.font.fontName size:[self getFontSize:_loadingLbl.font.pointSize]]];
    
    [_tapInfo setFont:[UIFont fontWithName:_tapInfo.font.fontName size:[self getFontSize:_tapInfo.font.pointSize]]];
    
       [_uploadBtn.titleLabel setFont:[UIFont fontWithName:_uploadBtn.titleLabel.font.fontName size:[self getFontSize:_uploadBtn.titleLabel.font.pointSize]]];
    
    
    [_popTitle setFont:[UIFont fontWithName:_popTitle.font.fontName size:[self getFontSize:_popTitle.font.pointSize]]];
    
    _popTitle.layer.shadowColor = [[UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:0.3] CGColor];
    _popTitle.layer.shadowOffset = CGSizeMake(-2.0f,3.0f);
    _popTitle.layer.shadowOpacity = 1.0f;
    _popTitle.layer.shadowRadius = 1.0f;
    
    
    // Do any additional setup after loading the view.
    
    [_mainScroll setContentSize:CGSizeMake(FULLWIDTH,  470.0/480.0*FULLHEIGHT)];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageD = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageD];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];

    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    
    [_selectBtn setTitle:AMLocalizedString(@"Select", nil)  forState:UIControlStateNormal];
    
    [_cancelBttn setTitle:AMLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
}

-(void)viewWillAppear:(BOOL)animated

{
    categoryArr=[[NSMutableArray alloc] init];
    
    //    langArr=[[NSMutableArray alloc] initWithObjects:@"English",@"Hebrew",@"Hindi",@"Chinese",@"Spanish", nil];
    //
    //    codeArr=[[NSMutableArray alloc] initWithObjects:@"en",@"he",@"hi",@"zh",@"es", nil];
    
    langArr=[[NSMutableArray alloc] init];
    
    codeArr=[[NSMutableArray alloc] init];
    [_langBtn setUserInteractionEnabled:NO];
    [_categoryBtn setUserInteractionEnabled:NO];
    
    
    [self loadData];
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


- (IBAction)uploadClicked:(id)sender {
    if ([self textFieldBlankorNot:_videoName.text]) {
        [SVProgressHUD showInfoWithStatus:@"Video name cannot be blank"];
    }
    else if ([self textFieldBlankorNot:langSelected]) {
        [SVProgressHUD showInfoWithStatus:@"Select joke language"];
    }
    else if ([self textFieldBlankorNot:categorySelected]) {
        [SVProgressHUD showInfoWithStatus:@"Select joke Category"];
    }
   else
    {
        
//        [self addWarningView:self.view];
//        [self.warningTitle setText:AMLocalizedString(@"Note:", nil) ];
//        
//        [self.warningtext setText:AMLocalizedString(@"It might take a while to upload the video. Video will be listed on the app once it gets uploaded.", nil)];
//        
//        [self.warnChoice1 setText:AMLocalizedString(@"OK", nil)];
//        
//        [self.warnChoice2 setText:AMLocalizedString(@"CANCEL", nil)];
        
        
        // [_warningView setHidden:NO];
        
            [self fireAFUrl];
    }
}





- (IBAction)selectClicked:(id)sender {
    
    // selected=true;
    
    if (langPickerOpen) {
        [_jokeLang setText:[[langArr objectAtIndex:rowSelected]objectForKey:@"name"]];
        
        langSelected=[[langArr objectAtIndex:rowSelected]objectForKey:@"id"];
        
        // DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);
    }
    else if (catPickerOpen) {
        
        [_categoryLbl setText:[[[[categoryArr objectAtIndex:rowSelected]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString]];
        
        categorySelected=[[categoryArr objectAtIndex:rowSelected] objectForKey:@"id"];
        
        
    }
    
    
    
    [_pickerView setHidden:YES];
}
- (IBAction)cancelClicked:(id)sender {
    
    [_pickerView setHidden:YES];
}

#pragma mark picker delegates

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (langPickerOpen) {
        return langArr.count;
    }
    
    else if(catPickerOpen)
    {
        return categoryArr.count;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    // NSString *text = nil;
    // Reuse the label if possible, otherwise create and configure a new one
    if ((pickerLabel == nil) || ([pickerLabel class] != [UILabel class])) { //newlabel
        CGRect frame = CGRectMake(0.0, 0.0, 270, 32.0);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:14]];
        
        if (langPickerOpen) {
            [pickerLabel setText:[[langArr objectAtIndex:row]objectForKey:@"name"]];
        }
        else if (catPickerOpen) {
            
            NSString *htmlString = [[[[categoryArr objectAtIndex:row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
            
            pickerLabel.text = htmlString;
            
            // [pickerLabel setText:[[categoryArr objectAtIndex:row] objectForKey:@"name"]];
        }
    }
    pickerLabel.textColor = [UIColor whiteColor];
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 50.0/480.0*FULLHEIGHT;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (langPickerOpen) {
        return [[langArr objectAtIndex:rowSelected]objectForKey:@"name"];
    }
    
    else if(catPickerOpen)
    {
        return [[[[categoryArr objectAtIndex:row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
    }
    return @"";
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowSelected=(int)row;
    
    
    
}


- (IBAction)langClicked:(id)sender {
    
    
    if (langArr.count>0) {
        
        langPickerOpen=true;
        catPickerOpen=false;
        [_popTitle setText:@"SELECT JOKE LANGUAGE"];
        [_PopView setHidden:NO];
        [_popTable reloadData];
        
        
    }
}
- (IBAction)categoryClicked:(id)sender {
    
    if (categoryArr.count>0) {
        
        catPickerOpen=true;
        langPickerOpen=false;
        [_popTitle setText:@"CHOOSE CATEGORY"];
        [_PopView setHidden:NO];
        [_popTable reloadData];
        
        
    }
}




- (NSString *)generateBoundaryString {
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}

-(void)fireAFUrl
{
    
    [_loadingView setHidden:NO];
    [_infoLbl setText:@"UPDATING"];

    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        NSString *urlString;
        
        
        urlString=[NSString stringWithFormat:@"%@%@Video/update_video?video_id=%@&language=%@&country=%@&category=%@&videoname=%@",GLOBALAPI,INDEX,[_videoDict objectForKey:@"video_id"],langSelected,[[NSUserDefaults standardUserDefaults] objectForKey:@"userCountry"],categorySelected,_videoName.text];
        
        http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/Video/update_video?video_id=2&language=1&country=99&category=1&videoname=hgsd
        
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
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                // [_chooseBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    // [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                    [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        [_loaderView setHidden:YES];
                        
                            [self POPViewController];
                        //[SVProgressHUD dismiss];
                       // [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
                        
                    }
                    
                    else{
                        
                        //                            if (langArr.count==0) {
                        //
                        //                                [SVProgressHUD dismiss];
                        //                          }
                        //                            else{
                        //                                [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                            }
                        
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                        
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

-(void)GotoNextPageAfterSuccess
{

    [self POPViewController];
    
}

//-(void)fireUrl
//{
//
//    [_loadingView setHidden:NO];
//
//
//
//        if ([self networkAvailable])
//
//        {
//
//
//            [_uploadBtn setUserInteractionEnabled:NO];
//
//          //  [SVProgressHUD show];
//
//
//
//
//
//
//
//            //            NSData *imageData =  UIImagePNGRepresentation(selectedImage);
//
//            NSString  *encodedImgString = [self base64forData:imageData];
//
//            NSString  *encodedVidString = [self base64forData:videoData];
//
//            NSURL *url;
//
//
//
//            url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@Video/AddVideo",GLOBALAPI,INDEX]];
//
//
//
//            // configure the request
//
//            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//            [request setHTTPMethod:@"POST"];
//
//
//
//
//
//
//            NSString *sendData = @"user_id=";
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.userId]];
//
//
//            sendData = [sendData stringByAppendingString:@"&language="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", langSelected]];
//
//            sendData = [sendData stringByAppendingString:@"&country="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"]]];
//
//            sendData = [sendData stringByAppendingString:@"&category="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", categorySelected]];
//
//            sendData = [sendData stringByAppendingString:@"&videoname="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", _videoName.text]];
//
//
//
//            sendData = [sendData stringByAppendingString:@"&mode="];
//            sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
//
//            sendData = [sendData stringByAppendingString:@"&pushmode="];
//            sendData = [sendData stringByAppendingString: PUSHTYPE];
//
//            DebugLog(@"data:%@",sendData);
//
//
//            sendData = [sendData stringByAppendingString:@"&video="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedVidString]];
//
//            sendData = [sendData stringByAppendingString:@"&videoimage="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedImgString]];
//
//            [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//           // NSString *boundary = [self generateBoundaryString];
//
//          //  [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//
//           // [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//            NSMutableData *theBodyData = [NSMutableData data];
//
//            theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//
//           // [request setHTTPBody:theBodyData];
//
//            //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
//
//            session =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//
//            NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//                [_uploadBtn setUserInteractionEnabled:YES];
//
//
//                if (error) {
//                    NSLog(@"error = %@", error);
//
//                          [SVProgressHUD showInfoWithStatus:@"some error occured"];
//                    return;
//                }
//
//                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                    NSError *jsonError;
//                    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
//
//
//
//                    if (jsonError) {
//                        // Error Parsing JSON
//                        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//                        [SVProgressHUD showInfoWithStatus:@"some error occured"];
//
//                        NSLog(@"response = %@ %@",responseString,jsonError.description);
//                    } else {
//                        // Success Parsing JSON
//                        // Log NSDictionary response:
//                        NSLog(@"result = %@",jsonResponse);
//
//                            if ([[jsonResponse objectForKey:@"status"]boolValue]) {
//
//
//
//                                [SVProgressHUD showInfoWithStatus:@"Video uploaded Successfully"];
//
//                                 [self loadProfile];
//
//                             //   [self performSelector:@selector(loadProfile) withObject:nil afterDelay:3.0];
//
//                              //  [[NSNotificationCenter defaultCenter]
//                               //  postNotificationName:@"videoLoaded"
//                              //   object:self];
//
//
//
//                            }
//
//                            else{
//
//                                [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
//
//
//
//                          ;
//                            }
//
//                    }
//
//
//                }
//
//
//            }];
//
//
//            [task resume];
//
//          //  [self loadProfile];
//
//
//
//
//        }
//
//        else
//
//        {
//
//            [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//
//
//
//        }
//
//
//
//
//
//}


-(void)loadData
{
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        //  [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
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
                
                // [_langBtn setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                [_langBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                    [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    //                    [SVProgressHUD showInfoWithStatus:@"some error occured 3"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        
                        langArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        
                        
                        for (NSDictionary *langDict in langArr) {
                            
                            if ([[_videoDict objectForKey:@"language"] isEqualToString:[langDict objectForKey:@"id"]]) {
                                
                                  langSelected=[langDict objectForKey:@"id"];
                                [_jokeLang setText:[langDict objectForKey:@"name"]];
                            }
                        }
                        
                        
                        if (langArr.count>0) {
                            [_langBtn setUserInteractionEnabled:YES];
                        }
                        else{
                            
                            [_langBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        [self loadCategory];
                        
                        
                    }
                    
                    
                    else{
                        
                        //                        if (langArr.count==0) {
                        //
                        //                            [SVProgressHUD dismiss];
                        //                        }
                        //                        else{
                        //                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                        }
                        //
                        
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
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
        //[SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
}

-(void)loadCategory
{
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@video/category?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
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
                
                // [_langBtn setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                //  [_langBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                    [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    // [SVProgressHUD showInfoWithStatus:@"some error occured 1"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        
                        categoryArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        //totalCount=(int)categoryArr.count;
                        
                        [_categoryBtn setUserInteractionEnabled:YES];
                        
                        // [SVProgressHUD dismiss];
                        
                        [_loaderView setHidden:YES];
                        
                        
                        for (NSDictionary *catDict in categoryArr) {
                            
                            if ([[_videoDict objectForKey:@"category"] isEqualToString:[catDict objectForKey:@"id"]]) {
                                
                                [_categoryLbl setText:[[[catDict objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString]];
                                
                                categorySelected=[catDict  objectForKey:@"id"];
                            }
                        }
                        
                        
                        if (categoryArr.count>0) {
                            
                            [_langBtn setUserInteractionEnabled:YES];
                            //[_languagePicker reloadAllComponents];
                        }
                        else{
                            
                            [_langBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    else{
                        
                        //                        if (categoryArr.count==0) {
                        //
                        //                            [SVProgressHUD dismiss];
                        //                        }
                        //                        else{
                        //                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        //                        }
                        
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                        
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//   didSendBodyData:(int64_t)bytesSent
//    totalBytesSent:(int64_t)totalBytesSent
//totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
//{
//    
//        DebugLog(@"%f",(float)totalBytesSent);
//        DebugLog(@"%f",(float)totalBytesExpectedToSend);
//    
//    DebugLog(@"%f",(float)((float)totalBytesSent/(float)totalBytesExpectedToSend));
//    
//    //[SVProgressHUD showProgress:(float)((float)totalBytesSent/(float)totalBytesExpectedToSend)];
//    
//    [_loadingLbl setText:[NSString stringWithFormat:@"%.f%@",((float)((float)totalBytesSent/(float)totalBytesExpectedToSend))*100,@"%"]];
//}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    if (langPickerOpen) {
        return [langArr count];
    }
    else if (catPickerOpen)
    {
        return [categoryArr count];
    }
    else
        return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"CountryCell";
    
    CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //  cell.CheckImage.tag=indexPath.row+500;
    //  cell.CheckButton.tag=indexPath.row;
    //  [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsIphone5 || IsIphone4)
    {
        return 50;
    }
    else
    {
        return 60;
    }
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(CountryCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (catPickerOpen) {
        
        if ([categorySelected isEqualToString:[[categoryArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
        {
            
            cell.CheckImage.image = [UIImage imageNamed:@"tick"];
            
            
            
        }
        else
        {
            
            cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
        }
        
        
        
        [cell.CountryLabel setText:AMLocalizedString([[[[categoryArr objectAtIndex:indexPath.row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString], nil) ];
        
        [cell.CountryLabel setFont:[UIFont fontWithName:cell.CountryLabel.font.fontName size:[self getFontSize:11.0]]];
        
        
    }
    else if (langPickerOpen)
    {
        if ([langSelected isEqualToString:[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
        {
            
            cell.CheckImage.image = [UIImage imageNamed:@"tick"];
            
            
            
        }
        else
        {
            
            cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
        }
        
        
        
        
        
        [cell.CountryLabel setText:AMLocalizedString([[[langArr objectAtIndex:indexPath.row]objectForKey:@"name"] uppercaseString], nil) ];
        
        [cell.CountryLabel setFont:[UIFont fontWithName:cell.CountryLabel.font.fontName size:[self getFontSize:11.0]]];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  CountryCell *cCell=[_CountryTable cellForRowAtIndexPath:indexPath];
    
    
    
    
    if (catPickerOpen) {
        
        if (![categorySelected isEqualToString:[[categoryArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
        {
            
            categorySelected=[[categoryArr objectAtIndex:indexPath.row]objectForKey:@"id"];
            
            
            [_categoryLbl setText:AMLocalizedString([[[[categoryArr objectAtIndex:indexPath.row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString], nil) ];
        }
        else
        {
            categorySelected=@"";
            
        }
        
        
        [_popTable reloadData];
        
        
    }
    else if (langPickerOpen){
        
        
        
        if (![langSelected isEqualToString:[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
        {
            
            langSelected=[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"];
            [_jokeLang setText:AMLocalizedString([[langArr objectAtIndex:indexPath.row]objectForKey:@"name"], nil)];
        }
        else
        {
            langSelected=@"";
            
        }
        
        
        [_popTable reloadData];
        
        
    }
}


- (IBAction)popChoosed:(id)sender
{
    
    
    
    [_PopView setHidden:YES];
    
    
}

- (IBAction)goBackClicked:(id)sender
{
    [_PopView setHidden:YES];
}
@end
