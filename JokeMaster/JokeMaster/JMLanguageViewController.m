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
    NSMutableArray *langArr,*codeArr;
    
    int rowSelected;
    
    BOOL selected;
    
}
@end

@implementation JMLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     langArr=[[NSMutableArray alloc] initWithObjects:@"English",@"Hebrew",@"Hindi",@"Chinese",@"Spanish", nil];
    
    codeArr=[[NSMutableArray alloc] initWithObjects:@"en",@"he",@"hi",@"zh",@"es", nil];
    
    
    [_languageLbl setFont:[UIFont fontWithName:_languageLbl.font.fontName size:[self getFontSize:_languageLbl.font.pointSize]]];
    [_chooseBtn.titleLabel setFont:[UIFont fontWithName:_chooseBtn.titleLabel.font.fontName size:[self getFontSize:_chooseBtn.titleLabel.font.pointSize]]];
    
    [_languagePicker setDelegate:self];
    

    // Do any additional setup after loading the view.
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
    
         LocalizationSetLanguage([codeArr objectAtIndex:rowSelected]);
    
     [[NSUserDefaults standardUserDefaults]setObject:[codeArr objectAtIndex:rowSelected] forKey:@"language"];
    
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
@end
