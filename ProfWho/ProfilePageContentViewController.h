//
//  ProfilePageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ViewController.h"
#import "DashboardRootViewController.h"

@interface ProfilePageContentViewController : ViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *profName;
@property (weak, nonatomic) IBOutlet UILabel *profTitle;
@property (weak, nonatomic) IBOutlet UILabel *profEmail;
@property (weak, nonatomic) IBOutlet UILabel *profPhone;
@property (weak, nonatomic) IBOutlet UILabel *profRoom;
@property (weak, nonatomic) IBOutlet UILabel *profURL;

@property (nonatomic) DashboardRootViewController *dashboardViewController;

- (void) loadProfileDetailsWithArray: (NSArray *) profDetailsArray withContactsArray : (NSArray *) profContactArray;
- (void) loadLabDetailsWithArray: (NSArray *) labDetailsArray withContactsArray : (NSArray *) labContactArray;
- (void) loadPosterDetailsWithArray: (NSArray *) posterDetailsArray withContactsArray : (NSArray *) posterContactArray;

@end
