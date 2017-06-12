//
//  JMChooseCountryViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMChooseCountryViewController.h"
#import "JMLoginViewController.h"
@interface JMChooseCountryViewController ()
{
    NSMutableArray *langArr,*codeArr;
    
    int rowSelected;
    

}
@end

@implementation JMChooseCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    langArr=[[NSMutableArray alloc] initWithObjects:AMLocalizedString(@"English", nil),AMLocalizedString(@"Hebrew", nil),AMLocalizedString(@"Hindi", nil), nil];
    
    codeArr=[[NSMutableArray alloc] initWithObjects:@"en",@"he",@"hi", nil];
    
    [_LanguageLabel setText:AMLocalizedString(@"Choose Language", nil)];
    
        [_GoButton setTitle:AMLocalizedString(@"GO",nil) forState:UIControlStateNormal] ;
    
[_languagePicker setDelegate:self];
    
}
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
   // return [CountryArray count];
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        NSString *identifier = @"CountryCell";
        
        CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.CheckImage.tag=indexPath.row+500;
        cell.CheckButton.tag=indexPath.row;
        [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
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
    JMLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMLogin"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}
- (IBAction)languageClicked:(id)sender {
    
    
    [_pickerView setHidden:NO];
    
    [_languagePicker reloadAllComponents];
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
- (IBAction)selectClicked:(id)sender {
    
    [_LanguageLabel setText:[langArr objectAtIndex:rowSelected]];
    
    DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);
//
//    LocalizationSetLanguage([codeArr objectAtIndex:rowSelected]);
    
    [[NSUserDefaults standardUserDefaults]setObject:[codeArr objectAtIndex:rowSelected] forKey:@"language"];
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
