//
//  JMLanguageViewController.m
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//
#import "UrlconnectionObject.h"
#import "JMLanguageViewController.h"
#import "JMChooseCountryViewController.h"
#import "JMHomeViewController.h"
@interface JMLanguageViewController ()<UIPickerViewDelegate>
{
    NSMutableArray *langArr,*codeArr,*langCodeArr,*engArr,*hindiArr,*hebrewArr,*flagArr;
    
    NSMutableDictionary *langDict;
    UrlconnectionObject *urlobj;
    
    int rowSelected;
    NSString *  countrySelected,*langName,*langSelected;
    
    int totalCount;
    NSURLSession *session;
    NSMutableArray *jsonArr;
    NSMutableArray *langjsonArr;
    
    AppDelegate *app;
    
}
@end

@implementation JMLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
      //    engArr=[[NSMutableArray alloc] initWithObjects:@"UNITED STATES",@"UNITED KINGDOM",@"INDIA", nil];
    //
    //     hindiArr=[[NSMutableArray alloc] initWithObjects:@"INDIA",@"PAKISTAN", nil];
    //
    //      hebrewArr=[[NSMutableArray alloc] initWithObjects:@"ISRAEL", nil];
    //
    //    [langDict setObject:engArr forKey:@"en"];
    //
    //    [langDict setObject:hebrewArr forKey:@"he"] ;
    //
    //     [langDict setObject:hindiArr forKey:@"hi"] ;
    //
    
    [_LanguageLabel setFont:[UIFont fontWithName:_LanguageLabel.font.fontName size:[self getFontSize:_LanguageLabel.font.pointSize]]];
    
    [_countryTitle setFont:[UIFont fontWithName:_countryTitle.font.fontName size:[self getFontSize:_countryTitle.font.pointSize]]];
    
    _countryTitle.layer.shadowColor = [[UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:0.3] CGColor];
    _countryTitle.layer.shadowOffset = CGSizeMake(-2.0f,3.0f);
    _countryTitle.layer.shadowOpacity = 1.0f;
    _countryTitle.layer.shadowRadius = 1.0f;
   // [_LanguageLabel setText:AMLocalizedString(@"Choose Video Language", nil)];
    
    [_GoButton setTitle:AMLocalizedString(@"GO",nil) forState:UIControlStateNormal] ;
    
    [_languagePicker setDelegate:self];
    
    if (!_fromLogin) {
        langSelected=[[NSUserDefaults standardUserDefaults ]objectForKey:@"langId"];
       // countrySelected= [[NSUserDefaults standardUserDefaults ]objectForKey:@"countryId"];
        
        langName=[[NSUserDefaults standardUserDefaults ]objectForKey:@"language"];
    }
    
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    if (_fromLogin) {
      //  [_countryTitle setText:AMLocalizedString(@"Choose your country", nil) ];
        [_countryTitle setText:AMLocalizedString(@"Choose app language",nil)];
    }
    else{
      //  [_countryTitle setText:AMLocalizedString(@"Filter by Country",nil)];
       [_countryTitle setText:AMLocalizedString(@"Choose Video language",nil)];
    }
    
    
    [_selectBtn setTitle:AMLocalizedString(@"Select", nil)  forState:UIControlStateNormal];
    
    [_cancelBttn setTitle:AMLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    if (_fromSplash) {
        [self.HeaderView.BackView setHidden:YES];
        
    }
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    urlobj=[[UrlconnectionObject alloc] init];
    
    langDict=[[NSMutableDictionary alloc]init];
    
    CountryArray=[[NSMutableArray alloc]init];
    langCodeArr=[[NSMutableArray alloc]init];
    
    
    
    langArr=[[NSMutableArray alloc] init];
    
    codeArr=[[NSMutableArray alloc] init];
    

    
    [self loadData];
}
-(void)loadData
{
    
    
    
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        // if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"langmode"]intValue]>0) {
        url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage?&mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults]objectForKey:@"langmode"] ];
        // }
        // else{
        //   url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage?&mode=1",GLOBALAPI,INDEX ];
        // }
        
        
        
        
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
                
                
                // [_GoButton setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                [_GoButton setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                    [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    //    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        [_loaderView setHidden:YES];
                        jsonArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        
                        
                        
                        
                        // [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in jsonArr) {
                            
                            [langArr addObject:Dict];
                            
                            if ([[Dict objectForKey:@"id"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]] && !_fromLogin) {
                                rowSelected= (int)langArr.count-1;
                                langSelected=[Dict objectForKey:@"id"];
                                [_LanguageLabel setText:AMLocalizedString([Dict objectForKey:@"name"], nil)];
                            }
                            
                            
                        }
                        
                        
                        
                        
                        if (langArr.count>0) {
                            
                               [_CountryTable reloadData];
                        }
                            else
                            {
                            
                            [_GoButton setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                       // [self getCountries];
                        
                        
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
        
        //   [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
    
    
    
    
}

-(void)getCountries
{
    
    [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
        // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        // if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"langmode"]intValue]>0) {
        url=[NSString stringWithFormat:@"%@%@Signup/getcountry?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults]objectForKey:@"langmode"] ];
        //  }
        //  else{
        //     url=[NSString stringWithFormat:@"%@%@Signup/getcountry?mode=1",GLOBALAPI,INDEX ];
        //  }
        
        
        
        
        
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
                
                
                // [_GoButton setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                [_GoButton setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                    [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                    //    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        [_loaderView setHidden:YES];
                        
                        jsonArr=[[jsonResponse objectForKey:@"countryData"] copy];
                        
                        
                        [_GoButton setUserInteractionEnabled:YES];
                        
                        
                        // [SVProgressHUD dismiss];
                        
                        
                        CountryArray=[[NSMutableArray alloc]init];
                        
                        if (!_fromLogin) {
                            NSMutableDictionary *zerodict=[[NSMutableDictionary alloc]init];
                            
                            [zerodict setObject:@"0" forKey:@"countryId"];
                            [zerodict setObject:AMLocalizedString(@"View All" , nil) forKey:@"countryName"];
                            [zerodict setObject:@"" forKey:@"image"];
                            
                            [CountryArray addObject:zerodict];
                        }
                        
                        
                        
                        for (NSDictionary *Dict in jsonArr) {
                            
                            [CountryArray addObject:Dict];
                            
                            
                            
                        }
                        
                        
                        
                        if (CountryArray.count>0) {
                            
                            
                            
                            [_CountryTable reloadData];
                            
                            
                        }
                        else{
                            
                            [_GoButton setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                        
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
        
        //   [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
    
    
    
    
}


#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [langArr count];
    
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
    if ([langSelected isEqualToString:[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"tick"];
        
        
        
    }
    else
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
    }
    
    
    //[cell.CountryImage sd_setImageWithURL:[NSURL URLWithString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
    
    [cell.CountryLabel setFont:[UIFont fontWithName:cell.CountryLabel.font.fontName size:[self getFontSize:11.0]]];
    
    
    [cell.CountryLabel setText:AMLocalizedString([[[langArr objectAtIndex:indexPath.row]objectForKey:@"name"] uppercaseString], nil) ];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  CountryCell *cCell=[_CountryTable cellForRowAtIndexPath:indexPath];
     rowSelected=(int)indexPath.row;
    
    if (![langSelected isEqualToString:[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"]])
    {
        
        langSelected=[[langArr objectAtIndex:indexPath.row]objectForKey:@"id"];

        langName=[[langArr objectAtIndex:indexPath.row] objectForKey:@"short_name"];
        
    }
    else
    {
        langSelected=@"";
        
    }
    
    
    [_CountryTable reloadData];
    
    
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
#pragma mark - Check button tapped on table
-(void)CheckButtonTap:(UIButton *)btn
{
    NSInteger tag=btn.tag;
    UIImageView *tickImage = (UIImageView* )[_CountryTable viewWithTag:tag+500];
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
#pragma mark - Go button tapped
- (IBAction)GoTapped:(id)sender {
    
    if (langSelected.length==0) {
        
        [SVProgressHUD showInfoWithStatus:@"Please select a language first"];
    }
    
//    else if (countrySelected.length==0) {
//        
//        [SVProgressHUD showInfoWithStatus:@"Please select a country first"];
//    }
    else{
        
               if (!_fromLogin) {
        
        [[NSUserDefaults standardUserDefaults ]setObject:[[langArr objectAtIndex:rowSelected]objectForKey:@"name"] forKey:@"langname"];
        [[NSUserDefaults standardUserDefaults ]setObject:langName forKey:@"language"];
        [[NSUserDefaults standardUserDefaults ]setObject:langSelected forKey:@"langId"];
        
        if (!app.isLogged) {
            LocalizationSetLanguage([[langArr objectAtIndex:rowSelected]objectForKey:@"short_name"]);
            [[NSUserDefaults standardUserDefaults]setObject:[[langArr objectAtIndex:rowSelected]objectForKey:@"short_name"] forKey:@"language"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[langArr objectAtIndex:rowSelected]objectForKey:@"id"] forKey:@"langmode"];
            
        }
               }
        
         JMChooseCountryViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMChooseCountryViewController"];
        VC.fromSplash=_fromSplash;
        VC.langSelected=langSelected;
        VC.langName=langName;
        VC.fromLogin=_fromLogin;
        VC.userDict=_userDict;
            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
        }
   
 
}
- (IBAction)languageClicked:(id)sender {
    
    
    [_pickerView setHidden:NO];
    
    [_languagePicker reloadAllComponents];
    
    
    [_languagePicker selectRow:rowSelected inComponent:0 animated:NO];
}

#pragma mark picker delegates

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return langArr.count;
    
    
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
        [pickerLabel setText:[[langArr objectAtIndex:row]objectForKey:@"name"] ];
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
    
    return [[langArr objectAtIndex:row]objectForKey:@"name"] ;
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowSelected=(int)row;
    
    
    
}
- (IBAction)selectClicked:(id)sender {
    
    [_LanguageLabel setText:[[langArr objectAtIndex:rowSelected]objectForKey:@"name"]];
    
    langSelected=[[langArr objectAtIndex:rowSelected] objectForKey:@"id"];
    langName=[[langArr objectAtIndex:rowSelected] objectForKey:@"short_name"];
    
    [_pickerView setHidden:YES];
}
- (IBAction)cancelClicked:(id)sender {
    
    [_pickerView setHidden:YES];
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
    
    langArr=[[NSMutableArray alloc] init];
    CountryArray=[[NSMutableArray alloc]init];
    
    [self loadData];
    
    
}
#pragma mark -Social Login api call
-(void)SocialLoginApi
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
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/Signup/socialSignup?register_type=%@&name=%@&email=%@&facebook_id=%@&facebook_token=%@&device_token=%@&device_type=2&mode=%@&language=%@&country=%@",GLOBALAPI,[[_userDict objectForKey:@"regtype" ] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] ,[[_userDict objectForKey:@"name" ] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[_userDict objectForKey:@"email" ] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[_userDict objectForKey:@"sid" ] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[_userDict objectForKey:@"idToken" ] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"],langSelected,countrySelected];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            //            NSString *postString=[NSString stringWithFormat:@"userimage=%@",[imageurl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            //    NSString *postString=[NSString stringWithFormat:@"userimage=%@",imageurl];
            
            //     postString=[postString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            //     postString = [postString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSString *postString1 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                          NULL,
                                                                                                          (CFStringRef)[_userDict objectForKey:@"userimage"],
                                                                                                          NULL,
                                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                          kCFStringEncodingUTF8 ));
            
            NSString *postString=[NSString stringWithFormat:@"userimage=%@",postString1];
            
            DebugLog(@"Send post Url%@",postString);
            
            
            [urlobj getSessionJsonResponse:urlString withPostData:postString typerequest:(NSString *)@"array" success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"userinfo"] valueForKey:@"id"] forKey:@"UserId"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"userinfo"] valueForKey:@"name"] forKey:@"Name"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"userinfo"] valueForKey:@"image"] forKey:@"Image"];
                         
                         DebugLog(@"image----%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Image"]]);
                         
                         app.userId=[[responseDict objectForKey:@"userinfo"] valueForKey:@"id"] ;
                         app.userName=[[responseDict objectForKey:@"userinfo"] valueForKey:@"name"] ;
                         app.userImage=[[responseDict objectForKey:@"userinfo"] valueForKey:@"image"];
                         app.isLogged=true;
                         
                         
                         [[NSUserDefaults standardUserDefaults ]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"language_name"] forKey:@"langname"];
                         
                         
                         LocalizationSetLanguage([[responseDict objectForKey:@"userinfo"]valueForKey:@"short_name"]);
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"short_name"] forKey:@"language"];
                         
                         
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"languageid"] forKey:@"langmode"];
                         
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"languageid"] forKey:@"langId"];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[[responseDict objectForKey:@"userinfo"]valueForKey:@"country"] forKey:@"userCountry"];
                         
                         
                         
                         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
                         
                         JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
                         [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
                         
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         //                         [[[UIAlertView alloc]initWithTitle:@"Error!" message:[responseDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                 }
                 else
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       [self checkLoader];
                                       self.view.userInteractionEnabled = YES;
                                       NSLog(@"Failure");
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       //                 [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                                       
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

@end
