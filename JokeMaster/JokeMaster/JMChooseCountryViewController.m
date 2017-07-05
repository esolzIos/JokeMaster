//
//  JMChooseCountryViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMChooseCountryViewController.h"
#import "JMHomeViewController.h"
@interface JMChooseCountryViewController ()
{
    NSMutableArray *langArr,*codeArr,*langCodeArr,*engArr,*hindiArr,*hebrewArr,*flagArr;
    
    NSMutableDictionary *langDict;
    
    
    int rowSelected;
  NSString *  countrySelected,*countryImage,*langSelected;
    
    int totalCount;
    NSURLSession *session;
    
    NSMutableArray *langjsonArr;

}
@end

@implementation JMChooseCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    langDict=[[NSMutableDictionary alloc]init];
    
    CountryArray=[[NSMutableArray alloc]init];
      langCodeArr=[[NSMutableArray alloc]init];
    
    
    langArr=[[NSMutableArray alloc] init];
    
    codeArr=[[NSMutableArray alloc] init];
    
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
    [_LanguageLabel setText:AMLocalizedString(@"Choose Language", nil)];
    
        [_GoButton setTitle:AMLocalizedString(@"GO",nil) forState:UIControlStateNormal] ;
    
[_languagePicker setDelegate:self];
    
    
     langSelected=[[NSUserDefaults standardUserDefaults ]objectForKey:@"langId"];
    countrySelected= [[NSUserDefaults standardUserDefaults ]objectForKey:@"countryId"];
    
    countryImage=[[NSUserDefaults standardUserDefaults ]objectForKey:@"flag"];
    
 

    
}
-(void)viewDidAppear:(BOOL)animated
{
  [self loadData];
}
-(void)loadData
{
    
    
    
    if([self networkAvailable])
    {
        
        
        
        [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage",GLOBALAPI,INDEX];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
                [_GoButton setUserInteractionEnabled:YES];
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
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        
                        langjsonArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        totalCount=(int)langjsonArr.count;
                        
                        
                        
                        [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *Dict in langjsonArr) {
                            
                            [langArr addObject:[Dict objectForKey:@"name"]];
                            [codeArr addObject:[Dict objectForKey:@"id"]];
                            [langCodeArr addObject:[Dict objectForKey:@"short_name"]];
                            [langDict setObject:[Dict objectForKey:@"countryData"] forKey:[Dict objectForKey:@"id"]];
                            
                        }
                        
                    
                        
                        if (langArr.count>0) {
                            
                            if ([codeArr containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]]) {
                                
                                rowSelected=(int)[codeArr indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
                                
                                [_LanguageLabel setText:AMLocalizedString([langArr objectAtIndex:rowSelected], nil)];
                                
                                CountryArray = [[langDict objectForKey:[codeArr objectAtIndex:rowSelected]] copy];
                                
                                [_CountryTable reloadData];
                                
                            }
                            
                        
                        }
                        else{
                            
                            [_GoButton setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    else{
                        
                        if (langArr.count==0) {
                            
                            [SVProgressHUD dismiss];
                        }
                        else{
                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    

    
    
   
    

}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [CountryArray count];

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
    if ([countrySelected isEqualToString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryId"]])
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"tick"];
        
        
        
    }
    else
    {
        
        cell.CheckImage.image = [UIImage imageNamed:@"uncheck"];
    }


      [cell.CountryImage sd_setImageWithURL:[NSURL URLWithString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"image"]]];
    
    [cell.CountryLabel setText:AMLocalizedString([[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryName"] uppercaseString], nil) ];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
  //  CountryCell *cCell=[_CountryTable cellForRowAtIndexPath:indexPath];
    
    
    if (![countrySelected isEqualToString:[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryId"]])
    {
     
          countrySelected=[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"countryId"];
        
        countryImage=[[CountryArray objectAtIndex:indexPath.row]objectForKey:@"image"];
        

    }
    else
    {
       countrySelected=@"";
       countryImage=@"";
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
    
    if (countrySelected.length>0) {
    
        [[NSUserDefaults standardUserDefaults ]setObject:countryImage forKey:@"flag"];
          [[NSUserDefaults standardUserDefaults ]setObject:countrySelected forKey:@"countryId"];
        [[NSUserDefaults standardUserDefaults ]setObject:langSelected forKey:@"langId"];
        
        LocalizationSetLanguage([langCodeArr objectAtIndex:rowSelected]);
        
        [[NSUserDefaults standardUserDefaults]setObject:[langCodeArr objectAtIndex:rowSelected] forKey:@"language"];
     
    
    JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
        
    }
    else{
        [SVProgressHUD showInfoWithStatus:@"Please select a country first"];
    }
    
//    JMLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMLogin"];
//    
//    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
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
        pickerLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:24];
        [pickerLabel setText:AMLocalizedString([langArr objectAtIndex:row], nil) ];
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
    
    return AMLocalizedString([langArr objectAtIndex:row], nil) ;
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowSelected=(int)row;
    
    
    
}
- (IBAction)selectClicked:(id)sender {
    
    [_LanguageLabel setText:AMLocalizedString([langArr objectAtIndex:rowSelected], nil)];
    
    langSelected=[codeArr objectAtIndex:rowSelected];
    
    
    
    DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);


    

    
    countrySelected=@"";
    countryImage=@"";
    
    CountryArray = [[langDict objectForKey:[codeArr objectAtIndex:rowSelected]] copy];
    
    [_CountryTable reloadData];
    
    
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
@end
