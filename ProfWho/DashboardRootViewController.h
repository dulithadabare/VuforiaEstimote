//
//  DashboardRootViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ViewController.h"
#import "RKSwipeBetweenViewControllers.h"

@class AboutPageContentViewController;
@class ProfilePageContentViewController;
@class ImagesPageContentViewController;
@class VideosPageContentViewController;

@interface DashboardRootViewController : ViewController

@property (strong,nonatomic) UIImage *profilePicImage;
@property (nonatomic) BOOL profilePicFlag;
@property (strong,nonatomic) NSDictionary *profileData;

@property ProfilePageContentViewController * profilePageInstance;
@property AboutPageContentViewController * aboutPageInstance;
@property ImagesPageContentViewController * imagesPageInstance;
@property VideosPageContentViewController * videosPageInstance;

- (void) callMenuChildView;

@end
