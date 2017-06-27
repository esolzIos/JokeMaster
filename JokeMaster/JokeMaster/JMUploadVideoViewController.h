//
//  JMUploadVideoViewController.h
//  JokeMaster
//
//  Created by priyanka on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMGlobalMethods.h"

@interface JMUploadVideoViewController : JMGlobalMethods
{
    NSURLSession *session;
    
    NSMutableArray *langjsonArr;
    int totalCount;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
- (IBAction)Test:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *tvView;
@property (strong, nonatomic) IBOutlet UIView *optionView;
@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (strong, nonatomic) IBOutlet UIView *galleryView;
@property (strong, nonatomic) IBOutlet UIImageView *tvFrame;
@property (strong, nonatomic) IBOutlet UIButton *uploadBtn;
- (IBAction)uploadClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cameraBtn;
- (IBAction)cameraClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *galleryBtn;
- (IBAction)galleryClicked:(id)sender;
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
@property (strong, nonatomic) IBOutlet UILabel *warningLbl;

@property (strong, nonatomic) IBOutlet UIView *warningView;
@property (strong, nonatomic) IBOutlet UIView *transView;
@property (strong, nonatomic) IBOutlet UIView *popupView;
@property (strong, nonatomic) IBOutlet UILabel *okLbl;
@property (strong, nonatomic) IBOutlet UILabel *cancelLabl;
@property (strong, nonatomic) IBOutlet UIButton *warncancelBtn;
- (IBAction)warnCancelled:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *warnOkBtn;
- (IBAction)warnOkClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *crossBtn;
- (IBAction)crossClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tapInfo;
@property (strong, nonatomic) IBOutlet UILabel *cameraLbl;
@property (strong, nonatomic) IBOutlet UILabel *galleryLbl;
@property (strong, nonatomic) IBOutlet UITextField *videoName;

@end
