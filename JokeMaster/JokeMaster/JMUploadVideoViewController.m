//
//  JMUploadVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 19/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMUploadVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <CoreMedia/CoreMedia.h>
#import "JMHomeViewController.h"
@import Photos;
@import PhotosUI;

@interface JMUploadVideoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UITextFieldDelegate>
{
    UIImagePickerController *ipc;
    
    UIImage *selectedImage;
    int rowSelected;
    bool langPickerOpen,catPickerOpen,videoPicked;
    NSMutableArray *langArr,*codeArr,*categoryArr;
    NSData *videoData;
    NSData* imageData;
    NSString *langSelected,*categorySelected;
    AppDelegate *app;
}
@end

@implementation JMUploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    [self setRoundCornertoView:_loadingView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _videoName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:AMLocalizedString(@"Video Name",nil) attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self addMoreView:self.view];
    
    categoryArr=[[NSMutableArray alloc] init];
    
    //    langArr=[[NSMutableArray alloc] initWithObjects:@"English",@"Hebrew",@"Hindi",@"Chinese",@"Spanish", nil];
    //
    //    codeArr=[[NSMutableArray alloc] initWithObjects:@"en",@"he",@"hi",@"zh",@"es", nil];
    
    langArr=[[NSMutableArray alloc] init];
    
    codeArr=[[NSMutableArray alloc] init];
    
    [_languagePicker setDelegate:self];
    
    
    [_jokeLang setFont:[UIFont fontWithName:_jokeLang.font.fontName size:[self getFontSize:_jokeLang.font.pointSize]]];
    [_categoryLbl setFont:[UIFont fontWithName:_categoryLbl.font.fontName size:[self getFontSize:_categoryLbl.font.pointSize]]];
    [_cancelLabl setFont:[UIFont fontWithName:_cancelLabl.font.fontName size:[self getFontSize:_cancelLabl.font.pointSize]]];
    [_warningLbl setFont:[UIFont fontWithName:_warningLbl.font.fontName size:[self getFontSize:_warningLbl.font.pointSize]]];
    
    [_warningInfo setFont:[UIFont fontWithName:_warningInfo.font.fontName size:[self getFontSize:_warningInfo.font.pointSize]]];
    [_okLbl setFont:[UIFont fontWithName:_okLbl.font.fontName size:[self getFontSize:_okLbl.font.pointSize]]];
    [_cancelLabl setFont:[UIFont fontWithName:_cancelLabl.font.fontName size:[self getFontSize:_cancelLabl.font.pointSize]]];
    
    [_tapInfo setFont:[UIFont fontWithName:_tapInfo.font.fontName size:[self getFontSize:_tapInfo.font.pointSize]]];
    
    [_cameraLbl setFont:[UIFont fontWithName:_cameraLbl.font.fontName size:[self getFontSize:_cameraLbl.font.pointSize]]];
    
    [_galleryLbl setFont:[UIFont fontWithName:_galleryLbl.font.fontName size:[self getFontSize:_galleryLbl.font.pointSize]]];
    [_uploadBtn.titleLabel setFont:[UIFont fontWithName:_uploadBtn.titleLabel.font.fontName size:[self getFontSize:_uploadBtn.titleLabel.font.pointSize]]];
    
    // Do any additional setup after loading the view.
    
    [_mainScroll setContentSize:CGSizeMake(FULLWIDTH,  465.0/480.0*FULLHEIGHT)];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
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

- (IBAction)Test:(id)sender
{
    DebugLog(@"testtttt");
}
- (IBAction)uploadClicked:(id)sender {
    
    [_warningView setHidden:NO];
    
}
- (IBAction)cameraClicked:(id)sender {
    ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    
    ipc.allowsEditing=YES;
    
    
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.videoQuality = UIImagePickerControllerQualityTypeMedium;
        ipc.videoMaximumDuration = 60;
        ipc.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        [self presentViewController:ipc animated:YES completion:^{
            
            
        }];
        
    }
    
    else
        
    {
        
        // [self showAlertwithTitle:@"" withMessage:@"No Camera Available."  withAlertType:UIAlertControllerStyleAlert withOk:YES withCancel:NO];
        
        [SVProgressHUD showInfoWithStatus:@"Camera not supported"];
        
        
    }
    
}
- (IBAction)galleryClicked:(id)sender {
    ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    
    ipc.allowsEditing=YES;
    
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ipc.videoQuality = UIImagePickerControllerQualityTypeMedium;
    ipc.videoMaximumDuration = 60;
    ipc.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [self presentViewController:ipc animated:YES completion:^{
        
        
    }];
    
    
}


#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    if(IDIOM==IPHONE) {
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            [SVProgressHUD showWithStatus:@"Processing"];
            
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
            {
                
                [SVProgressHUD showInfoWithStatus:@"Only videos are allowed"];
                
            }
            else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
            {
                NSURL *urlvideo = [info objectForKey:UIImagePickerControllerReferenceURL];
                
                
                PHFetchResult *refResult = [PHAsset fetchAssetsWithALAssetURLs:@[urlvideo] options:nil];
                PHVideoRequestOptions *videoRequestOptions = [[PHVideoRequestOptions alloc] init];
                videoRequestOptions.version = PHVideoRequestOptionsVersionCurrent;
                videoRequestOptions.deliveryMode=PHVideoRequestOptionsDeliveryModeFastFormat;
                
                [[PHImageManager defaultManager] requestAVAssetForVideo:[refResult firstObject] options:videoRequestOptions resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
                    if ([asset isKindOfClass:[AVURLAsset class]]) {
                        NSURL *compressedUrl = [(AVURLAsset *)asset URL];
                        videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[compressedUrl path]]];
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [_loadingView setHidden:NO];
                            
                            
                            AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:compressedUrl options:nil];
                            AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                            generator.appliesPreferredTrackTransform=TRUE;
                            
                            CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
                            
                            
                            
                            AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
                                if (result != AVAssetImageGeneratorSucceeded) {
                                    DebugLog(@"couldn't generate thumbnail, error:%@", error);
                                    
                                    
                                    
                                    // [SVProgressHUD showInfoWithStatus:@"Something went wrong"];
                                    
                                }
                                
                                imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:im]);
                                
                                if ( imageData!=nil )
                                {
                                    // selectedImage=[UIImage imageWithCGImage:im];
                                    
                                    videoPicked=true;
                                    
                                    [_videoThumb setImage:[UIImage imageWithCGImage:im]];
                                    
                                    
                                    _videoThumb.contentMode = UIViewContentModeScaleAspectFill;
                                    _videoThumb.clipsToBounds = YES;
                                    
                                    
                                    [_optionView setHidden:YES];
                                    [_loadingView setHidden:YES];
                                    
                                    
                                    [_uploadBtn setUserInteractionEnabled:YES];
                                    
                                    
                                    
                                    [SVProgressHUD dismiss];
                                }
                                else{
                                    
                                    [SVProgressHUD showInfoWithStatus:@"Something went wrong"];
                                    
                                }
                                
                                
                                
                            };
                            
                            CGSize maxSize = CGSizeMake(320, 180);
                            generator.maximumSize = maxSize;
                            [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
                            
                            
                        });
                        
                        
                    }
                }];
                
                
                
                
                
                
                
                
                
                
                
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
        
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [_uploadBtn setUserInteractionEnabled:YES];
        
        
        
    }];
    
    
}

- (IBAction)selectClicked:(id)sender {
    
    // selected=true;
    
    if (langPickerOpen) {
        [_jokeLang setText:[langArr objectAtIndex:rowSelected]];
        
        langSelected=[codeArr objectAtIndex:rowSelected];
        
        DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);
    }
    else if (catPickerOpen) {
        
        [_categoryLbl setText:[[categoryArr objectAtIndex:rowSelected] objectForKey:@"name"]];
        
        categorySelected=[[categoryArr objectAtIndex:rowSelected] objectForKey:@"id"];
        
        
    }
    
    
    
    [_pickerView setHidden:YES];
}
- (IBAction)cancelClicked:(id)sender {
    
    [_pickerView setHidden:YES];
}

#pragma mark picker delegates

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (langPickerOpen) {
        return langArr.count;
    }
    
    else if(catPickerOpen)
    {
        return categoryArr.count;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    // NSString *text = nil;
    // Reuse the label if possible, otherwise create and configure a new one
    if ((pickerLabel == nil) || ([pickerLabel class] != [UILabel class])) { //newlabel
        CGRect frame = CGRectMake(0.0, 0.0, 270, 32.0);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        pickerLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:24];
        
        if (langPickerOpen) {
            [pickerLabel setText:[langArr objectAtIndex:row]];
        }
        else if (catPickerOpen) {
            [pickerLabel setText:[[categoryArr objectAtIndex:row] objectForKey:@"name"]];
        }
    }
    pickerLabel.textColor = [UIColor whiteColor];
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 50.0/480.0*FULLHEIGHT;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (langPickerOpen) {
        return [langArr objectAtIndex:row];
    }
    
    else if(catPickerOpen)
    {
        return [[categoryArr objectAtIndex:row]objectForKey:@"name"];
    }
    return @"";
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowSelected=(int)row;
    
    
    
}


- (IBAction)langClicked:(id)sender {
    
    [_pickerView setHidden:NO];
    
    langPickerOpen=true;
    catPickerOpen=false;
    
    [_languagePicker reloadAllComponents];
}
- (IBAction)categoryClicked:(id)sender {
    
    catPickerOpen=true;
    langPickerOpen=false;
    [_pickerView setHidden:NO];
    
    
    
    [_languagePicker reloadAllComponents];
}
- (IBAction)warnCancelled:(id)sender {
    
    [_warningView setHidden:YES];
}
- (IBAction)warnOkClicked:(id)sender {
    [_warningView setHidden:YES];
    
    [self fireUrl];
    
}
- (IBAction)crossClicked:(id)sender {
    [_warningView setHidden:YES];
}

-(void)fireUrl
{
    
    if ([self textFieldBlankorNot:_videoName.text]) {
        [SVProgressHUD showInfoWithStatus:@"Video name cannot be blank"];
    }
    else if ([self textFieldBlankorNot:langSelected]) {
        [SVProgressHUD showInfoWithStatus:@"Select joke language"];
    }
    else if ([self textFieldBlankorNot:categorySelected]) {
        [SVProgressHUD showInfoWithStatus:@"Select joke Category"];
    }
    
    else if (!videoPicked) {
        [SVProgressHUD showInfoWithStatus:@"Please select a video to continue"];
    }
    
    
    else
    {
        
        if ([self networkAvailable])
            
        {
            
            
            [_uploadBtn setUserInteractionEnabled:NO];
            
            [SVProgressHUD show];
            
            
            
            
            
            
            
            //            NSData *imageData =  UIImagePNGRepresentation(selectedImage);
            
            NSString  *encodedImgString = [self base64forData:imageData];
            
            NSString  *encodedVidString = [self base64forData:videoData];
            
            NSURL *url;
            
            
            
            url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@Video/AddVideo",GLOBALAPI,INDEX]];
            
            
            
            // configure the request
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            [request setHTTPMethod:@"POST"];
            
            
            
            
            
            
            NSString *sendData = @"user_id=";
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.userId]];
            
            
            sendData = [sendData stringByAppendingString:@"&language="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", langSelected]];
            
            sendData = [sendData stringByAppendingString:@"&country="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"]]];
            
            sendData = [sendData stringByAppendingString:@"&category="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", categorySelected]];
            
            sendData = [sendData stringByAppendingString:@"&videoname="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", _videoName.text]];
            
            sendData = [sendData stringByAppendingString:@"&video="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedVidString]];
            
            sendData = [sendData stringByAppendingString:@"&videoimage="];
            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedImgString]];
            
            [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
            
            NSMutableData *theBodyData = [NSMutableData data];
            
            theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
            
            
            //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
            
            session =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
            
            NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                [_uploadBtn setUserInteractionEnabled:YES];
                
                
                if (error) {
                    NSLog(@"error = %@", error);
                    return;
                }
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSError *jsonError;
                    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                    
                    
                    
                    if (jsonError) {
                        // Error Parsing JSON
                        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        
                        [SVProgressHUD showInfoWithStatus:@"some error occured"];
                        
                        NSLog(@"response = %@",responseString);
                    } else {
                        // Success Parsing JSON
                        // Log NSDictionary response:
                        NSLog(@"result = %@",jsonResponse);
                        
                        
                        if ([[jsonResponse objectForKey:@"status_code"]intValue]==406) {
                            
                            //                            app.userId=@"";
                            //
                            //                            app.authToken=@"";
                            //
                            //
                            //
                            //                            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                            //                            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                            //
                            //
                            //
                            //                            ADLoginViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"ADLogin"];
                            //                            VC.forcedToLogin=true;
                            //                            [self PushViewController:VC WithAnimation:kCAMediaTimingFunctionEaseIn];
                            
                        }
                        else
                            if ([[jsonResponse objectForKey:@"code"]intValue]==200) {
                                
                                
                                
                                [SVProgressHUD showInfoWithStatus:@"Video uploaded Successfully"];
                                
                                [self performSelector:@selector(loadProfile) withObject:nil afterDelay:3.0];
                                
                                
                                
                                
                                
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

-(void)loadProfile
{
    JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
    
    
    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
}

-(void)loadData
{
    
    if([self networkAvailable])
    {
        
        
        
        [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage",GLOBALAPI,INDEX];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
                [_langBtn setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                [_langBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([jsonResponse objectForKey:@"status"]) {
                        
                        
                        
                        langjsonArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        totalCount=(int)langjsonArr.count;
                        
                        
                        
                        [SVProgressHUD dismiss];
                        
                        
                        
                        for (NSDictionary *langDict in langjsonArr) {
                            
                            [langArr addObject:[langDict objectForKey:@"name"]];
                            [codeArr addObject:[langDict objectForKey:@"id"]];
                            
                        }
                        
                        if (langArr.count>0) {
                            [_langBtn setUserInteractionEnabled:YES];
                        }
                        else{
                            
                            [_langBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    else{
                        
                        if (langArr.count==0) {
                            
                            [SVProgressHUD dismiss];
                        }
                        else{
                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
            [self loadCategory];
            
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
}

-(void)loadCategory
{
    if([self networkAvailable])
    {
        
        
        
        [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@video/category",GLOBALAPI,INDEX];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
                [_langBtn setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
                [_langBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [SVProgressHUD showInfoWithStatus:@"some error occured"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"code"] intValue]==200) {
                        
                        
                        
                        categoryArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        //totalCount=(int)categoryArr.count;
                        
                        
                        
                        [SVProgressHUD dismiss];
                        
                        
                        
                        
                        
                        if (categoryArr.count>0) {
                            
                            [_langBtn setUserInteractionEnabled:YES];
                            //[_languagePicker reloadAllComponents];
                        }
                        else{
                            
                            [_langBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    else{
                        
                        if (categoryArr.count==0) {
                            
                            [SVProgressHUD dismiss];
                        }
                        else{
                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

@end
