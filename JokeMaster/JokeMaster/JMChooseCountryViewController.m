//
//  JMChooseCountryViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMChooseCountryViewController.h"

@interface JMChooseCountryViewController ()

@end

@implementation JMChooseCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
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
}
@end
