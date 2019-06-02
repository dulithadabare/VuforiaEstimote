//
//  ImageViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/11/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIScrollViewDelegate>

@property(nonatomic, strong) NSDictionary *selectedImageData;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
