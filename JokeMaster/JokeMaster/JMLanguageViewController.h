//
//  JMLanguageViewController.h
//  JokeMaster
//
//  Created by santanu on 05/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "FLAnimatedImage/FLAnimatedImage.h"
#import "FLAnimatedImage/FLAnimatedImageView.h"
@interface JMLanguageViewController : JMGlobalMethods<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
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
@property(nonatomic) NSMutableDictionary *userDict;
@property (nonatomic)BOOL fromLogin;
@property (strong, nonatomic) IBOutlet UIView *loaderView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;
@property (strong, nonatomic) IBOutlet UILabel *countryTitle;
@end
