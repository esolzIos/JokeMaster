//
//  JMRegistrationViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMRegistrationViewController.h"
#import "JMHomeViewController.h"
#import "DZNPhotoEditorViewController.h"
#import "UIImagePickerController+Edit.h"
@interface JMRegistrationViewController ()
{
    AppDelegate *app;
    
}
@end

@implementation JMRegistrationViewController
@synthesize Nametxt,Emailtxt,Passwordtxt,ProfileImage,ProfileImageLabel,ConfirmPassword,mainscroll,Logintxtvw,LanguageView,LanguageLabel,LanguageBtn,SignUpBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // sign in text view design
      app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *titleText=AMLocalizedString(@"Back to Log in", nil);
    
    [_gobackBtn setTitle:titleText forState:UIControlStateNormal];
    
    //  set the different range
    
    NSRange range1 = [_gobackBtn.titleLabel.text rangeOfString:AMLocalizedString(@"Log in", nil) ];
    
    
    // to set alignment
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.alignment = NSTextAlignmentCenter;
    
    UIFont *font1 = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:13.0f]];
    UIFont *font2 = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:16.0f]];
    //    set the attributes to different ranges
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:_gobackBtn.titleLabel.text];
    
    [attributedText setAttributes: @{NSFontAttributeName :font1,
                                     
                                     NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph} range:NSMakeRange(0,_gobackBtn.titleLabel.text.length)];
    
    [attributedText addAttributes:@{NSFontAttributeName :font2, NSForegroundColorAttributeName : [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph} range:range1];
    
    
    [_gobackBtn setAttributedTitle:attributedText forState:UIControlStateNormal];

    
    
    
//    UIFont *font1 = [UIFont fontWithName:@"ComicSansMS-Bold" size:15];
//    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
//    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:AMLocalizedString(@"Back to",nil) attributes: arialDict];
//    [aAttrString1 addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor whiteColor]
//                         range:NSMakeRange(0, [aAttrString1 length])];
//    
//    UIFont *font2 = [UIFont fontWithName:@"ComicSansMS-Bold" size:20];
//    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject:font2 forKey:NSFontAttributeName];
//    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",AMLocalizedString(@"Log in",nil)] attributes: arialDict2];
//    [aAttrString2 addAttribute:NSForegroundColorAttributeName
//                         value:[UIColor whiteColor]
//                         range:NSMakeRange(0, [aAttrString2 length])];
//    
//    [aAttrString1 appendAttributedString:aAttrString2];
//    Logintxtvw.attributedText = aAttrString1;
//    Logintxtvw.textAlignment = NSTextAlignmentCenter;
//    
//    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTextView:)];
//    [Logintxtvw addGestureRecognizer:tapRecognizer1];
    
    
    // place holder design
    Emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    Nametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Name",nil) attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    Passwordtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Password",nil)attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    ConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Confirm Password",nil) attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    ProfileImageLabel.frame=CGRectMake(ProfileImageLabel.frame.origin.x, ProfileImage.frame.origin.y+ProfileImage.frame.size.height/2-ProfileImageLabel.frame.size.height/2, ProfileImageLabel.frame.size.width, ProfileImageLabel.frame.size.height);
    
    LangaugeArray=[[NSMutableArray alloc] initWithObjects:AMLocalizedString(@"English",nil),AMLocalizedString(@"Hebrew",nil),AMLocalizedString(@"Hindi",nil), nil];
    
    ProfileImageLabel.text= AMLocalizedString(@"Upload Profile Picture",nil);
    LanguageLabel.text=AMLocalizedString(@"Language",nil);
    [SignUpBtn setTitle:AMLocalizedString(@"SIGN UP",nil) forState:UIControlStateNormal];
    
    urlobj=[[UrlconnectionObject alloc] init];
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
#pragma mark - Sign up tap
- (IBAction)SignUpTapped:(id)sender
{
    
    
    [UIView animateWithDuration:0.0f animations:^{
        [Nametxt resignFirstResponder];
        [Emailtxt resignFirstResponder];
        [Passwordtxt resignFirstResponder];
        [ConfirmPassword resignFirstResponder];
        
        
        
    } completion:^(BOOL finished) {
        
        [mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        
        if([self textFieldBlankorNot:Nametxt.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//
//                                          message:AMLocalizedString(@"Enter Name", nil)
//
//
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Name", nil)];
            
            
        }
        else if ([self textFieldBlankorNot:Emailtxt.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Email Address",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
               [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Email Address",nil)];
        }
        else if ([self validateEmailWithString:Emailtxt.text]==NO)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Valid Email Address",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
              [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Valid Email Address",nil)];
        }
        else if ([LanguageLabel.text isEqualToString:AMLocalizedString(@"Language",nil)])
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Select Language",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
            
                         [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Select Language",nil)];
        }
        else if ([self textFieldBlankorNot:Passwordtxt.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Password", nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
                          [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Password", nil)];
        }
        else if (Passwordtxt.text.length<6)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Password Should be at least 6 characters",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
                      [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Password Should be at least 6 characters",nil)];
        }
        else if ([self textFieldBlankorNot:ConfirmPassword.text]==YES)
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Enter Confirm Password",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
               [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Enter Confirm Password",nil)];
        }
        else if (![Passwordtxt.text isEqualToString:ConfirmPassword.text])
        {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:AMLocalizedString(@"Alert",nil)
//                                          message:AMLocalizedString(@"Password and confirm password should be same.",nil)
//                                          preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:AMLocalizedString(@"OK",nil)
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [alert dismissViewControllerAnimated:YES completion:nil];
//                                     
//                                     
//                                     
//                                     
//                                 }];
//            
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:nil];
            
               [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Password and confirm password should be same.",nil)];
        }
        else
        {
            
           // [self SignUpApi];
            [self SignUpAPI1];
            
        }
    
    }];

}
#pragma mark - Sign in text view tapped
- (void)tappedTextView:(UITapGestureRecognizer *)tapGesture
{
    
    if (tapGesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    NSString *pressedWord = [self getPressedWordWithRecognizer:tapGesture];
    
    
    if ([pressedWord isEqualToString:@"Log"] || [pressedWord isEqualToString:@"in"] || [pressedWord isEqualToString:AMLocalizedString(@"Log in",nil)])
    {
        
      //  DebugLog(@" sign in");
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
}
#pragma mark - textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    [textField becomeFirstResponder];
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         if (IsIphone4)
                         {
                             if (textField==Passwordtxt)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==ConfirmPassword)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
                             }
                             
                             
                         }
                         else if (IsIphone5)
                         {
                             if (textField==Passwordtxt)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,80.0f) animated:YES];
                             }
                             else if (textField==ConfirmPassword)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,150.0f) animated:YES];
                             }
                             
                         }
                         else
                         {
                             if (textField==Passwordtxt)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,60.0f) animated:YES];
                             }
                             else if (textField==ConfirmPassword)
                             {
                                 [mainscroll setContentOffset:CGPointMake(0.0f,130.0f) animated:YES];
                             }
                             
                         }
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4f
     
                     animations:^{
                         
                         [textField resignFirstResponder];
                         [mainscroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
    return YES;
}
#pragma mark - upload profile image
- (IBAction)ProfileImageUploadTapped:(id)sender
{
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:AMLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:AMLocalizedString(@"Camera",nil),AMLocalizedString(@"Photo Library",nil), nil];
    [actionsheet showInView:self.view];
}
#pragma mark - status bar white color
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
     picker.allowsEditing=YES;
    
       picker.cropMode=DZNPhotoEditorViewControllerCropModeSquare;
    
    //  PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (buttonIndex) {
            
        case 0:
            
            
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                [self openCamera];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:AMLocalizedString(@"OK",nil) otherButtonTitles:nil];
                [alert show];
            }
            break;
            
        case 1:
            
            
            picker.allowsEditing = NO;
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            //   picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            [self presentViewController:picker animated:YES completion:^{
                
                
            }];
            
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark - image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
//    imgData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage],0.9895);
//    DebugLog(@"Size of Image(bytes):%lu",(unsigned long)[imgData length]);
    
    
 //   AttachImage=info[UIImagePickerControllerOriginalImage];
    ProfileImage.image=info[UIImagePickerControllerEditedImage];
    
    ProfileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    ProfileImage.layer.cornerRadius=ProfileImage.frame.size.height/2;
    
    ProfileImage.clipsToBounds=YES;
    
 //   [ProfileImage setUserInteractionEnabled:YES];
    
    
    
    //  AttachmentImage.image=[self compressImage:AttachmentImage.image];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
       
        
    }];
    
  
    
}
#pragma mark - open camera
-(void)openCamera
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
    
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.navigationController presentViewController:picker animated:YES completion:NULL];
    
    
    
}
#pragma mark - Language btn tapped
- (IBAction)LanguageTapped:(id)sender
{
    [Nametxt resignFirstResponder];
    [Emailtxt resignFirstResponder];
    [Passwordtxt resignFirstResponder];
    [ConfirmPassword resignFirstResponder];
    
    
    if (LanguageBtn.selected==NO)
    {
        if (LangaugeArray.count>0)
        {
            [OverlayView removeFromSuperview];
            
            OverlayView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width,self.navigationController.visibleViewController.view.frame.size.height)];
            OverlayView.backgroundColor = [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.6f];
            [self.navigationController.visibleViewController.view addSubview:OverlayView];
            
            if (IsIphone4)
            {
                
                
                Langview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+10,OverlayView.frame.size.height-230, self.view.frame.size.width-20,220)];
                
                Langpicker=[[UIPickerView alloc] initWithFrame:CGRectMake(0,30, Langview.frame.size.width,190)];
                
                
            }
            else
            {
                
                
                Langview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+10, OverlayView.frame.size.height-330, self.view.frame.size.width-20,320)];
                
                Langpicker=[[UIPickerView alloc] initWithFrame:CGRectMake(0,30, Langview.frame.size.width,290)];
            }
            
            
            
            Langpicker.layer.cornerRadius = 5.0f;
            Langpicker.clipsToBounds = YES;
            
            Langview.layer.cornerRadius = 5.0f;
            Langview.layer.borderWidth = 2.0f;
            Langview.layer.borderColor = [UIColorFromRGB(0xFF8200) CGColor];
            
            Langview.backgroundColor=[UIColor whiteColor];
            [OverlayView addSubview:Langview];
            
            
            tipImage = [[UIImageView alloc] initWithFrame:CGRectMake(Langview.frame.origin.x+(Langview.frame.size.width-[UIImage imageNamed:@"downarrow"].size.width)/2, Langview.frame.origin.y+Langview.frame.size.height, [UIImage imageNamed:@"downarrow"].size.width, [UIImage imageNamed:@"downarrow"].size.height)];
            tipImage.image = [UIImage imageNamed:@"downarrow"];
            [OverlayView addSubview:tipImage];
            
            
            LangBorderView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, Langview.frame.size.width,30)];
            LangBorderView.layer.cornerRadius = 5.0f;
            LangBorderView.backgroundColor=UIColorFromRGB(0xFF8200);
            LangBorderView.clipsToBounds = YES;
            [Langview addSubview:LangBorderView];
            
            
            Langpicker.delegate=self;
            Langpicker.dataSource=self;
            [Langpicker setBackgroundColor:[UIColor whiteColor]];
            
            if (![LanguageLabel.text isEqualToString:AMLocalizedString(@"Language",nil)])
            {
                for (int i=0; i<[LangaugeArray count]; i++)
                {
                    
                    
                    
                    if ([LanguageLabel.text isEqualToString:[LangaugeArray objectAtIndex:i]])
                    {
                        [Langpicker selectRow:i inComponent:0 animated:YES];
                        Lang=[LangaugeArray objectAtIndex:i];
                        
                        break;
                    }
//                    if ([CategoryId isEqualToString:[[CategoryArray objectAtIndex:i] valueForKey:@"parent_category"]])
//                    {
//                        [Catpicker selectRow:i inComponent:0 animated:YES];
//
//                        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] length]==0)
//                        {
//                            Cat=[[CategoryArray objectAtIndex:i] valueForKey:@"title_eng"];
//                        }
//                        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] isEqualToString:@"ar"])
//                        {
//                            Cat=[[CategoryArray objectAtIndex:i] valueForKey:@"title_arb"];
//                        }
//                        else
//                        {
//                            Cat=[[CategoryArray objectAtIndex:i] valueForKey:@"title_eng"];
//                        }
//                        
//                        break;
//                    }
                }
            }
            
            
            [Langview addSubview:Langpicker];
            
            
            
            btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
            btnSave.frame = CGRectMake(Langpicker.frame.origin.x+Langpicker.frame.size.width-50,0, 50, 30);
            [btnSave setTitle:AMLocalizedString(@"Save",nil) forState:UIControlStateNormal];
            
            
            [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
            btnSave.titleLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:15.0];
            [btnSave addTarget:self action:@selector(CategoryChange) forControlEvents:UIControlEventTouchUpInside];
            [LangBorderView addSubview:btnSave];
            [LangBorderView bringSubviewToFront:btnSave];
            
            btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
            btnCancel.frame = CGRectMake(Langpicker.frame.origin.x,0, 70, 30);
            
           [btnCancel setTitle:AMLocalizedString(@"Cancel",nil) forState:UIControlStateNormal];
            [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
            btnCancel.titleLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:15.0];
            [btnCancel addTarget:self action:@selector(CategoryCancel) forControlEvents:UIControlEventTouchUpInside];
            [LangBorderView addSubview:btnCancel];
            [LangBorderView bringSubviewToFront:btnCancel];
            
            
            
            
            LanguageBtn.selected=YES;
        }
        
        
    }
    else
    {
        [UIView animateWithDuration:0.4f
         
                         animations:^{
                             
                             LanguageBtn.selected=NO;
                             [Langview removeFromSuperview];
                             [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
                             
                         }
                         completion:^(BOOL finished)
         {
         }
         ];
        
    }
}
#pragma mark -  title picker cancel
-(void)CategoryCancel
{
    [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
    LanguageBtn.selected=NO;
    
    [OverlayView removeFromSuperview];
    [tipImage removeFromSuperview];
    [Langview removeFromSuperview];
    
}
#pragma mark -  title picker title save
-(void)CategoryChange
{
    
    LanguageBtn.selected=NO;
    
    if (Lang.length==0)
    {
        LanguageLabel.text=[LangaugeArray objectAtIndex:0];
        
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] length]==0)
//        {
//            lblCategory.text=[[CategoryArray objectAtIndex:0] valueForKey:@"title_eng"];
//        }
//        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] isEqualToString:@"ar"])
//        {
//            lblCategory.text=[[CategoryArray objectAtIndex:0] valueForKey:@"title_arb"];
//        }
//        else
//        {
//            lblCategory.text=[[CategoryArray objectAtIndex:0] valueForKey:@"title_eng"];
//        }
//        
//        
//        CategoryId=[[CategoryArray objectAtIndex:0] valueForKey:@"parent_category"];
    }
    else
    {
        LanguageLabel.text=Lang;
    }
    Lang=@"";
    
    [OverlayView removeFromSuperview];
    [tipImage removeFromSuperview];
    [Langview removeFromSuperview];
    [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
    
}
#pragma mark -  picker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==Langpicker)
    {
        return LangaugeArray.count;
    }
    
    else
    {
        return 0;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==Langpicker)
    {
         return [LangaugeArray objectAtIndex:row];
        
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] length]==0)
//        {
//            return [[CategoryArray objectAtIndex:row] valueForKey:@"title_eng"];
//        }
//        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] isEqualToString:@"ar"])
//        {
//            return [[CategoryArray objectAtIndex:row] valueForKey:@"title_arb"];
//        }
//        else
//        {
//            return [[CategoryArray objectAtIndex:row] valueForKey:@"title_eng"];
//        }
        
    }
    
    else
    {
        return @"";
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView==Langpicker)
    {
        
        Lang = [LangaugeArray objectAtIndex:row];
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] length]==0)
//        {
//            Cat= [[CategoryArray objectAtIndex:row] valueForKey:@"title_eng"];
//        }
//        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] isEqualToString:@"ar"])
//        {
//            Cat= [[CategoryArray objectAtIndex:row] valueForKey:@"title_arb"];
//        }
//        else
//        {
//            Cat= [[CategoryArray objectAtIndex:row] valueForKey:@"title_eng"];
//        }
//        
//        
//        CategoryId=[[CategoryArray objectAtIndex:row] valueForKey:@"parent_category"];
        
    }
    
    else
    {
        
    }
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
             attributedTitleForRow:(NSInteger)row
                      forComponent:(NSInteger)component
{
    
    return [[NSAttributedString alloc] initWithString:[LangaugeArray objectAtIndex:row]
                                           attributes:@
            {
            NSForegroundColorAttributeName:UIColorFromRGB(0xFF8200)
            }];
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] length]==0)
//    {
//        return [[NSAttributedString alloc] initWithString:[[CategoryArray objectAtIndex:row] valueForKey:@"title_eng"]
//                                               attributes:@
//                {
//                NSForegroundColorAttributeName:UIColorFromRGB(0x4799EF)
//                }];
//        
//    }
//    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"language"] isEqualToString:@"ar"])
//    {
//        return [[NSAttributedString alloc] initWithString:[[CategoryArray objectAtIndex:row] valueForKey:@"title_arb"]
//                                               attributes:@
//                {
//                NSForegroundColorAttributeName:UIColorFromRGB(0x4799EF)
//                }];
//        
//    }
//    else
//    {
//        return [[NSAttributedString alloc] initWithString:[[CategoryArray objectAtIndex:row] valueForKey:@"title_eng"]
//                                               attributes:@
//                {
//                NSForegroundColorAttributeName:UIColorFromRGB(0x4799EF)
//                }];
//        
//    }
    
}
#pragma mark - Back Button Click
- (IBAction)backClicked:(id)sender {
    
        [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -signup api call
-(void)SignUpAPI1
{
    NSString *urlString = [NSMutableString stringWithFormat:@"%@index.php/Signup?register_type=1&name=%@&email=%@&password=%@&language=%@&device_token=%@&device_type=2&mode=%@",GLOBALAPI,[Nametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Emailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Passwordtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[LanguageLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
    
        urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *strEncoded;
    
    UIImage *secondImage = [UIImage imageNamed:@"no-image"];
    
    NSData *imgData = UIImagePNGRepresentation(ProfileImage.image);
    NSData *imgData1 = UIImagePNGRepresentation(secondImage);
    
    BOOL isCompare =  [imgData1 isEqual:imgData];
    if (!isCompare)
    {
        //             AttachmentImage.image=[self compressImage:AttachmentImage.image];
        //
        //            imgData = UIImageJPEGRepresentation(AttachmentImage.image, 1.0);
        //  DebugLog(@"Size of Image(bytes):%lu",(unsigned long)[imgData length]);
        
        
        strEncoded = [self encodeToBase64String:ProfileImage.image];
       
    }
    else
    {
        strEncoded =@"";
    }
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        
    self.view.userInteractionEnabled = NO;
    [self checkLoader];
    [urlobj globalImage:urlString ImageString:strEncoded ImageField:@"userimage" typerequest:@"array" withblock:^(id result, NSError *error,BOOL completed)
    {
        NSLog(@"event result----- %@", result);
        DebugLog(@" Status Code:%ld",urlobj.statusCode);
        
        self.view.userInteractionEnabled = YES;
        [self checkLoader];
        
        if (urlobj.statusCode==200)
        {
            if ([[result objectForKey:@"status"] boolValue]==YES)
            {
                
                [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Registration successful.",nil)];
//                AlertView = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                       message:@"Registration successful."
//                                                      delegate:self
//                                             cancelButtonTitle:nil
//                                             otherButtonTitles:nil];
//                
//                [AlertView show];
                
                [[NSUserDefaults standardUserDefaults] setObject:[[result objectForKey:@"Details"] valueForKey:@"user_id"] forKey:@"UserId"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result objectForKey:@"Details"] valueForKey:@"name"] forKey:@"Name"];
                [[NSUserDefaults standardUserDefaults] setObject:[[result objectForKey:@"Details"] valueForKey:@"image"] forKey:@"Image"];
                
                app.userId=[[result objectForKey:@"Details"] valueForKey:@"user_id"];
                app.userName=[[result objectForKey:@"Details"] valueForKey:@"name"];
                app.userImage=[[result objectForKey:@"Details"] valueForKey:@"image"];
                
                
                // (success message) dismiss delay of 1 sec
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
            }
            else
            {
               [SVProgressHUD showInfoWithStatus:[result objectForKey:@"message"]];
//                [[[UIAlertView alloc]initWithTitle:@"Error!" message:[result objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            }
            
        }
        else if (urlobj.statusCode==500 || urlobj.statusCode==400)
        {
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
//            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
            
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
//            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        }
    }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
//        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark -signup api call-- not used
-(void)SignUpApi
{
   
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSMutableString *urlString;
          
            
          
             //   urlString=[NSMutableString stringWithFormat:@"%@index.php/Signup",GLOBALAPI];
                
                
                urlString=[NSMutableString stringWithFormat:@"%@index.php/Signup?register_type=1&name=%@&email=%@&password=%@&language=%@&device_token=%@&device_type=1&mode=%@",GLOBALAPI,[Nametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Emailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[Passwordtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[LanguageLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"],[[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
            
            
            NSString *strEncoded,*requestBody;
            
            UIImage *secondImage = [UIImage imageNamed:@"no-image"];
            
            NSData *imgData = UIImagePNGRepresentation(ProfileImage.image);
            NSData *imgData1 = UIImagePNGRepresentation(secondImage);
            
            BOOL isCompare =  [imgData1 isEqual:imgData];
            if (!isCompare)
            {
                //             AttachmentImage.image=[self compressImage:AttachmentImage.image];
                //
                //            imgData = UIImageJPEGRepresentation(AttachmentImage.image, 1.0);
              //  DebugLog(@"Size of Image(bytes):%lu",(unsigned long)[imgData length]);
                
                
                strEncoded = [self encodeToBase64String:ProfileImage.image];
                requestBody= [NSString stringWithFormat:@"userimage=%@",strEncoded];
            }
            else
            {
                requestBody= [NSString stringWithFormat:@"userimage="];
            }
           
            
            DebugLog(@"post string: %@",urlString);
            DebugLog(@"requestBody string: %@",requestBody);
            
            [urlobj getSessionJsonResponseWithUploadImage :(NSString *)urlString Image :(NSString *)requestBody  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Registration successful.",nil)];
//                         AlertView = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                                message:@"Registration successful."
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:nil];
//                         
//                         [AlertView show];
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"user_id"] forKey:@"UserId"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"name"] forKey:@"Name"];
                         [[NSUserDefaults standardUserDefaults] setObject:[[responseDict objectForKey:@"Details"] valueForKey:@"image"] forKey:@"Image"];
                         
                         app.userId=[[responseDict objectForKey:@"Details"] valueForKey:@"user_id"];
                         app.userName=[[responseDict objectForKey:@"Details"] valueForKey:@"name"];
                         app.userImage=[[responseDict objectForKey:@"Details"] valueForKey:@"image"];
                         
                         
                         // (success message) dismiss delay of 1 sec
                         [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GotoNextPageAfterSuccess) userInfo:nil repeats: NO];
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         //                [[[UIAlertView alloc]initWithTitle:@"Error!" message:[result objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                 }
                 else
                 {
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     //            [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 }
                 
                 
             } failure:^(NSError *error) {
                 
                 [self checkLoader];
                 self.view.userInteractionEnabled = YES;
                 NSLog(@"Failure");
//                 [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                 
                 [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 
             }];
            
            
        }];
    }
    else
    {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}
#pragma mark -After registration go to Home screen
-(void)GotoNextPageAfterSuccess
{
    
       app.isLogged=true;
    [AlertView dismissWithClickedButtonIndex:0 animated:NO];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedIn"];
    JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
    
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
}

@end
