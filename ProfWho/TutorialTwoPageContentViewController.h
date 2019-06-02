//
//  TutorialTwoPageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//


#import "TutorialPageContentViewController.h"
#import "TutorialRootViewController.h"

@class TutorialRootViewController;

@interface TutorialTwoPageContentViewController : TutorialPageContentViewController

@property (weak, nonatomic) IBOutlet UIImageView *tutorialTwoImageView;

@property (weak, nonatomic) IBOutlet UILabel *tutorialTwoScanText;
@property (weak, nonatomic) IBOutlet UILabel *tutorialTwoBluetoothText;

@property (nonatomic) TutorialRootViewController *tutorialRootViewController;


@end
