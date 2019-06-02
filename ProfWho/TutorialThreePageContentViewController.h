//
//  TutorialThreePageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//


#import "TutorialPageContentViewController.h"
#import "TutorialRootViewController.h"

@class TutorialRootViewController;

@interface TutorialThreePageContentViewController : TutorialPageContentViewController

@property (weak, nonatomic) IBOutlet UIImageView *tutorialThreePhoneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tutorialThreeBluetoothImageView;
@property (weak, nonatomic) IBOutlet UILabel *tutorialThreeBluetoothText;
@property (weak, nonatomic) IBOutlet UILabel *tutorialThreeText;

@property (nonatomic) TutorialRootViewController *tutorialRootViewController;


@end
