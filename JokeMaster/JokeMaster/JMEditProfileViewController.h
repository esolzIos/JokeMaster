//
//  JMEditProfileViewController.h
//  JokeMaster
//
//  Created by santanu on 26/07/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "UrlconnectionObject.h"
#import "CountryCell.h"
#import "FLAnimatedImage/FLAnimatedImage.h"
#import "FLAnimatedImage/FLAnimatedImageView.h"


@interface JMEditProfileViewController : JMGlobalMethods<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSURLConnectionDelegate>
{
    UIActionSheet *actionsheet;
    
    NSString *LanguageId,*Lang;
    UIPickerView *Langpicker;
    UIButton *btnSave,*btnCancel;
    UIView *Langview,*OverlayView,*LangBorderView;
    UIImageView *tipImage;
    UrlconnectionObject *urlobj;
    UIAlertView *AlertView;
    
    
}
@property (strong, nonatomic) IBOutlet UIView *profileImgView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainscroll;
@property (weak, nonatomic) IBOutlet UIImageView *ProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *ProfileImageLabel;
@property (weak, nonatomic) IBOutlet UITextField *Nametxt;
@property (weak, nonatomic) IBOutlet UITextField *Emailtxt;
@property (weak, nonatomic) IBOutlet UITextField *Passwordtxt;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPassword;
@property (weak, nonatomic) IBOutlet UIView *LanguageView;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
- (IBAction)SignUpTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *Logintxtvw;
@property (weak, nonatomic) IBOutlet UIButton *ProfileImageBtn;
- (IBAction)ProfileImageUploadTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *LanguageBtn;
- (IBAction)LanguageTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SignUpBtn;
@property (strong, nonatomic) IBOutlet UIButton *gobackBtn;
- (IBAction)backClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *countryView;
@property (strong, nonatomic) IBOutlet UILabel *countryLbl;
@property (strong, nonatomic) IBOutlet UIButton *countryBtn;
- (IBAction)countryClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelBttn;
- (IBAction)cancelClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *countryPopView;
@property (strong, nonatomic) IBOutlet UITableView *countryTable;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;
@property (strong, nonatomic) IBOutlet JMStrokeLabel *popTitle;



- (IBAction)countryChoosed:(id)sender;
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

@end
