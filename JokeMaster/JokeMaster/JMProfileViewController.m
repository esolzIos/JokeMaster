//
//  JMProfileViewController.m
//  JokeMaster
//
//  Created by santanu on 15/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMProfileViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "JMUploadVideoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import "DZNPhotoEditorViewController.h"
#import "UIImagePickerController+Edit.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "UrlconnectionObject.h"
#import "JMCategoryVideoListViewController.h"
@interface JMProfileViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    UIImagePickerController *ipc;
    NSURLSession *session;
    BOOL firedOnce;
    NSDictionary *jsonResponse;
        AppDelegate *appDelegate;
    UIImage *selectedImage;
   UrlconnectionObject *urlobj;
}
@end

@implementation JMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    jsonResponse=[[NSDictionary alloc]init];
    
    
        [self addMoreView:self.view];
    MenuViewY=_MenuBaseView.frame.origin.y;
    
    _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
    _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
   urlobj=[[UrlconnectionObject alloc] init];
    
      CategoryArray=[[NSMutableArray alloc] init];
    
    [_userName setFont:[UIFont fontWithName:_userName.font.fontName size:[self getFontSize:_userName.font.pointSize]]];
    
     [_scoreLbl setFont:[UIFont fontWithName:_scoreLbl.font.fontName size:[self getFontSize:_scoreLbl.font.pointSize]]];
    
    
      [_membershipDate setFont:[UIFont fontWithName:_membershipDate.font.fontName size:[self getFontSize:_membershipDate.font.pointSize]]];
    
       [_CategoryLabel setFont:[UIFont fontWithName:_CategoryLabel.font.fontName size:[self getFontSize:_CategoryLabel.font.pointSize]]];
    
    
    
    if (_fromLeftMenu) {
           [_followBtn setTitle:@"UPLOAD A JOKE" forState:UIControlStateNormal];
     
    }
    else{
           [_followBtn setTitle:@"FOLLOW" forState:UIControlStateNormal];
    }
    
//    if (_ProfileUserId==nil)
//    {
//        self.HeaderView.HeaderLabel.text=@"My Channel";
//    }
//    else if (_ProfileUserId==[[NSUserDefaults standardUserDefaults] valueForKey:@"UserId"])
//    {
//        self.HeaderView.HeaderLabel.text=@"My Channel";
//    }
//    else
//    {
//        self.HeaderView.HeaderLabel.text=@"Profile";
//    }
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{

[self loadData];
}

-(void)loadData
{

    if([self networkAvailable])
    {
        
        firedOnce=true;
        
        [SVProgressHUD show];
        
        
        //     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        //http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/Userprofile?loggedin_id=1&user_id=1
        
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@Userprofile",GLOBALAPI,INDEX]];
        
        
        
        // configure the request
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        
        
        //        NSString *boundary = @"---------------------------14737809831466499882746641449";
        //        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        //        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        
        appDelegate.authToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"authToken"];
        
        NSString *sendData = @"loggedin_id=";
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", appDelegate.userId]];
        
        sendData = [sendData stringByAppendingString:@"&user_id="];
        sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@",@""]];


        
        
        
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        NSMutableData *theBodyData = [NSMutableData data];
        
        theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        
        //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
        
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                firedOnce=false;
      
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                firedOnce=false;
                
                
                
      
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    //   [SVProgressHUD showInfoWithStatus:sendData];
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    
                   
                    
                    
                    [SVProgressHUD dismiss];
                    if ([[jsonResponse objectForKey:@"status_code"]intValue]==406) {
                        
                    
                        
                    }
                    else
                        if ([[jsonResponse objectForKey:@"status_code"]intValue]==200) {
                            
                            
                       NSDictionary *userDetails=[jsonResponse objectForKey:@"userdetails"];
                            
                            
                            [_userName setText:[[NSString stringWithFormat:@"%@",[userDetails objectForKey:@"username"]] capitalizedString]];
                            
                            
                            
                            
                            [_profileImage sd_setImageWithURL:[NSURL URLWithString:[userDetails objectForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"noimage"]];
                            
//                            if ([[jsonResponse objectForKey:@"followerstatus"]boolValue]) {
//                                
//                                [_followBtn setImage:[UIImage imageNamed:@"unfollow"] forState:UIControlStateNormal];
//                            }
//                            else{
//                                [_followBtn setImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
//                            }
//                            
                          
                            
                            
                            
                        }
                    
                        else{
                            
                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                            
                            
                        }
                    
                    
                    
                    
                }
                
                
                
            }
            
            
        }];
        
        
        [task resume];
        
        
    }
    
    else{
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
       }

    
    

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
#pragma mark - CollectionView delegates

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (IsIphone5)
//    {
//        return CGSizeMake(self.view.frame.size.width/3,105);
//    }
//    else if (IsIphone6)
//    {
//        return CGSizeMake(self.view.frame.size.width/3,123);
//    }
//    else
//    {
//        return CGSizeMake(self.view.frame.size.width/3,135);
//    }
    
 return CGSizeMake(self.view.frame.size.width/3,105.0/480.0*FULLHEIGHT);
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"JMRecentUploadedCollectionViewCell";
    
    
    JMRecentUploadedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.VideoThumpnailImage.layer.cornerRadius=12.0;
    cell.VideoThumpnailImage.clipsToBounds=YES;
    
    [cell.CategoryNameLabel setFont:[UIFont fontWithName:cell.CategoryNameLabel.font.fontName size:[self getFontSize:9.0]]];
    
    //   NSLog(@"%@",[arrCategory objectAtIndex:indexPath.row]);
    
    //    cell.categoryLbl.text = [[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"category_name" ] uppercaseString];
    //
    //    [cell.categoryImage sd_setImageWithURL:[NSURL URLWithString:[[arrCategory objectAtIndex:indexPath.row]objectForKey:@"picture" ]] placeholderImage:[UIImage imageNamed: @"NoJob"]];
    //
    //    cell.categoryImage.layer.masksToBounds = YES;
    //    cell.categoryImage.layer.cornerRadius=5.0;
    //
    //    cell.OverlayView.layer.cornerRadius=5.0;
    
    return cell;
}

- (void)collectionView:(UICollectionViewCell *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    JMCategoryVideoListViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMVideoList"];
     VC.CategoryName=@"Animal";
    [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)followClicked:(id)sender {
    if (_fromLeftMenu ) {
        
        if (appDelegate.isLogged) {
            JMUploadVideoViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMUploadVideoViewController"];
            [self.navigationController pushViewController:VC animated:YES];
        }
        else{
            [SVProgressHUD showInfoWithStatus:@"Login required to upload videos"];
            
        }

    }
    else{
    
    }
}
- (IBAction)categoryClicked:(id)sender {
    _TransparentView.hidden=NO;
    _MenuBaseView.hidden=NO;
    
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         if (CategoryArray.count>0)
                         {
                             _TransparentView.frame = CGRectMake(0, 0, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
                             _MenuBaseView.frame = CGRectMake(0,MenuViewY, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
                         }
                         else
                         {
                             [self CategoryApi];
                         }
                         
                     }
                     completion:^(BOOL finished){
                     }];


}

- (IBAction)CategoryCrossTapped:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
                         _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                         
                     }];
}
#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [CategoryArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"JMCategoryCell";
    
    JMCategoryCell *cell = (JMCategoryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.CategoryLabel.text=[[CategoryArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    [cell.CategoryLabel setFont:[UIFont fontWithName:cell.CategoryLabel.font.fontName size:[self getFontSize:cell.CategoryLabel.font.pointSize]]];
    
    //    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"language"]] isEqualToString:@"he"])
    //    {
    //        cell.CategoryLabel.textAlignment=NSTextAlignmentRight;
    //    }
    //    else
    //    {
    //        cell.CategoryLabel.textAlignment=NSTextAlignmentLeft;
    //    }
    
    cell.CheckImage.tag=indexPath.row+500;
    cell.CheckButton.tag=indexPath.row;
    [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    //    if (IsIphone5 || IsIphone4)
    //    {
    //        return 50;
    //    }
    //    else
    //    {
    //        return 60;
    //    }
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(JMCategoryCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMCategoryCell *cell = [_CategoryTable
                            cellForRowAtIndexPath:indexPath];
    
    [cell.CheckButton setHighlighted:YES];
    [cell.CheckButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                     animations:^{
                         _TransparentView.frame = CGRectMake(0, self.view.frame.size.height, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
                         _MenuBaseView.frame = CGRectMake(0, self.view.frame.size.height, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
                     }
                     completion:^(BOOL finished)
     {
             }];

}
#pragma mark - Check button tapped on table
-(void)CheckButtonTap:(UIButton *)btn
{
    NSInteger tag=btn.tag;
    UIImageView *tickImage = (UIImageView* )[_CategoryTable viewWithTag:tag+500];
    if (btn.selected==NO)
    {
        btn.selected=YES;
        tickImage.image = [UIImage imageNamed:@"tick"];
    }
    else
    {
        btn.selected=NO;
        tickImage.image = [UIImage imageNamed:@"uncheck"];
    }
    
    
    
}
-(void)showImage
{
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = _profileImage.image;
    imageInfo.referenceRect = _profileImage.frame;
    imageInfo.referenceView = _profileImage.superview;
    
    // Setup view controller
    
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
    
}
- (IBAction)profileClicked:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Choose what to do"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    UIAlertAction *ViewImage = [UIAlertAction
                                actionWithTitle:@"View image"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    
                                    
                                    [self showImage];
                                    
                                    
                                }];
    
    
    
    UIAlertAction *changeImage = [UIAlertAction
                                  actionWithTitle:@"Change image"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      
                                      [self pickerCall];
                                      
                                  }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       DebugLog(@"Cancel action");
                                       
                                       
                                       
                                   }];
    
    
    [alertController addAction:cancelAction];
    
    
    [alertController addAction:changeImage];
    
    [alertController addAction:ViewImage];
    
    
    if (IDIOM==IPAD) {
        
        
        
        
        UIPopoverPresentationController *popPresenter = [alertController
                                                         popoverPresentationController];
        popPresenter.sourceView = _profileBttn;
        popPresenter.sourceRect = _profileBttn.bounds;
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    
    
    
    

}

-(void)pickerCall
{
    
    ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    
    ipc.allowsEditing=YES;
    
    ipc.cropMode=DZNPhotoEditorViewControllerCropModeSquare;
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Select image source"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction
                                   actionWithTitle:@"Camera"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                       if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                           
                                       {
                                           
                                           ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
                                           
                                           [self presentViewController:ipc animated:YES completion:^{
                                               
                                               
                                           }];
                                           
                                       }
                                       
                                       else
                                           
                                       {
                                           
                                           // [self showAlertwithTitle:@"" withMessage:@"No Camera Available."  withAlertType:UIAlertControllerStyleAlert withOk:YES withCancel:NO];
                                           
                                           [SVProgressHUD showInfoWithStatus:@"Camera not supported"];
                                           
                                           
                                       }
                                       
                                       
                                       
                                       
                                   }];
    
    UIAlertAction *galleryAction = [UIAlertAction
                                    actionWithTitle:@"Gallery"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        
                                        
                                        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                                        //                                        ipc.videoQuality = UIImagePickerControllerQualityTypeMedium;
                                        //                                        ipc.videoMaximumDuration = 180;
                                        //                                        ipc.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie,(NSString *)kUTTypeImage, nil];
                                        [self presentViewController:ipc animated:YES completion:^{
                                            
                                            
                                        }];
                                        
                                    }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       DebugLog(@"Cancel action");
                                       
                                       
                                       
                                       
                                   }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:cameraAction];
    [alertController addAction:galleryAction];
    
    
    if (IDIOM==IPAD) {
        
        
        
        
        UIPopoverPresentationController *popPresenter = [alertController
                                                         popoverPresentationController];
        popPresenter.sourceView = _profileBttn;
        popPresenter.sourceRect = _profileBttn.bounds;
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    
    
    
    
    
}
#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    //  if(IDIOM==IPHONE) {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
                NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
                if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
                {
        
//                    selectedImage=[info valueForKey:UIImagePickerControllerEditedImage];
//                    
//                    [_profileImage setImage:selectedImage];
//                    _profileImage.contentMode = UIViewContentModeScaleAspectFill;
//                     //_profileImage.clipsToBounds = YES;
//                    
//                }
        
        [SVProgressHUD showWithStatus:@"Processing"];
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
        {
            
            selectedImage=[info valueForKey:UIImagePickerControllerEditedImage];
            
            
            
            if ([self networkAvailable])
                
            {
                
                
                
                [SVProgressHUD showWithStatus:@"Uploading Please wait"];
                
                
                //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                
                
                
                
                NSData *imageData =  UIImagePNGRepresentation(selectedImage);
                
                NSString  *encodedString = [self base64forData:imageData];
                
                
                
               // http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/index.php/Userprofile/change_profile?user_id=1
                
                NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@Userprofile/change_profile",GLOBALAPI,INDEX]];
                
                // configure the request
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
                [request setHTTPMethod:@"POST"];
                
                
                
                NSString *sendData;
                
                
                sendData = @"user_id=";
          sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", appDelegate.userId]];
                
                sendData = [sendData stringByAppendingString:@"&userimage="];
                sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedString]];
                
                [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
                
                NSMutableData *theBodyData = [NSMutableData data];
                
                theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
                
                
                //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
                
                session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
                
                NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (error) {
                        NSLog(@"error = %@", error);
                        return;
                    }
                    
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        NSDictionary *Response = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            
                            [SVProgressHUD showInfoWithStatus:@"some error occured"];
                            
                            NSLog(@"response = %@",responseString);
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                            NSLog(@"result = %@",Response);
                            if ([[Response objectForKey:@"status_code"]intValue]==406) {
                                
                                appDelegate.userId=@"";
                                
                                appDelegate.authToken=@"";
                                
                                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                                
                                
                          
                                
                            }
                            else
                                if ([[Response objectForKey:@"code"]intValue]==200) {
                                    
                                    
                                    
                                    [SVProgressHUD dismiss];
                                    
                                    [_profileImage setImage:selectedImage];
                                    
                                    
                                    _profileImage.contentMode = UIViewContentModeScaleAspectFill;
                                    _profileImage.clipsToBounds = YES;
                                    
                                       [[NSUserDefaults standardUserDefaults] setObject:[Response objectForKey:@"image"] forKey:@"Image"];
                                       appDelegate.userImage=[Response objectForKey:@"image"];
                                    
                                }
                            
                                else{
                                    
                                    [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                                    
                                }
                        }
                    }
                }];
                [task resume];
                
            }
            
            else
                
            {
                
                [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
            }
        }
                }
    }];
    
    
    
    //        [picker dismissViewControllerAnimated:YES completion:^{
    //            selectedImage=[info valueForKey:UIImagePickerControllerEditedImage];
    //
    //
    ////
    ////                CGRect rect = CGRectMake(0,0,200,200);
    ////                UIGraphicsBeginImageContext( rect.size );
    ////                [[info
    ////                  objectForKey:@"UIImagePickerControllerEditedImage"] drawInRect:rect];
    ////                UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    ////                UIGraphicsEndImageContext();
    ////                NSData *imageData = UIImagePNGRepresentation(picture1);
    ////                  UIImage *image=[UIImage imageWithData:imageData];
    //
    //            [_selectedImageView setImage:selectedImage];
    //
    //
    //          _selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    //           _selectedImageView.clipsToBounds = NO;
    //
    //
    //            [_imagePlaceHolder setHidden:YES];
    //
    //            [postBtn setUserInteractionEnabled:YES];
    //
    //            [postBtn.titleLabel setTextColor:[UIColor darkGrayColor]];
    //
    //        }];
    
    // }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    
}
#pragma mark -Category list API
-(void)CategoryApi
{
    
    
    BOOL net=[urlobj connectedToNetwork];
    if (net==YES)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.view.userInteractionEnabled = NO;
            [self checkLoader];
        }];
        [[NSOperationQueue new] addOperationWithBlock:^{
            
            NSString *urlString;
            
            
            urlString=[NSString stringWithFormat:@"%@index.php/video/category",GLOBALAPI];
            
            
            
            urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            DebugLog(@"Send string Url%@",urlString);
            
            
            
            
            [urlobj getSessionJsonResponse:urlString  success:^(NSDictionary *responseDict)
             {
                 
                 DebugLog(@"success %@ Status Code:%ld",responseDict,(long)urlobj.statusCode);
                 
                 
                 self.view.userInteractionEnabled = YES;
                 [self checkLoader];
                 
                 if (urlobj.statusCode==200)
                 {
                     if ([[responseDict objectForKey:@"status"] boolValue]==YES)
                     {
                         CategoryArray=[[responseDict objectForKey:@"details"] mutableCopy];
                         
                         
                         if (CategoryArray.count>0)
                         {
                             [UIView animateWithDuration:0.5
                                                   delay:0.1
                                                 options:(UIViewAnimationOptions) UIViewAnimationCurveEaseIn
                                              animations:^{
                             _TransparentView.frame = CGRectMake(0, 0, _TransparentView.frame.size.width, _TransparentView.frame.size.height);
                             _MenuBaseView.frame = CGRectMake(0,MenuViewY, _MenuBaseView.frame.size.width, _MenuBaseView.frame.size.height);
                             
                             [_CategoryTable reloadData];
                                              }
                                              completion:^(BOOL finished){
                                              }];
                         }
                         
                         
                   

                         
                     }
                     else
                     {
                         [SVProgressHUD showInfoWithStatus:[responseDict objectForKey:@"message"]];
                         //                         [[[UIAlertView alloc]initWithTitle:@"Error!" message:[responseDict objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     }
                     
                 }
                 else if (urlobj.statusCode==500 || urlobj.statusCode==400)
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                     
                 }
                 else
                 {
                     //                     [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                     
                     [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                 }
                 
             }
                                   failure:^(NSError *error) {
                                       
                                       [self checkLoader];
                                       self.view.userInteractionEnabled = YES;
                                       NSLog(@"Failure");
                                       //                                       [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Server Failed to Respond" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
                                       
                                       [SVProgressHUD showInfoWithStatus:AMLocalizedString(@"Server Failed to Respond",nil)];
                                       
                                   }
             ];
        }];
    }
    else
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        //        [[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Network Not Available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
    }
}

@end
