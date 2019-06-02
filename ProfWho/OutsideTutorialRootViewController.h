//
//  OutsideTutorialRootViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/13/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutsideTutorialOnePageContentViewController.h"
#import "OutsideTutorialTwoPageContentViewController.h"
#import "OutsideTutorialThreePageContentViewController.h"

@interface OutsideTutorialRootViewController : UIViewController <UIPageViewControllerDataSource>



@property (strong, nonatomic) UIPageViewController *outsideTutorialPageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


@end
