//
//  AboutPageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ViewController.h"
#import "UITagTapGestureRecognizer.h"
#import "UIAboutLabel.h"
#import "UIAboutView.h"
#import "RestAPITest.h"
#import "DashboardRootViewController.h"


@interface AboutPageContentViewController : ViewController


@property (nonatomic)   NSArray *aboutArray;
@property (nonatomic) NSDictionary *aboutDictionary;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (nonatomic) DashboardRootViewController *dashboardViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (void) loadAboutDetailsWithDictionary: (NSArray *) profAboutDictionary;


@end
