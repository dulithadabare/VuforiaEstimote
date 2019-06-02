//
//  RestAPITest.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/15/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AboutPageContentViewController;
@class ProfilePageContentViewController;
@class ImagesPageContentViewController;
@class VideosPageContentViewController;
@class BeaconViewController;

@interface RestAPITest : NSObject

@property (nonatomic) NSDictionary *profAboutDictionary ;


- (void)         printProfessorData : (NSString *) profId;
- (NSDictionary *)    getDetailsFor : (NSString *) profileId ofProfileType: (NSString *) profileType profileViewController: (ProfilePageContentViewController*) profileVC aboutViewController: (AboutPageContentViewController*) aboutVC imagesViewController: (ImagesPageContentViewController*) imagesVC videosViewController: (VideosPageContentViewController*) videosVC;

- (void) getAssignedBeaconsFor: (BeaconViewController *) beaconsViewController;



@end
