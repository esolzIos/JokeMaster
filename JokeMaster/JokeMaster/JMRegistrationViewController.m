//
//  JMRegistrationViewController.m
//  JokeMaster
//
//  Created by priyanka on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMRegistrationViewController.h"

@interface JMRegistrationViewController ()

@end

@implementation JMRegistrationViewController
@synthesize Nametxt,Emailtxt,Passwordtxt,ProfileImage,ProfileImageLabel,ConfirmPassword,mainscroll,Logintxtvw,LanguageView,LanguageLabel,LanguageBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // sign in text view design
    UIFont *font1 = [UIFont fontWithName:@"ComicSansMS-Bold" size:15];
    NSDictionary *arialDict = [NSDictionary dictionaryWithObject:font1 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Back to ",nil) attributes: arialDict];
    [aAttrString1 addAttribute:NSForegroundColorAttributeName
                         value:[UIColor whiteColor]
                         range:NSMakeRange(0, [aAttrString1 length])];
    
    UIFont *font2 = [UIFont fontWithName:@"ComicSansMS-Bold" size:20];
    NSDictionary *arialDict2 = [NSDictionary dictionaryWithObject:font2 forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"Log in",nil) attributes: arialDict2];
    [aAttrString2 addAttribute:NSForegroundColorAttributeName
                         value:[UIColor whiteColor]
                         range:NSMakeRange(0, [aAttrString2 length])];
    
    [aAttrString1 appendAttributedString:aAttrString2];
    Logintxtvw.attributedText = aAttrString1;
    Logintxtvw.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedTextView:)];
    [Logintxtvw addGestureRecognizer:tapRecognizer1];
    
    
    // place holder design
    Emailtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    Nametxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    Passwordtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    ConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    ProfileImageLabel.frame=CGRectMake(ProfileImageLabel.frame.origin.x, ProfileImage.frame.origin.y+ProfileImage.frame.size.height/2-ProfileImageLabel.frame.size.height/2, ProfileImageLabel.frame.size.width, ProfileImageLabel.frame.size.height);
    
    LangaugeArray=[[NSMutableArray alloc] initWithObjects:@"English",@"Hebrew",@"Spanish", nil];
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
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Enter Name"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else if ([self textFieldBlankorNot:Emailtxt.text]==YES)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Enter Email Address"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([self validateEmailWithString:Emailtxt.text]==NO)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Enter Valid Email Address"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([self textFieldBlankorNot:Passwordtxt.text]==YES)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Enter Password"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (Passwordtxt.text.length<6)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Password Should be at least 6 characters"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if ([self textFieldBlankorNot:ConfirmPassword.text]==YES)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Enter Confirm Password"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (![Passwordtxt.text isEqualToString:ConfirmPassword.text])
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Alert"
                                          message:@"Password and confirm password should be same."
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            
            
            
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
    
    
    if ([pressedWord isEqualToString:@"Log"] || [pressedWord isEqualToString:@"in"])
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
    actionsheet=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
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
    
    
    //  PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (buttonIndex) {
            
        case 0:
            
            
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera])
            {
                [self openCamera];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Camera Available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    ProfileImage.image=info[UIImagePickerControllerOriginalImage];
    
  //  ProfileImage.contentMode = UIViewContentModeScaleAspectFit;
    
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
//    [Nametxt resignFirstResponder];
//    [Emailtxt resignFirstResponder];
//    [Passwordtxt resignFirstResponder];
//    [ConfirmPassword resignFirstResponder];
//    
//    
//    if (LanguageBtn.selected==NO)
//    {
//        if (LangaugeArray.count>0)
//        {
//            [OverlayView removeFromSuperview];
//            
//            OverlayView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width,self.navigationController.visibleViewController.view.frame.size.height)];
//            OverlayView.backgroundColor = [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.6f];
//            [self.navigationController.visibleViewController.view addSubview:OverlayView];
//            
//            if (IsIphone4)
//            {
//                
//                
//                Langview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+10,OverlayView.frame.size.height-230, self.view.frame.size.width-20,220)];
//                
//                Langpicker=[[UIPickerView alloc] initWithFrame:CGRectMake(0,30, Langview.frame.size.width,190)];
//                
//                
//            }
//            else
//            {
//                
//                
//                Langview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+10, OverlayView.frame.size.height-330, self.view.frame.size.width-20,320)];
//                
//                Langpicker=[[UIPickerView alloc] initWithFrame:CGRectMake(0,30, Langview.frame.size.width,290)];
//            }
//            
//            
//            
//            Langpicker.layer.cornerRadius = 5.0f;
//            Langpicker.clipsToBounds = YES;
//            
//            Langview.layer.cornerRadius = 5.0f;
//            Langview.layer.borderWidth = 2.0f;
//            Langview.layer.borderColor = [UIColorFromRGB(0x4799EF) CGColor];
//            
//            Langview.backgroundColor=[UIColor whiteColor];
//            [OverlayView addSubview:Langview];
//            
//            
//            tipImage = [[UIImageView alloc] initWithFrame:CGRectMake(Langview.frame.origin.x+(Langview.frame.size.width-[UIImage imageNamed:@"downarrow"].size.width)/2, Langview.frame.origin.y+Langview.frame.size.height, [UIImage imageNamed:@"downarrow"].size.width, [UIImage imageNamed:@"downarrow"].size.height)];
//            tipImage.image = [UIImage imageNamed:@"downarrow"];
//            [OverlayView addSubview:tipImage];
//            
//            
//            LangBorderView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x,0, Langview.frame.size.width,30)];
//            LangBorderView.layer.cornerRadius = 5.0f;
//            LangBorderView.backgroundColor=UIColorFromRGB(0x4799EF);
//            LangBorderView.clipsToBounds = YES;
//            [Langview addSubview:LangBorderView];
//            
//            
//            Langpicker.delegate=self;
//            Langpicker.dataSource=self;
//            [Langpicker setBackgroundColor:[UIColor whiteColor]];
//            
//            if (lblCategory.text.length>0)
//            {
//                for (int i=0; i<[CategoryArray count]; i++)
//                {
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
//                }
//            }
//            
//            
//            [Catview addSubview:Catpicker];
//            
//            
//            
//            btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
//            btnSave.frame = CGRectMake(Catpicker.frame.origin.x+Catpicker.frame.size.width-50,0, 50, 30);
//            [btnSave setTitle:AMLocalizedString(@"Save",nil) forState:UIControlStateNormal];
//            
//            [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
//            btnSave.titleLabel.font = [UIFont fontWithName:LatoBold size:15.0];
//            [btnSave addTarget:self action:@selector(CategoryChange) forControlEvents:UIControlEventTouchUpInside];
//            [CatBorderView addSubview:btnSave];
//            [CatBorderView bringSubviewToFront:btnSave];
//            
//            btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
//            btnCancel.frame = CGRectMake(Catpicker.frame.origin.x,0, 70, 30);
//            
//            [btnCancel setTitle:AMLocalizedString(@"Cancel",nil) forState:UIControlStateNormal];
//            [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
//            btnCancel.titleLabel.font = [UIFont fontWithName:LatoBold size:15.0];
//            [btnCancel addTarget:self action:@selector(CategoryCancel) forControlEvents:UIControlEventTouchUpInside];
//            [CatBorderView addSubview:btnCancel];
//            [CatBorderView bringSubviewToFront:btnCancel];
//            
//            
//            
//            
//            btnCategory.selected=YES;
//        }
//        
//        
//    }
//    else
//    {
//        [UIView animateWithDuration:0.4f
//         
//                         animations:^{
//                             
//                             btnCategory.selected=NO;
//                             [Catview removeFromSuperview];
//                             [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
//                             
//                         }
//                         completion:^(BOOL finished)
//         {
//         }
//         ];
//        
//    }
}
//#pragma mark -  title picker cancel
//-(void)CategoryCancel
//{
//    [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
//    btnCategory.selected=NO;
//    
//    [OverlayView removeFromSuperview];
//    [tipImage removeFromSuperview];
//    [Catview removeFromSuperview];
//    
//}
//#pragma mark -  title picker title save
//-(void)CategoryChange
//{
//    
//    btnCategory.selected=NO;
//    
//    if (Cat.length==0) {
//        
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
//    }
//    else
//    {
//        lblCategory.text=Cat;
//    }
//    Cat=@"";
//    
//    [OverlayView removeFromSuperview];
//    [tipImage removeFromSuperview];
//    [Catview removeFromSuperview];
//    [mainscroll setContentOffset:CGPointMake(0.0f,0) animated:YES];
//    
//}
//#pragma mark -  picker delegate
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    if(pickerView==Catpicker)
//    {
//        return CategoryArray.count;
//    }
//    
//    else
//    {
//        return 0;
//    }
//}
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if(pickerView==Catpicker)
//    {
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
//        
//    }
//    
//    else
//    {
//        return @"";
//    }
//    
//}
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    if(pickerView==Catpicker)
//    {
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
//        
//    }
//    
//    else
//    {
//        
//    }
//}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView
//             attributedTitleForRow:(NSInteger)row
//                      forComponent:(NSInteger)component
//{
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
//    
//}

@end
