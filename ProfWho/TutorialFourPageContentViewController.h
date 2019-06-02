//
//  TutorialFourPageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "TutorialPageContentViewController.h"
#import "TutorialRootViewController.h"

@class TutorialRootViewController;

@interface TutorialFourPageContentViewController : TutorialPageContentViewController

@property (weak, nonatomic) IBOutlet UIImageView *tutorialFourImageView;
@property (weak, nonatomic) IBOutlet UILabel *tutorialFourSignalText;

@property (weak, nonatomic) IBOutlet UILabel *tutorialFourTapText;

@property (nonatomic) TutorialRootViewController *tutorialRootViewController;

@end
