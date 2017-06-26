//
//  JMGlobalMethods.h
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//


#import "JMGlobalHeader.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "LocalizationSystem.h"
#import "JMHeaderView.h"
#import "JMLeftMenuView.h"
#import "JMSearchView.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface JMGlobalMethods : UIViewController<Side_menu_delegate>
{
    UIView *loader_shadow_View;
    JMLeftMenuView *leftmenu;
    UITapGestureRecognizer *tapRecognizer;
    NSInteger leftmenurowindex;
}

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectCon;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSOperationQueue *myQueue ;
-(BOOL )textFieldBlankorNot:(NSString *)str;
-(void)txtPadding:(UITextField *)text;
@property (nonatomic,retain) UIView *footerLoadView,*footerReloadView;
- (void) resetCoreData;
-(BOOL)validateEmailWithString:(NSString*)email;
-(void)PushViewController:(UIViewController *)viewController WithAnimation:(NSString *)AnimationType;
-(void)POPViewController;
-(void)checkLoader;
-(void)checkLoaderwithProgress:(float)progress;
- (NSString *)extractYoutubeIdFromLink:(NSString *)link;
-(void)showLoaderwithProgress:(float)progress;
-(void)logOut;
- (NSString *)encodeToBase64String:(UIImage *)image;
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
-(void)initFooterView;
-(void)setRoundCornertoView:(UIView *)viewname withBorderColor:(UIColor *)color WithRadius:(CGFloat)radius;
-(void)setBorderToView:(UIView *)viewName withColor:(UIColor *)color withBorderWidth:(CGFloat)width;
- (CGSize)sizeOfTextView:(UITextView *)textView withText:(NSString *)text;
- (CGSize)sizeOfLabelwithFont:(UIFont *)font withText:(NSString *)text;
-(BOOL)networkAvailable;
-(void)showAlertwithTitle:(NSString *)title withMessage:(NSString *)message withAlertType:(UIAlertControllerStyle)alertStyle withOk:(BOOL)isOk withCancel:(bool)isCancel;
- (NSString*)base64forData:(NSData*)theData;
-(UIImage *)compressImage:(UIImage *)image;
- (NSString *)getIPAddress;
-(CGFloat)getFontSize:(CGFloat)size;
-(void)addHeader:(UIView *)mainView;
-(void)addFooter:(UIView *)mainView;
-(void)addRefreshView:(UIView *)mainView;
-(void)addPushView:(UIView *)mainView;

-(void)addSearchBar:(UIView *)mainView;
- (BOOL) checkforNumeric:(NSString*) numericstr;
@property(nonatomic,weak) UILabel *headerLbl,*doneLbl,*cancelLbl,*saveLbl,*nodataLbl,*editLbl,*pushTitle,*pushDesc,*badgeLbl;
@property(nonatomic,weak) UIButton *profileBtn,*notifyBtn,*chatBtn,*homeBtn,*eventBtn,*locationBtn,*trophyBtn,*searchBtn,*backBtn,*doneBtn,*cancelBtn,*moreBtn,*saveBtn,*writeBtn,*refreshBtn,*editBtn,*userBttn,*pushBtn,*trashBtn;
@property(nonatomic,weak) UIImageView *profileImg,*notifyImg,*chatImg,*favImage,*homeImg,*eventImg,*locationImg,*trophyImg,*searchImg,*backImg,*moreImg,*writeImg,*userImg,*trashImg,*refreshImg;
@property(nonatomic,weak) UIView *profileView,*notifyView,*chatView,*homeView,*eventView,*locationview,*trophyView,*searchView,*backView,*cancelview,*doneView,*moreView,*saveView,*writeView,*refreshInnerView,*editview,*userView,*pushInnerView,*trashView;

@property(nonatomic,weak)UISearchBar *searchBar;
-(void)shakeAnimation:(UILabel*) label;
-(NSString*)getPressedWordWithRecognizer:(UIGestureRecognizer*)recognizer;
-(NSString *)formatDatetime:(NSString *)date;
- (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius;
@property(nonatomic,weak) UITabBar *footerTabBar;
-(void)checkPushCount;
-(void)readAfterPush;
 @property (strong, nonatomic) UIView *filterView;
@property (weak, nonatomic) IBOutlet UIView *MainView;
@property (weak, nonatomic) IBOutlet JMHeaderView *HeaderView;
@property (strong, nonatomic) IBOutlet JMSearchView *searchHeaderView;
-(void)addMoreView:(UIView *)mainView;

@end
