
//  ProfilePageContentViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ProfilePageContentViewController.h"
#import "UIColor+ProfWhoColor.h"

@interface ProfilePageContentViewController ()

@property (strong,nonatomic) UIViewController *modal;
@property (weak, nonatomic) IBOutlet UIView *profileContentView;
@property (weak, nonatomic) IBOutlet UIView *notificationView;

@end

@implementation ProfilePageContentViewController
- (IBAction)menu:(id)sender {
    
//    [self.dashboardViewController callMenuChildView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *profilePicImage = [UIImage imageNamed:@"Profile-1"];
    
    [self.profilePic setImage:profilePicImage];
    
    Class parentVCClass = [self.parentViewController class];
    NSString *className = NSStringFromClass(parentVCClass);
    NSLog(@"%@", className);
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 350)];
    
    UIView *mainContentView = [self.view viewWithTag:1];
   
    
      [scroll addSubview:self.profileContentView];
    
    // set the contentSize height to the height of profileContentView after finalizing the auto layout
    scroll.contentSize = CGSizeMake(self.profileContentView.frame.size.width, 500);
    
    [mainContentView addSubview:scroll];
    [self.profileContentView setHidden:YES];
    [self.notificationView setHidden:NO];
    self.notificationView.backgroundColor = [UIColor pwLightGray];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadProfileDetailsWithArray:(NSArray *)profDetailsArray withContactsArray:(NSArray *)profContactArray{
    
    if (profDetailsArray.count != 0) {
        [self.profileContentView setHidden:NO];
        [self.notificationView setHidden:YES];
    }
    
    for (NSDictionary *profDetailsDictionary in profDetailsArray) {
        
        // Check if the values are null to prevent uncaught NSExceptions
        if (profDetailsDictionary[@"name"] != [NSNull null]) {
            [self.profName setText:profDetailsDictionary[@"name"]];
        }
        if (profDetailsDictionary[@"description"] != [NSNull null]) {
            [self.profTitle setText:profDetailsDictionary[@"description"]];
        }
        if (profDetailsDictionary[@"email"] != [NSNull null]) {
            [self.profEmail setText:profDetailsDictionary[@"email"]];
        }
        if (profDetailsDictionary[@"office"] != [NSNull null]) {
            [self.profRoom setText:profDetailsDictionary[@"office"]];
        }
        if (profDetailsDictionary[@"website"] != [NSNull null]) {
            [self.profURL setText:profDetailsDictionary[@"website"]];
        }
        
        if (profDetailsDictionary[@"profile_picture"] != [NSNull null]) {
            NSString * profilePicURL =profDetailsDictionary[@"profile_picture"];
            
            dispatch_async(dispatch_queue_create("com.profwho.test", NULL), ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
               
                    [self.dashboardViewController setProfilePicImage:image];
                    [self.dashboardViewController setProfilePicFlag:YES];
                });
                
                
            });
        }
        
     
        
    }
    
    
    
    //need to improve - add scrollview to accomodate all contact types
    
    for (NSDictionary *contact in profContactArray){
        
        [self.profPhone setText:contact[@"contact_info"]];
    }
    
    
    
    
}

-(void)loadLabDetailsWithArray:(NSArray *)labDetailsArray withContactsArray:(NSArray *)labContactArray{
    
    for (NSDictionary *profDetailsDictionary in labDetailsArray) {
        [self.profName setText:profDetailsDictionary[@"name"]];
        [self.profTitle setText:profDetailsDictionary[@"description"]];
//        [self.profEmail setText:profDetailsDictionary[@"email"]];
        [self.profRoom setText:profDetailsDictionary[@"office"]];
        [self.profURL setText:profDetailsDictionary[@"website"]];
        
        
        NSString * profilePicURL =profDetailsDictionary[@"profile_picture"];
        
        dispatch_async(dispatch_queue_create("com.profwho.test", NULL), ^{
            //        NSURL *url = [NSURL URLWithString:profilePicURL];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [self.profilePic setImage:image];
                [self.dashboardViewController setProfilePicImage:image];
                [self.dashboardViewController setProfilePicFlag:YES];
            });
            
            
        });
        
        
        
        
    }
    
    
    
    //need to improve - add scrollview to accomodate all contact types
    
    for (NSDictionary *contact in labContactArray){
        
        [self.profPhone setText:contact[@"contact_info"]];
    }
    
}

-(void)loadPosterDetailsWithArray:(NSArray *)posterDetailsArray withContactsArray:(NSArray *)posterContactArray{
    
    for (NSDictionary *profDetailsDictionary in posterDetailsArray) {
        [self.profName setText:profDetailsDictionary[@"name"]];
        [self.profTitle setText:profDetailsDictionary[@"description"]];
        //        [self.profEmail setText:profDetailsDictionary[@"email"]];
//        [self.profRoom setText:profDetailsDictionary[@"office"]];
        [self.profURL setText:profDetailsDictionary[@"website"]];
        
        
        NSString * profilePicURL =profDetailsDictionary[@"profile_picture"];
        
        dispatch_async(dispatch_queue_create("com.profwho.test", NULL), ^{
            //        NSURL *url = [NSURL URLWithString:profilePicURL];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [self.profilePic setImage:image];
                [self.dashboardViewController setProfilePicImage:image];
                [self.dashboardViewController setProfilePicFlag:YES];
            });
            
            
        });
        
        
        
        
    }
    
    
    
    //need to improve - add scrollview to accomodate all contact types
    
    for (NSDictionary *contact in posterContactArray){
        
        [self.profPhone setText:contact[@"contact_info"]];
    }
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    //    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    if (self.childViewControllers.count != 0){
        
        [UIView animateWithDuration:0.5 animations:^{
            self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
        } completion:^(BOOL finished) {
            [self.modal.view removeFromSuperview];
            [self.modal removeFromParentViewController];
            self.modal = nil;
        }];
    }
    
}


-(void)dismissChildView:(UIPanGestureRecognizer*)gestureRecognizer {
    [self.view bringSubviewToFront:[gestureRecognizer view]];
    CGPoint translatedPoint = [gestureRecognizer translationInView:[gestureRecognizer view]];
    
    CGFloat firstX;
    CGFloat firstY = 0.0;
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
      
        firstX = self.view.frame.size.width/6;
        firstY = 0.0;
    }
    
    if(translatedPoint.x >0){
        [[gestureRecognizer view] setFrame:CGRectMake((self.view.frame.size.width/6)+translatedPoint.x, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height)];
        
    }
    
    
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = (0.2*[gestureRecognizer velocityInView:self.view].x);
        
        CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;
        
        
        
        if([gestureRecognizer view].frame.origin.x < self.view.center.x){
            [UIView animateWithDuration:animationDuration animations:^{
                self.modal.view.frame = CGRectMake(self.view.frame.size.width/6, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
            
        }else{
            [UIView animateWithDuration:animationDuration animations:^{
                self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
            } completion:^(BOOL finished) {
                [self.modal.view removeFromSuperview];
                [self.modal removeFromParentViewController];
                self.modal = nil;
            }];
            
        }
        
        
        NSLog(@"the duration is: %f", animationDuration);
    
    }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
