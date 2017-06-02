//
//  JMChooseCountryViewController.h
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "CountryCell.h"
@interface JMChooseCountryViewController : JMGlobalMethods<UITableViewDataSource,UITableViewDelegate>
{
   
    NSMutableArray *CountryArray;
}
@property (weak, nonatomic) IBOutlet UITableView *CountryTable;
@property (weak, nonatomic) IBOutlet UIView *LanguageView;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
@property (weak, nonatomic) IBOutlet UIButton *GoButton;
- (IBAction)GoTapped:(id)sender;

@end
