//
//  RestAPITest.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/15/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "RestAPITest.h"
#import "AboutPageContentViewController.h"
#import "ProfilePageContentViewController.h"
#import "ImagesPageContentViewController.h"
#import "VideosPageContentViewController.h"
#import "BeaconViewController.h"

@interface RestAPITest ()

@property NSString *apiURL;
@property(nonatomic, getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;

@end


@implementation RestAPITest


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiURL = @"http://www.prof-who.com/api/v1/android/";
    }
    return self;
}
- (void) printProfessorData : (NSString *) profId {
    
    NSString * restURL = [NSString stringWithFormat:@"http://www.prof-who.com/api/v1/dashboard/profile-about/%@/type/PROFESSOR", profId];
    
    NSURL *url = [NSURL URLWithString:restURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    @try {
        NSURLSessionDataTask *task =  [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data.length > 0 && error == nil)
            {
                NSDictionary *profData = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:NULL];
                
                NSDictionary *profProfileData = [profData valueForKeyPath:@"profile"];
                NSString * profName = [profProfileData objectForKey:@"name"];
                NSLog(@"The professor name is %@", profName);
                //  self.greetingContent.text = [greeting objectForKey:@"content"];
            }
        }];
        
        [task resume];
    }
    @catch (NSException *exception) {
        NSLog(@"The NSURLSession exception is %@", exception.reason);
    }
    
    
  

  
}

-(NSDictionary *)getDetailsFor:(NSString *)profileId ofProfileType:(NSString *)profileType profileViewController:(ProfilePageContentViewController *)profileVC aboutViewController:(AboutPageContentViewController *)aboutVC imagesViewController:(ImagesPageContentViewController *)imagesVC videosViewController:(VideosPageContentViewController *)videosVC{
    
  
        
        
//        NSString * restURL = [NSString stringWithFormat:@"http://www.prof-who.com/api/v1/android/%@/%@",profileType, profileId];
    
    NSString *apiType = [NSString stringWithFormat:@"%@/%@",profileType, profileId];
    
    NSString *restURL = [self.apiURL stringByAppendingString:apiType];
    
    
        
        
        
        NSURL *url = [NSURL URLWithString:restURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLSession *urlSession = [NSURLSession sharedSession];
        // NSArray *aboutArray = [[NSArray alloc] init];
        
        @try {
//            self.networkActivityIndicatorVisible = YES;
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            
            NSURLSessionDataTask *task =  [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data.length > 0 && error == nil)
                {
//                    self.networkActivityIndicatorVisible = NO;
                    NSDictionary *profData = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                    NSArray *aboutArray = [profData valueForKeyPath:@"about"];
                    NSArray *profileArray = [profData valueForKeyPath:@"profile"];
                    NSArray *contactArray = [profData valueForKeyPath:@"contact"];
                    NSArray *imagesArray = [profData valueForKeyPath:@"images"];
                    NSArray *videosArray = [profData valueForKeyPath:@"videos"];
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    
                    
                    //   [self setProfAboutDictionary:testDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [aboutVC loadAboutDetailsWithDictionary:aboutArray];
                        [profileVC loadProfileDetailsWithArray:profileArray withContactsArray:contactArray];
//                        [imagesVC loadImagesWithArray:imagesArray];
                        [videosVC loadVideosWithArray:videosArray];
                        
                        if ([[NSThread currentThread] isMainThread]){
                            NSLog(@"In main thread--completion handler");
                        }
                        else{
                            NSLog(@"Not in main thread--completion handler");
                        }
                    });
                    
                    //beacause the images need to be loaded
                    
                    [imagesVC loadImagesWithArray:imagesArray];
                    
                    //  NSString * profName = [profProfileData objectForKey:@"name"];
                    //  NSLog(@"The professor name is %@", profName);
                    
                    //  self.greetingContent.text = [greeting objectForKey:@"content"];
                }
            }];
            
            [task resume];
            
            return [self profAboutDictionary];
        }
        @catch (NSException *exception) {
            NSLog(@"The NSURLSession exception is %@", exception.reason);
        }
    
    
}

-(void)getAssignedBeaconsFor:(BeaconViewController *)beaconsViewController{
    
//    NSString * restURL = [NSString stringWithFormat:@"http://www.prof-who.com/api/v1/android/beacon"];
    
    NSString *apiType = @"beacon";
    
    NSString *restURL = [self.apiURL stringByAppendingString:apiType];
    
    
    
    NSURL *url = [NSURL URLWithString:restURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    
    @try {
        NSURLSessionDataTask *task =  [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data.length > 0 && error == nil)
            {
                NSDictionary *beaconDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:NULL];
                
                NSArray *beaconArray = [beaconDictionary valueForKeyPath:@"beacons"];
                
        
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [beaconsViewController setDownloadedBeaconArray:beaconArray];
                    if ([[NSThread currentThread] isMainThread]){
                        NSLog(@"In main thread--completion handler");
                    }
                    else{
                        NSLog(@"Not in main thread--completion handler");
                    }
                });
             
            }
        }];
        
        [task resume];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"The NSURLSession exception is %@", exception.reason);
    }

    
}

@end
