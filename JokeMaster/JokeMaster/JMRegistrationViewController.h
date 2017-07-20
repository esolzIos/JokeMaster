//
//  JMRegistrationViewController.h
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"
#import "UrlconnectionObject.h"
@interface JMRegistrationViewController : JMGlobalMethods<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSURLConnectionDelegate>
{
    UIActionSheet *actionsheet;
    NSMutableArray *LangaugeArray;
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

@end
