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
#import "AFNetworking.h"

@import Photos;
@import PhotosUI;

@interface JMUploadVideoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UITextFieldDelegate,NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>
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
@property (nonatomic, retain) NSMutableData *dataToDownload;
@property (nonatomic) float downloadSize;
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
    

    
    [_languagePicker setDelegate:self];
    
    
    [_jokeLang setFont:[UIFont fontWithName:_jokeLang.font.fontName size:[self getFontSize:_jokeLang.font.pointSize]]];
    [_categoryLbl setFont:[UIFont fontWithName:_categoryLbl.font.fontName size:[self getFontSize:_categoryLbl.font.pointSize]]];
    [_cancelLabl setFont:[UIFont fontWithName:_cancelLabl.font.fontName size:[self getFontSize:_cancelLabl.font.pointSize]]];
    [_warningLbl setFont:[UIFont fontWithName:_warningLbl.font.fontName size:[self getFontSize:_warningLbl.font.pointSize]]];
    
    [_warningInfo setFont:[UIFont fontWithName:_warningInfo.font.fontName size:[self getFontSize:_warningInfo.font.pointSize]]];
    [_okLbl setFont:[UIFont fontWithName:_okLbl.font.fontName size:[self getFontSize:_okLbl.font.pointSize]]];
    [_cancelLabl setFont:[UIFont fontWithName:_cancelLabl.font.fontName size:[self getFontSize:_cancelLabl.font.pointSize]]];
    
        [_loadingLbl setFont:[UIFont fontWithName:_loadingLbl.font.fontName size:[self getFontSize:_loadingLbl.font.pointSize]]];
    
    [_tapInfo setFont:[UIFont fontWithName:_tapInfo.font.fontName size:[self getFontSize:_tapInfo.font.pointSize]]];
    
    [_cameraLbl setFont:[UIFont fontWithName:_cameraLbl.font.fontName size:[self getFontSize:_cameraLbl.font.pointSize]]];
    
    [_galleryLbl setFont:[UIFont fontWithName:_galleryLbl.font.fontName size:[self getFontSize:_galleryLbl.font.pointSize]]];
    [_uploadBtn.titleLabel setFont:[UIFont fontWithName:_uploadBtn.titleLabel.font.fontName size:[self getFontSize:_uploadBtn.titleLabel.font.pointSize]]];
    
    // Do any additional setup after loading the view.
    
    [_mainScroll setContentSize:CGSizeMake(FULLWIDTH,  470.0/480.0*FULLHEIGHT)];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"giphy.gif" ofType:nil];
    NSData* imageD = [NSData dataWithContentsOfFile:filePath];
    
    _gifImage.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageD];
    
    [self setRoundCornertoView:_gifImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_noVideoView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_loaderImage withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [self setRoundCornertoView:_cancelView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    [_noVideoLbl setFont:[UIFont fontWithName:_noVideoLbl.font.fontName size:[self getFontSize:_noVideoLbl.font.pointSize]]];
    
    
    [_selectBtn setTitle:AMLocalizedString(@"Select", nil)  forState:UIControlStateNormal];
    
    [_cancelBttn setTitle:AMLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appendPushView) name:@"pushReceived" object:nil];
    
    //   // Do any additional setup after loading the view.
}


-(void)appendPushView
{
    [self addPushView:self.view];
}

-(void)viewWillAppear:(BOOL)animated

{
    categoryArr=[[NSMutableArray alloc] init];
    
    //    langArr=[[NSMutableArray alloc] initWithObjects:@"English",@"Hebrew",@"Hindi",@"Chinese",@"Spanish", nil];
    //
    //    codeArr=[[NSMutableArray alloc] initWithObjects:@"en",@"he",@"hi",@"zh",@"es", nil];
    
    langArr=[[NSMutableArray alloc] init];
    
    codeArr=[[NSMutableArray alloc] init];
    [_langBtn setUserInteractionEnabled:NO];
    [_categoryBtn setUserInteractionEnabled:NO];
    
    
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


- (IBAction)uploadClicked:(id)sender {
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

    [_warningView setHidden:NO];
    }
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
            
         //   [SVProgressHUD showWithStatus:@"Processing"];
            
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
            {
                
                [SVProgressHUD showInfoWithStatus:@"Only videos are allowed"];
                
            }
            else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
            {
                NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
                
                
                
                // If mediaURL is not null this should be a video
                if(urlvideo) {
                    
                    // This video is new just recorded with camera
                 //   if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
                        // First save the video to photos album
                        ALAssetsLibrary *library = [ALAssetsLibrary new];
                        [library writeVideoAtPathToSavedPhotosAlbum:urlvideo completionBlock:^(NSURL *assetURL, NSError *error){
                            if (error) {
                                DebugLog(@"Failed to save the photo to photos album...");
                            } else {
                                // Get the name of the video
                            //    [self getMediaName:nil url:assetURL];
                                
                          
                                
                                
                                PHFetchResult *refResult = [PHAsset fetchAssetsWithALAssetURLs:@[assetURL] options:nil];
                                PHVideoRequestOptions *videoRequestOptions = [[PHVideoRequestOptions alloc] init];
                                videoRequestOptions.version = PHVideoRequestOptionsVersionCurrent;
                                videoRequestOptions.deliveryMode=PHVideoRequestOptionsDeliveryModeFastFormat;
                                
                                [[PHImageManager defaultManager] requestAVAssetForVideo:[refResult firstObject] options:videoRequestOptions resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
                                    if ([asset isKindOfClass:[AVURLAsset class]]) {
                                        NSURL *compressedUrl = [(AVURLAsset *)asset URL];
                                        videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[compressedUrl path]]];
                                        
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            [_loadingView setHidden:NO];
                                            [_infoLbl setText:@"GENERATING IMAGE"];
                                            
                                            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:compressedUrl options:nil];
                                            AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                                            generator.appliesPreferredTrackTransform = YES;
                                            CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
                                            NSError *error = nil;
                                            CMTime actualTime;
                                            
                                            CGImageRef image = [generator copyCGImageAtTime:thumbTime actualTime:&actualTime error:&error];
                                            UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
                                       
                                                imageData = UIImagePNGRepresentation(thumb);
                                            
                                              CGSize maxSize = CGSizeMake(640, 360);
                                              generator.maximumSize = maxSize;
                                            
                                            
//                                            AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:compressedUrl options:nil];
//                                            AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//                                            generator.appliesPreferredTrackTransform=TRUE;
//                                            
//                                            CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
//                                            
//                                            
//                                            
//                                            AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
//                                                if (result != AVAssetImageGeneratorSucceeded) {
//                                                    DebugLog(@"couldn't generate thumbnail, error:%@", error);
//                                                    
//                                                    
//                                                    
//                                                    // [SVProgressHUD showInfoWithStatus:@"Something went wrong"];
//                                                    
//                                                }
                                            
                                             //   imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:im]);
                                                
                                                if ( imageData!=nil )
                                                {
                                                    // selectedImage=[UIImage imageWithCGImage:im];
                                                    
                                                    videoPicked=true;
                                                    
                                                    [_videoThumb setImage:thumb];
                                                    
                                                    
                                                    _videoThumb.contentMode = UIViewContentModeScaleAspectFill;
                                                    _videoThumb.clipsToBounds = YES;
                                                    
                                                    
                                                    [_optionView setHidden:YES];
                                                    [_loadingView setHidden:YES];
                                                    [_cancelView setHidden:NO];
                                                    
                                                    

                                                    
                                                    
                                                    
                                                  //  [SVProgressHUD dismiss];
                                                }
                                                else{
                                                    
                                                    [SVProgressHUD showInfoWithStatus:@"Something went wrong"];
                                                    
                                                }
                                                
                                                
                                                
                                         //   };
                                            
                                          //  CGSize maxSize = CGSizeMake(640, 360);
                                          //  generator.maximumSize = CGSizeZero;
                                          //  [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
                                            
                                            
                                        });
                                        
                                        
                                    }
                                }];
                                
                                

                                
                            }
                        }];
                                                                                                                                                                                                               
                }

                
              }
            
            
            
        }];
        
        
 
        
    }
    
    
}


- (void)getMediaName:(UIImage*)originalImage url:(NSURL*)url {
    @try {
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *asset) {
            if (asset == nil) return;
            ALAssetRepresentation *assetRep = [asset defaultRepresentation];
            NSString *fileName = [assetRep filename];
            // Do what you need with the file name here
        };
        
        ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *error) {
            DebugLog(@"Failed to get image or video name : %@", error);
        };
        
        ALAssetsLibrary *library = [ALAssetsLibrary new];
        [library assetForURL:url resultBlock:resultblock failureBlock:failureblock];
    }
    @catch (NSException *exception) {
        DebugLog(@"%@", [exception description]);
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
        [_jokeLang setText:[[langArr objectAtIndex:rowSelected]objectForKey:@"name"]];
        
        langSelected=[[langArr objectAtIndex:rowSelected]objectForKey:@"id"];
        
       // DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);
    }
    else if (catPickerOpen) {
        
        [_categoryLbl setText:[[[[categoryArr objectAtIndex:rowSelected]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString]];
        
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
        pickerLabel.font = [UIFont fontWithName:@"ComicSansMS-Bold" size:[self getFontSize:14]];
        
        if (langPickerOpen) {
            [pickerLabel setText:[[langArr objectAtIndex:row]objectForKey:@"name"]];
        }
        else if (catPickerOpen) {
            
            NSString *htmlString = [[[[categoryArr objectAtIndex:row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];

            pickerLabel.text = htmlString;
            
           // [pickerLabel setText:[[categoryArr objectAtIndex:row] objectForKey:@"name"]];
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
        return [[langArr objectAtIndex:rowSelected]objectForKey:@"name"];
    }
    
    else if(catPickerOpen)
    {
        return [[[[categoryArr objectAtIndex:row]objectForKey:@"name"]stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
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
    
    [self fireAFUrl];
    
}
- (IBAction)crossClicked:(id)sender {
    [_warningView setHidden:YES];
}

- (NSString *)generateBoundaryString {
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}

-(void)fireAFUrl
{
    
      [_loadingView setHidden:NO];
      [_infoLbl setText:@"UPLOADING"];

    if ([self networkAvailable]) {
        
                  [_uploadBtn setUserInteractionEnabled:NO];
        
//                    NSString  *encodedImgString = [self base64forData:imageData];
//        
//                    NSString  *encodedVidString = [self base64forData:videoData];
        
        NSMutableDictionary *dictParam = [NSMutableDictionary new];
        
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        
//        requestSerializer = [AFJSONRequestSerializer serializer];
  ///  responseSerializer = [AFJSONResponseSerializer serializer];
        
        [dictParam setValue:app.userId forKey:@"user_id"];
         [dictParam setValue:langSelected forKey:@"language"];
         [dictParam setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"userCountry"] forKey:@"country"];
         [dictParam setValue:categorySelected forKey:@"category"];
         [dictParam setValue: _videoName.text forKey:@"videoname"];
         [dictParam setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"] forKey:@"mode"];
        [dictParam setValue: PUSHTYPE forKey:@"pushmode"];
        
        
        DebugLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userCountry"] );
        
        
        
        
        NSError *__autoreleasing *error;
        

        NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@Video/AddVideo",GLOBALAPI,INDEX] parameters:dictParam constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
         
            if (videoData != nil) {
              
                    [formData appendPartWithFileData:videoData
                                                name:@"video"
                                            fileName:@"video.mov"
                                            mimeType:@"video/mp4"];
           
            }
            
            if (imageData != nil) {
                [formData appendPartWithFileData:imageData
                                            name:@"videoimage"
                                        fileName:@"videoimage.png"
                                        mimeType:@"image/png"];
            }
        } error:(NSError *__autoreleasing *)error];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        manager.responseSerializer = responseSerializer;

        NSURLSessionUploadTask *uploadTask;
        
        uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Video Uploading Progress = %f", uploadProgress.fractionCompleted);
                
   [_loadingLbl setText:[NSString stringWithFormat:@"%.f%@",uploadProgress.fractionCompleted*100,@"%"]];

                [SVProgressHUD showProgress:uploadProgress.fractionCompleted];

            });
        }
                      
     completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                              
         [_uploadBtn setUserInteractionEnabled:YES];
                                              
          if (error) {
         NSLog(@"ERROR WHILE UPLOAD USER VIDEO THROUGH AFNETWORDKING = %@",error.localizedDescription);
                                              
              }
           else {
           NSLog(@"JSON: %@", [responseObject description]);
                                                  
      

              
               NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
               
               //NSDictionary * response = responseObject;
               
             DebugLog(@"json returns: %@",string);
               
               NSData *newJSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
               NSDictionary* response = [NSJSONSerialization
                                     JSONObjectWithData:newJSONData
                                     options:NSJSONReadingMutableContainers
                                     error:&error];
    
             DebugLog(@"json response: %@",response);
       
                                                  
          if ([[response objectForKey:@"status"]boolValue]) {
                                                      
                                                      
                                                      
              [SVProgressHUD showInfoWithStatus:@"Video uploaded Successfully"];
                                                      
              
                [[NSNotificationCenter defaultCenter] postNotificationName:@"videoLoaded"  object:self];
                 
                 NSLog(@"Success");
                                 }
            
                             }
                       }];
        [uploadTask resume];
        
           [self loadProfile];
    }
        
        
    
    else{
        
        // [self showAlertwithTitle:@"No internet" withMessage:@"Please check your Internet connection" withAlertType:UIAlertControllerStyleAlert withOk:YES withCancel:NO];
        
        [SVProgressHUD showInfoWithStatus:@"Please check your Internet connection"];
        
    }
    

    

}

//-(void)fireUrl
//{
//    
//    [_loadingView setHidden:NO];
//    
//        
//        
//        if ([self networkAvailable])
//            
//        {
//            
//            
//            [_uploadBtn setUserInteractionEnabled:NO];
//            
//          //  [SVProgressHUD show];
//            
//            
//            
//            
//            
//            
//            
//            //            NSData *imageData =  UIImagePNGRepresentation(selectedImage);
//            
//            NSString  *encodedImgString = [self base64forData:imageData];
//            
//            NSString  *encodedVidString = [self base64forData:videoData];
//            
//            NSURL *url;
//            
//            
//            
//            url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@Video/AddVideo",GLOBALAPI,INDEX]];
//            
//            
//            
//            // configure the request
//            
//            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//            [request setHTTPMethod:@"POST"];
//            
//            
//            
//            
//            
//            
//            NSString *sendData = @"user_id=";
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", app.userId]];
//            
//            
//            sendData = [sendData stringByAppendingString:@"&language="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", langSelected]];
//            
//            sendData = [sendData stringByAppendingString:@"&country="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"countryId"]]];
//            
//            sendData = [sendData stringByAppendingString:@"&category="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", categorySelected]];
//            
//            sendData = [sendData stringByAppendingString:@"&videoname="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", _videoName.text]];
//            
//      
//            
//            sendData = [sendData stringByAppendingString:@"&mode="];
//            sendData = [sendData stringByAppendingString: [[NSUserDefaults standardUserDefaults] objectForKey:@"langId"]];
//            
//            sendData = [sendData stringByAppendingString:@"&pushmode="];
//            sendData = [sendData stringByAppendingString: PUSHTYPE];
//            
//            DebugLog(@"data:%@",sendData);
//            
//            
//            sendData = [sendData stringByAppendingString:@"&video="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedVidString]];
//            
//            sendData = [sendData stringByAppendingString:@"&videoimage="];
//            sendData = [sendData stringByAppendingString:[NSString stringWithFormat:@"%@", encodedImgString]];
//            
//            [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//            
//           // NSString *boundary = [self generateBoundaryString];
//            
//          //  [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//      
//           // [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            
//            NSMutableData *theBodyData = [NSMutableData data];
//            
//            theBodyData = [[sendData dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
//            
//           // [request setHTTPBody:theBodyData];
//            
//            //  self.session = [NSURLSession sharedSession];  // use sharedSession or create your own
//            
//            session =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//            
//            NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:theBodyData  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                
//                [_uploadBtn setUserInteractionEnabled:YES];
//                
//                
//                if (error) {
//                    NSLog(@"error = %@", error);
//                    
//                          [SVProgressHUD showInfoWithStatus:@"some error occured"];
//                    return;
//                }
//                
//                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
//                    NSError *jsonError;
//                    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
//                    
//                    
//                    
//                    if (jsonError) {
//                        // Error Parsing JSON
//                        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                        
//                        [SVProgressHUD showInfoWithStatus:@"some error occured"];
//                        
//                        NSLog(@"response = %@ %@",responseString,jsonError.description);
//                    } else {
//                        // Success Parsing JSON
//                        // Log NSDictionary response:
//                        NSLog(@"result = %@",jsonResponse);
//            
//                            if ([[jsonResponse objectForKey:@"status"]boolValue]) {
//                                
//                                
//                                
//                                [SVProgressHUD showInfoWithStatus:@"Video uploaded Successfully"];
//                                
//                                 [self loadProfile];
//                                
//                             //   [self performSelector:@selector(loadProfile) withObject:nil afterDelay:3.0];
//                                
//                              //  [[NSNotificationCenter defaultCenter]
//                               //  postNotificationName:@"videoLoaded"
//                              //   object:self];
//                                
//                                
//                                
//                            }
//                        
//                            else{
//                                
//                                [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
//                                
//                                
//                                
//                          ;
//                            }
//                        
//                    }
//                    
//                    
//                }
//                
//                
//            }];
//            
//            
//            [task resume];
//            
//          //  [self loadProfile];
//            
//            
//            
//            
//        }
//        
//        else
//            
//        {
//            
//            [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
//            
//            
//            
//        }
//        
// 
//    
//    
//    
//}

-(void)loadProfile
{
    
     [_loadingView setHidden:YES];
    JMHomeViewController *VC=[self.storyboard instantiateViewControllerWithIdentifier:@"JMHomeViewController"];
    
    
    [self.navigationController pushViewController:VC animated:kCAMediaTimingFunctionEaseIn];
}

-(void)loadData
{
    
        [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
      //  [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@Signup/fetchlanguage?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                
                [_gifImage setHidden:YES];
                [_noVideoView setHidden:NO];
                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                [_loaderBtn setHidden:NO];
                
               // [_langBtn setUserInteractionEnabled:YES];
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
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
//                    [SVProgressHUD showInfoWithStatus:@"some error occured 3"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        
                        langArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                                             
                        if (langArr.count>0) {
                            [_langBtn setUserInteractionEnabled:YES];
                        }
                        else{
                            
                            [_langBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                           [self loadCategory];
                        
                        
                    }
                    
                    
                    else{
                        
//                        if (langArr.count==0) {
//                            
//                            [SVProgressHUD dismiss];
//                        }
//                        else{
//                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
//                        }
//                        
                        
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
         
            
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        //[SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
}

-(void)loadCategory
{
    
         [_loaderView setHidden:NO];
    
    if([self networkAvailable])
    {
        
        
        
       // [SVProgressHUD show];
        
        
        
        NSString *url;
        
        
        url=[NSString stringWithFormat:@"%@%@video/category?mode=%@",GLOBALAPI,INDEX,[[NSUserDefaults standardUserDefaults] objectForKey:@"langmode"]];
        
        
        
        NSLog(@"Url String..%@",url);
        
        
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        
        [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            //
            //        NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"error = %@", error);
                
                [_gifImage setHidden:YES];
                [_noVideoView setHidden:NO];
                  [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                [_loaderBtn setHidden:NO];
                
               // [_langBtn setUserInteractionEnabled:YES];
                return;
            }
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                
                
                
                
                
              //  [_langBtn setUserInteractionEnabled:YES];
                
                if (jsonError) {
                    // Error Parsing JSON
                    
                    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"response = %@",responseString);
                    
                    [_gifImage setHidden:YES];
                    [_noVideoView setHidden:NO];
                      [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Some error occured", nil),AMLocalizedString(@"Click to retry", nil)]];
                    [_loaderBtn setHidden:NO];
                    
                   // [SVProgressHUD showInfoWithStatus:@"some error occured 1"];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    NSLog(@"result = %@",jsonResponse);
                    if ([[jsonResponse objectForKey:@"status"]boolValue]) {
                        
                        
                        
                        categoryArr=[[jsonResponse objectForKey:@"details"] copy];
                        
                        //totalCount=(int)categoryArr.count;
                        
                            [_categoryBtn setUserInteractionEnabled:YES];
                        
                       // [SVProgressHUD dismiss];
                        
                                       [_loaderView setHidden:YES];
                        
                        
                        
                        if (categoryArr.count>0) {
                            
                            [_langBtn setUserInteractionEnabled:YES];
                            //[_languagePicker reloadAllComponents];
                        }
                        else{
                            
                            [_langBtn setUserInteractionEnabled:NO];
                            
                            
                        }
                        
                        
                    }
                    
                    
                    else{
                        
//                        if (categoryArr.count==0) {
//                            
//                            [SVProgressHUD dismiss];
//                        }
//                        else{
//                            [SVProgressHUD showInfoWithStatus:[jsonResponse objectForKey:@"message"]];
//                        }
                        
                        [_gifImage setHidden:YES];
                        [_noVideoView setHidden:NO];
                        [_noVideoLbl setText:[NSString stringWithFormat:@"%@\n\n %@",[jsonResponse objectForKey:@"message"],AMLocalizedString(@"Click to retry", nil)]];
                        [_loaderBtn setHidden:NO];
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
        }]resume ];
        
        
        
        
        
    }
    
    else{
        
        
        [_gifImage setHidden:YES];
        [_noVideoView setHidden:NO];
        [_noVideoLbl setText:[NSString stringWithFormat:@"%@. \n\n %@",AMLocalizedString(@"Check your Internet connection", nil),AMLocalizedString(@"Click to retry", nil)]];
        [_loaderBtn setHidden:NO];
        
       // [SVProgressHUD showImage:[UIImage imageNamed:@"nowifi"] status:@"Check your Internet connection"] ;
        
        
    }
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//   didSendBodyData:(int64_t)bytesSent
//    totalBytesSent:(int64_t)totalBytesSent
//totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
//{
//    
//        DebugLog(@"%f",(float)totalBytesSent);
//        DebugLog(@"%f",(float)totalBytesExpectedToSend);
//    
//    DebugLog(@"%f",(float)((float)totalBytesSent/(float)totalBytesExpectedToSend));
//    
//    //[SVProgressHUD showProgress:(float)((float)totalBytesSent/(float)totalBytesExpectedToSend)];
//    
//    [_loadingLbl setText:[NSString stringWithFormat:@"%.f%@",((float)((float)totalBytesSent/(float)totalBytesExpectedToSend))*100,@"%"]];
//}



- (IBAction)cancelVidClicked:(id)sender {
    
    [_optionView setHidden:NO];
    videoPicked=false;
    videoData=nil;
    imageData=nil;
    [_cancelView setHidden:YES];
    
    
}
@end
