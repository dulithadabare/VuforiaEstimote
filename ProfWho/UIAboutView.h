//
//  UIAboutView.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/22/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAboutLabel.h"

@interface UIAboutView : UIView

@property (nonatomic)   UIView *aboutView;

@property (weak, nonatomic) IBOutlet UILabel *aboutTitle;
//@property (weak, nonatomic) IBOutlet UILabel *aboutText;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic) BOOL readMoreCliked;
@property (nonatomic) NSArray *aboutTextArray;
@property (nonatomic) CGFloat yOffset;
@property (nonatomic) CGFloat prevAboutTextViewHeight;
@property (nonatomic) UIView *aboutContentView;
@property (nonatomic) UIScrollView *scrollView;


- (void) resizeAboutContentView;

@end
