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
@interface JMUploadVideoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate>
{
    UIImagePickerController *ipc;
    
    UIImage *selectedImage;
    int rowSelected;
    bool langPickerOpen,catPickerOpen;
        NSMutableArray *langArr,*codeArr,*categoryArr;
    NSData *videoData;
}
@end

@implementation JMUploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
            [self setRoundCornertoView:_optionView withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
                [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    
    
    categoryArr=[[NSMutableArray alloc] initWithObjects:@"LATEST",@"SEXUAL",@"ANIMAL",@"DOCTOR",@"GIRLFRIEND",@"STUPID", nil];
    
    langArr=[[NSMutableArray alloc] initWithObjects:@"English",@"Hebrew",@"Hindi",@"Chinese",@"Spanish", nil];
    
    codeArr=[[NSMutableArray alloc] initWithObjects:@"en",@"he",@"hi",@"zh",@"es", nil];
    
     [_languagePicker setDelegate:self];
    
    
    [_jokeLang setFont:[UIFont fontWithName:_jokeLang.font.fontName size:[self getFontSize:_jokeLang.font.pointSize]]];
    [_categoryLbl setFont:[UIFont fontWithName:_categoryLbl.font.fontName size:[self getFontSize:_categoryLbl.font.pointSize]]];
[_cancelLabl setFont:[UIFont fontWithName:_cancelLabl.font.fontName size:[self getFontSize:_cancelLabl.font.pointSize]]];
   [_warningLbl setFont:[UIFont fontWithName:_warningLbl.font.fontName size:[self getFontSize:_warningLbl.font.pointSize]]];
      [_okLbl setFont:[UIFont fontWithName:_okLbl.font.fontName size:[self getFontSize:_okLbl.font.pointSize]]];
      [_cancelLabl setFont:[UIFont fontWithName:_cancelLabl.font.fontName size:[self getFontSize:_cancelLabl.font.pointSize]]];
    
          [_tapInfo setFont:[UIFont fontWithName:_tapInfo.font.fontName size:[self getFontSize:_tapInfo.font.pointSize]]];
    
      [_cameraLbl setFont:[UIFont fontWithName:_cameraLbl.font.fontName size:[self getFontSize:_cameraLbl.font.pointSize]]];
    
      [_galleryLbl setFont:[UIFont fontWithName:_galleryLbl.font.fontName size:[self getFontSize:_galleryLbl.font.pointSize]]];
    // Do any additional setup after loading the view.
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
                                                   ipc.videoMaximumDuration = 180;
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
                                            ipc.videoMaximumDuration = 180;
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
                NSURL *urlvideo = [info objectForKey:UIImagePickerControllerMediaURL];
                
                videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[urlvideo path]]];
                
                
                
                
                
                AVURLAsset *asset=[[AVURLAsset alloc] initWithURL:urlvideo options:nil];
                AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
                generator.appliesPreferredTrackTransform=TRUE;
                
                CMTime thumbTime = CMTimeMakeWithSeconds(0,30);
                
                AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
                    if (result != AVAssetImageGeneratorSucceeded) {
                        DebugLog(@"couldn't generate thumbnail, error:%@", error);
                        
                        
                        
                        // [SVProgressHUD showInfoWithStatus:@"Something went wrong"];
                        
                    }
                    
                    NSData* imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:im]);
                    
                    if ( imageData!=nil )
                    {
                        // selectedImage=[UIImage imageWithCGImage:im];
                        
                        [_videoThumb setImage:[UIImage imageWithCGImage:im]];
                        
                        
                        _videoThumb.contentMode = UIViewContentModeScaleAspectFill;
                        _videoThumb.clipsToBounds = YES;
                        
                        
                        [_optionView setHidden:YES];
                        
                        
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
        
        DebugLog(@"%@",[codeArr objectAtIndex:rowSelected]);
    }
    else if (catPickerOpen) {
    
        [_categoryLbl setText:[categoryArr objectAtIndex:rowSelected]];
        
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
            [pickerLabel setText:[categoryArr objectAtIndex:row]];
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
        return [categoryArr objectAtIndex:row];
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
}
- (IBAction)crossClicked:(id)sender {
          [_warningView setHidden:YES];
}
@end
