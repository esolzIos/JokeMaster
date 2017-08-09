//
//  JMEditVideoViewController.h
//  JokeMaster
//
//  Created by santanu on 02/08/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"

@interface JMEditVideoViewController : JMGlobalMethods
{
    NSURLSession *session;
    
    NSMutableArray *langjsonArr;
    int totalCount;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;

@property (strong, nonatomic) IBOutlet UIView *tvView;

@property (strong, nonatomic) IBOutlet UIImageView *tvFrame;
@property (strong, nonatomic) IBOutlet UIButton *uploadBtn;
- (IBAction)uploadClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *videoThumb;
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBttn;
- (IBAction)cancelClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *languageView;
@property (strong, nonatomic) IBOutlet UILabel *jokeLang;
@property (strong, nonatomic) IBOutlet UIButton *langBtn;
- (IBAction)langClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *categoryView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLbl;
@property (strong, nonatomic) IBOutlet UIButton *categoryBtn;
- (IBAction)categoryClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *tapInfo;

@property (strong, nonatomic) IBOutlet UITextField *videoName;

@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UILabel *infoLbl;

@property (strong, nonatomic) IBOutlet UIView *loaderView;
@property (strong, nonatomic) IBOutlet UIView *loadertvView;
@property (strong, nonatomic) IBOutlet UIImageView *loaderImage;
@property (strong, nonatomic) IBOutlet UIButton *loaderBtn;
- (IBAction)loaderClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *noVideoView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *gifImage;
@property (strong, nonatomic) IBOutlet UILabel *noVideoLbl;

@property (strong, nonatomic) IBOutlet UIView *goBackView;
@property (strong, nonatomic) IBOutlet UIButton *goBackbtn;
- (IBAction)goBackClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *PopView;
@property (strong, nonatomic) IBOutlet JMStrokeLabel *popTitle;
@property (strong, nonatomic) IBOutlet UITableView *popTable;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;
- (IBAction)popChoosed:(id)sender;

@property (nonatomic)NSMutableDictionary *videoDict;

@end
