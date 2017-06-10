//
//  JMChooseCountryViewController.h
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "CountryCell.h"
@interface JMChooseCountryViewController : JMGlobalMethods<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate>
{
   
    NSMutableArray *CountryArray;
}
@property (weak, nonatomic) IBOutlet UITableView *CountryTable;
@property (weak, nonatomic) IBOutlet UIView *LanguageView;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
@property (weak, nonatomic) IBOutlet UIButton *GoButton;
- (IBAction)GoTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *languageBtn;
- (IBAction)languageClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBttn;
- (IBAction)cancelClicked:(id)sender;

@end
