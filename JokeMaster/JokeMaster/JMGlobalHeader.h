//
//  JMGlobalHeader.h
//  JokeMaster
//
//  Created by santanu on 02/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#ifndef JMGlobalHeader_h
#define JMGlobalHeader_h


#define  IsIphone5 (([[UIScreen mainScreen] bounds].size.height)==568)?true:false
#define  IsIphone6 (([[UIScreen mainScreen] bounds].size.height)==667)?true:false
#define  IsIphone6plus (([[UIScreen mainScreen] bounds].size.height)==736)?true:false
#define  IsIphone4 (([[UIScreen mainScreen] bounds].size.height)==480)?true:false
#define  IsIpad (([[UIScreen mainScreen] bounds].size.height)>736)?true:false

#define  FULLHEIGHT (float)[[UIScreen mainScreen] bounds].size.height
#define  FULLWIDTH  (float)[[UIScreen mainScreen] bounds].size.width

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#define IPHONE   UIUserInterfaceIdiomPhone
//Color
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//Font


#define ComicFont @"comicbd_1"
#define ComicItalic @"Comic_Book"


//key
#define UDUSERID @"userid"
#define UDUSERNAME @"userName"
#define DEVICETOKEN @"deviceToken"
#define ISLOGGED @"isLogged"
#define PUSHTYPE @"1" //1 for dev 2 for dis
//size
#define LandingHeaderHeight 100.0f
#define OtherHeaderHeight 45.0f
#define StatusBarHeight (float)[[UIApplication sharedApplication]statusBarFrame].size.height

//url API
#define THEMECOLOUR [UIColor colorWithRed:102.0/255.0 green:197.0/255.0  blue:187.0/255.0 alpha:1]

//#define GLOBALAPI @"http://esolz.co.in/lab6/internal_development_vol_2/"
#define GLOBALAPI @"http://ec2-13-58-196-4.us-east-2.compute.amazonaws.com/jokemaster/"

#define GLOBALAPIDEV @"http://esolz.co.in/lab6/internal_development_vol_2/"

#define INDEX @"index.php/"
#define LOGIN @"Login_ios"
#define SIGNUP @"Signup_ios"
#define USERINFO @"app_userinfo_all"
#define USERLOGIN @"app_login_all"
#define USERGLOGIN @"app_google_login"
#define POSTLIST @"postlisting_cntrlt_ios"
#define USERPOST @"userpost_cntrlr_ios"
#define POSTCOMMENT @"post_comment_ios"
#define USERFAV @"user_favourite_ios"
#define NOTIFICATION @"notification"
#define USERDETAILS @"user_details_ios"
#define WEBSRVC @"web_servc_cntrlr"
#define TICKETLIST @"project_ticket_list"
#define PLANNINGDLT @"planning_task_delete"
#define ADDTICKET @"project_add_ticket"
#define ADDCOMM @"project_post_comment"
#define TCKTADDCOMM @"ticket_add_comment"
//Log
#ifdef DEBUG

#define DebugLog(...) NSLog(__VA_ARGS__)

#else

#define DebugLog(...) while(0)

#endif

//Degree To Radian
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//Extra key
#define ANIMATION_DURATION				0.3f

//font

#define ComicBold @"comicbd_1.ttf"
#define ComicbkITalic @"Comic_Book.ttf"

#endif /* JMGlobalHeader_h */
