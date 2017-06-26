//
//  UrlconnectionObject.h
//  QuickFindNew
//
//  Created by Prosenjit Kolay on 30/04/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "globalprotocol.h"


@interface UrlconnectionObject : NSObject<NSURLConnectionDelegate,NSURLSessionDelegate>
{
NSMutableData *_responseData;
NSURLConnection *conn;
    JsonBlock responceobj;
    NSString *typerequestobj,*params;
    id result;
}

@property (copy) id (^JsonBlock)(void);
@property (weak,nonatomic) id json;
@property (readwrite) NSInteger statusCode;


// post api without access_token

-(void)getSessionJsonResponseParentWithoutAccesToken : (NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure;

-(void)getSessionJsonResponseStudentWithoutAccesToken : (NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure;



// post api method
-(void)getSessionJsonResponse :(NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure;

// post api method (parameter sent in dictionary format)
-(void)AddTaskgetSessionJsonResponse :(NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure;

// get api method
-(void)getSessionJsonResponse :(NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;

// delete api method
-(void)deleteSessionJsonResponse :(NSString *)urlStr typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure;

-(void)getSessionJsonResponseWithUploadImage :(NSString *)urlStr Image :(NSString *)PostString success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure;

-(void)getImageSessionJsonResponse :(NSString *)urlStr success : (void (^)(NSData *response))success failure:(void(^)(NSError* error))failure;

@property (retain,nonatomic)NSURLSessionDataTask *connectionSession;


// api with NSURLConnection delegate---deprecated----
-(void)global:(NSString *)parameter typerequest:(NSString *)type withblock:(JsonBlock)responce;
- (BOOL)connectedToNetwork;
-(void)globalPost:(NSMutableURLRequest *)request typerequest:(NSString *)type withblock:(JsonBlock)responce;
-(void)globalImage:(NSString *)parameter ImageString:(NSString *)encodedString ImageField:(NSString *)FieldName typerequest:(NSString *)type withblock:(JsonBlock)responce;


-(void)getData:(NSString *)parameter;

@end
