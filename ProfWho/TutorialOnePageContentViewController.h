//
//  TutorialOnePageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/7/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "TutorialPageContentViewController.h"
#import "TutorialRootViewController.h"

@class TutorialRootViewController;

@interface TutorialOnePageContentViewController : TutorialPageContentViewController

@property (weak, nonatomic) IBOutlet UIImageView *tutorialOneImageView;


@property (weak, nonatomic) IBOutlet UILabel *tutorialOneText;
@property (nonatomic) TutorialRootViewController *tutorialRootViewController;





@end
