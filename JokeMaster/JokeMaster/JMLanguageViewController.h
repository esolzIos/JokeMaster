//
//  JMLanguageViewController.h
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"

@interface JMLanguageViewController : JMGlobalMethods
@property (strong, nonatomic) IBOutlet UIView *languageView;
@property (strong, nonatomic) IBOutlet UILabel *languageLbl;
@property (strong, nonatomic) IBOutlet UIButton *chooseBtn;
- (IBAction)chooseClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *goView;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;
- (IBAction)goClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBttn;
- (IBAction)cancelClicked:(id)sender;

@end
