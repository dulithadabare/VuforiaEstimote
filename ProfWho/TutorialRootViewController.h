//
//  TutorialRootViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialOnePageContentViewController.h"
#import "TutorialTwoPageContentViewController.h"
#import "TutorialThreePageContentViewController.h"
#import "TutorialFourPageContentViewController.h"

@interface TutorialRootViewController : UIViewController <UIPageViewControllerDataSource>



@property (strong, nonatomic) UIPageViewController *tutorialPageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

- (void) callMenuChildView;


@end
