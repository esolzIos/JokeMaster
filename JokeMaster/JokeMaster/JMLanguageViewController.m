//
//  JMLanguageViewController.m
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMLanguageViewController.h"
#import "JMChooseCountryViewController.h"
@interface JMLanguageViewController ()<UIPickerViewDelegate>
{
    NSMutableArray *langArr,*codeArr,*langCodeArr;
    
    int rowSelected;
    
    BOOL selected;
    
    int totalCount;
    NSURLSession *session;
    
    NSMutableArray *langjsonArr;
    
}
@end

@implementation JMLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    langArr=[[NSMutableArray alloc] init];
   
   codeArr=[[NSMutableArray alloc] init];
          langCodeArr=[[NSMutableArray alloc]init];
    
    [_languageLbl setFont:[UIFont fontWithName:_languageLbl.font.fontName size:[self getFontSize:_languageLbl.font.pointSize]]];
    [_chooseBtn.titleLabel setFont:[UIFont fontWithName:_chooseBtn.titleLabel.font.fontName size:[self getFontSize:_chooseBtn.titleLabel.font.pointSize]]];
    
    [_languagePicker setDelegate:self];
    
    [self loadData];
    

    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageData = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
      [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
        [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];

        [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    // Do any additional setup after loading the view.
}
-(void)loadData
{

    
     [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
       
        
        //[SVProgressHUD show];
        
        
        
        NSString *url;
        
 
            url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage",GLOBALAPI,INDEX];
     
        
        
        NSLog(@"Url String..%@",url);
        
        // configure the request
        

        
        
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
                    [_noVideoLbl setText:@"Some error occured.\n\n Click to retry"];
                    [_loaderBtn setHidden:NO];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
           
                            
                            langjsonArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        totalCount=(int)langjsonArr.count;
                        
                            
                            
                         //   [SVProgressHUD dismiss];
         
                        [_loaderView setHidden:YES];
                    
                            
                            for (NSDictionary *langDict in langjsonArr) {
                                
                                [langArr addObject:[langDict objectForKey:@"name"]];
                                      [codeArr addObject:[langDict objectForKey:@"id"]];
                                      [langCodeArr addObject:[langDict objectForKey:@"short_name"]];
                            }
                            
                            if (langArr.count>0) {
                                [_languagePicker reloadAllComponents];
                            }
                            else{
                        
//                                [_chooseBtn setUserInteractionEnabled:NO];
                                
                                [_gifImage setHidden:YES];
                                [_noVideoView setHidden:NO];
                                [_noVideoLbl setText:@"No language Found.\n\n Click to retry"];
                                [_loaderBtn setHidden:NO];
                            }
                            
                            
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
                            [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n Click to retry",[jsonResponse objectForKey:@"message"]]];
                            [_loaderBtn setHidden:NO];
                            
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

- (IBAction)chooseClicked:(id)sender {
    

    [_pickerView setHidden:NO];
    
    [_languagePicker reloadAllComponents];
    
    
    
}
- (IBAction)goClicked:(id)sender {
    
    
    
    if (selected) {
        
        LocalizationSetLanguage([langCodeArr objectAtIndex:rowSelected]);
        
        [[NSUserDefaults standardUserDefaults]setObject:[langCodeArr objectAtIndex:rowSelected] forKey:@"language"];
        
        [[NSUserDefaults standardUserDefaults ]setObject:[codeArr objectAtIndex:rowSelected] forKey:@"langId"];

        
        JMChooseCountryViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMChooseCountryViewController"];
        
        [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    }
    else{
        [SVProgressHUD showInfoWithStatus:@"Please Choose a language first"];
    }

}
- (IBAction)selectClicked:(id)sender {
    
    selected=true;
    
    [_languageLbl setText:[langArr objectAtIndex:rowSelected]];
    
    DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);
    
    
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
        [pickerLabel setText:[langArr objectAtIndex:row]];
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

    return [langArr objectAtIndex:row];
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowSelected=(int)row;
    
    
    
}
- (IBAction)loaderClicked:(id)sender {
    
    
    [_gifImage setHidden:NO];
    [_noVideoView setHidden:YES];
    [_noVideoLbl setText:@""];
    [_loaderBtn setHidden:YES];
    
    langArr=[[NSMutableArray alloc] init];
    
    codeArr=[[NSMutableArray alloc] init];
    langCodeArr=[[NSMutableArray alloc]init];
    
   [self loadData];

    
}
@end
