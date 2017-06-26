//
//  UrlconnectionObject.m
//  QuickFindNew
//
//  Created by Prosenjit Kolay on 30/04/15.
//  Copyright (c) 2015 anirban. All rights reserved.
//

#import "UrlconnectionObject.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

@implementation UrlconnectionObject
@synthesize JsonBlock;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    
   
}
-(void)global:(NSString *)parameter typerequest:(NSString *)type withblock:(JsonBlock)responce
{
 //NSLog(@"url parameter=%@",parameter);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",parameter]]];
    request.timeoutInterval = 20.0;
    // Create url connection and fire request
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    typerequestobj = type;
    conn = nil;

    responceobj = [responce copy];
    
    
}
-(void)globalImage:(NSString *)parameter ImageString:(NSString *)encodedString ImageField:(NSString *)FieldName typerequest:(NSString *)type withblock:(JsonBlock)responce
{
    //  NSLog(@"url request=%@",request);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:parameter]];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:100];
    
    
    
    if (![encodedString isKindOfClass:[NSNull class]]&&encodedString.length>0&&![encodedString isEqualToString:@"nil"])
    {
       // NSLog(@"image data > 0");
        params = [[NSString alloc] initWithFormat:@"%@=%@",FieldName,[encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"]];
        
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        
    }
 
    // Create url connection and fire request
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    typerequestobj = type;
    conn = nil;
    
    responceobj = [responce copy];
}
-(void)globalPost:(NSMutableURLRequest *)request typerequest:(NSString *)type withblock:(JsonBlock)responce
{
  //  NSLog(@"url request=%@",request);
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    typerequestobj = type;
    conn = nil;
    
    responceobj = [responce copy];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *error = nil;
 //   NSLog(@"response data=%@",_responseData);
   //
    
    if ([typerequestobj isEqualToString:@"string"])
    {
       result = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    }
    else
    {
        result = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
 //   NSLog(@"urlconnection result=%@",result);
  
    }
    
  //
    responceobj(result,nil,YES);
   
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
   
    result=nil;
    NSLog(@"Did Fail");
    
    NSLog(@" Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    responceobj(result,nil,YES);
    
}
- (BOOL)connectedToNetwork
{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
-(void)getSessionJsonResponse : (NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure
{
   
    
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSLog(@"access_token %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]);
    [request setHTTPMethod:@"POST"];
    
    NSData *postData;
    if (postParam != nil)
    {
        if ([postParam isKindOfClass:[NSString class]])
        {
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postParam length]];
            postData=[postParam dataUsingEncoding:NSUTF8StringEncoding];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        }
        else
        {
            postData = [NSJSONSerialization dataWithJSONObject:postParam options:0 error:&error];
            
           
        }
    }
    
    
    
    [request setHTTPBody:postData];
    
    
    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    self.connectionSession = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      if ([type isEqualToString:@"string"])
                                      {
                                          result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                        //  NSLog(@"session returned data-%@",result);
                                      }
                                      else
                                      {
                                          result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                        //  NSLog(@"session returned data-%@",result);
                                          
                                          
                                      }
                                      
                                      
                                      success(result);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume] ;
}
-(void)getSessionJsonResponse :(NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
     [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    
   self.connectionSession = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                                  {
                                                      if (error==nil && data !=nil)
                                                      {
                                                          self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                                          
                                                          NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        //  NSLog(@"session returned data-%@",json);
                                                          
                                                          success(json);
                                                      }
                                                      else
                                                          failure(error);
                                                        
                                                    }];
    
    [self.connectionSession resume];
}
-(void)getSessionJsonResponseWithUploadImage :(NSString *)urlStr Image :(NSString *)PostString success : (void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure
{
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [PostString dataUsingEncoding:NSUTF8StringEncoding]];
  //  [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    
    self.connectionSession = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      NSString *Str= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      
                                      NSLog(@"strrrrr--%@ %@",Str, response);
                                      
                                      NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                      //  NSLog(@"session returned data-%@",json);
                                      
                                      success(json);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume];
}
-(void)getImageSessionJsonResponse :(NSString *)urlStr success : (void (^)(NSData *response))success failure:(void(^)(NSError* error))failure
{
   
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
//    NSString *contentType = [NSString stringWithFormat:@"application/octet-stream"];
//     NSString *ContentDisposition = [NSString stringWithFormat:@"attachment;filename=%@",filename];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
//    [request setValue:@"47116" forHTTPHeaderField:@"Content-Length"];
//    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
//    [request setValue:ContentDisposition forHTTPHeaderField:@"Content-Disposition"];
//    [request setValue:@"Microsoft-HTTPAPI/2.0" forHTTPHeaderField:@"Server"];
//    [request setValue:filename forHTTPHeaderField:@"x-filename"];
//    [request setValue:@"Sun,11 Sep 2016 18:09:39 GMT" forHTTPHeaderField:@"Date"];
    
    self.connectionSession = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      NSLog(@"data %@",data);
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        NSLog(@"session returned data-%@",json);
                                      
                                      success(data);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume];
}
-(void)deleteSessionJsonResponse :(NSString *)urlStr typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    
    self.connectionSession = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      if ([type isEqualToString:@"string"])
                                      {
                                          result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                        //  NSLog(@"session returned data-%@",result);
                                      }
                                      else
                                      {
                                          result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                        //  NSLog(@"session returned data-%@",result);
                                          
                                          
                                      }
                                      
                                      success(result);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume];
}

-(void)getData:(NSString *)parameter
{
    
        NSURL *theURL = [NSURL URLWithString:parameter];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL      cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
        //Specify method of request(Get or Post)
        [theRequest setHTTPMethod:@"GET"];
        
        //Pass some default parameter(like content-type etc.)
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        
        //Now pass your own parameter
        
        [theRequest setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
        
        NSURLResponse *theResponse = nil;
        NSError *theError = nil;
        NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    
        self.statusCode = [(NSHTTPURLResponse*)theResponse statusCode];
    
        if (theResponseData!=nil)
        {
                 _json = [NSJSONSerialization JSONObjectWithData:theResponseData options:kNilOptions error:nil];
            
        }
    
    
    
}

-(void)AddTaskgetSessionJsonResponse : (NSString *)urlStr withPostData:(id)json typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure
{

    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[json count]];
    
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSLog(@"access_token %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]);
    [request setHTTPMethod:@"POST"];
    
    NSData *postData;

    
    NSLog(@"Post Data for Add Task:%@",json);
    
    postData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
    self.connectionSession = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      if ([type isEqualToString:@"string"])
                                      {
                                          result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                          //  NSLog(@"session returned data-%@",result);
                                      }
                                      else
                                      {
                                          result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                          //  NSLog(@"session returned data-%@",result);
                                          
                                          
                                      }
                                      
                                      
                                      success(result);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume] ;
}


-(void)getSessionJsonResponseParentWithoutAccesToken : (NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure
{
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postParam length]];
    
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSLog(@"Device Token %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]);
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:[NSString stringWithFormat:@"1_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]] forHTTPHeaderField:@"clientid"];
    
    NSData *postData;
    if (postParam != nil)
    {
        if ([postParam isKindOfClass:[NSString class]])
        {
            postData=[postParam dataUsingEncoding:NSUTF8StringEncoding];
        }
        else
        {
            postData = [NSJSONSerialization dataWithJSONObject:postParam options:0 error:&error];
        }
    }
    
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    

    self.connectionSession = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      if ([type isEqualToString:@"string"])
                                      {
                                          result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                          //  NSLog(@"session returned data-%@",result);
                                      }
                                      else
                                      {
                                          result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                          //  NSLog(@"session returned data-%@",result);
                                          
                                          
                                      }
                                      
                                      
                                      success(result);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume] ;
}


-(void)getSessionJsonResponseStudentWithoutAccesToken : (NSString *)urlStr withPostData:(id)postParam typerequest:(NSString *)type success : (void (^)(id responseDict))success failure:(void(^)(NSError* error))failure
{
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postParam length]];
    
    NSError *error;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    NSLog(@"Device Token %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]);
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:[NSString stringWithFormat:@"2_%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]] forHTTPHeaderField:@"clientid"];
    
    NSData *postData;
    if (postParam != nil)
    {
        if ([postParam isKindOfClass:[NSString class]])
        {
            postData=[postParam dataUsingEncoding:NSUTF8StringEncoding];
        }
        else
        {
            postData = [NSJSONSerialization dataWithJSONObject:postParam options:0 error:&error];
        }
    }
    
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    
    self.connectionSession = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                              {
                                  if (error==nil && data !=nil)
                                  {
                                      self.statusCode = [(NSHTTPURLResponse*)response statusCode];
                                      
                                      if ([type isEqualToString:@"string"])
                                      {
                                          result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                          //  NSLog(@"session returned data-%@",result);
                                      }
                                      else
                                      {
                                          result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                          //  NSLog(@"session returned data-%@",result);
                                          
                                          
                                      }
                                      
                                      
                                      success(result);
                                  }
                                  else
                                      failure(error);
                                  
                              }];
    
    [self.connectionSession resume] ;
}



@end
