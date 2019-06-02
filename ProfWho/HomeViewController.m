//
//  HomeViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (strong,nonatomic) UIViewController *modal;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation HomeViewController
- (IBAction)menu:(id)sender {
    
    if (self.childViewControllers.count == 0) {
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        [self addChildViewController:self.modal];
        self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
        [self.view addSubview:self.modal.view];
        
        /*
         swipe right to dismiss the menuviewcontroller
         
        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self.modal.view addGestureRecognizer:swipeRight];
        */
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissChildView:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [self.modal.view addGestureRecognizer:panRecognizer];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.modal.view.frame = CGRectMake(self.view.frame.size.width/6, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);;
        } completion:^(BOOL finished) {
            [self.modal didMoveToParentViewController:self];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
        } completion:^(BOOL finished) {
            [self.modal.view removeFromSuperview];
            [self.modal removeFromParentViewController];
            self.modal = nil;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:21.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    
    UIImage *logoImage = [UIImage imageNamed:@"Logo"];
    
    [self.logo setImage:logoImage];
    
    self.navigationController.navigationBar.hidden = YES;
    
    // add gesture to dismiss childview if childview is present
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    // call menuviewcontroller
    
    [self.menuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)swipeRight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
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

// the code that is not used is commented out for future use
-(void)dismissChildView:(UIPanGestureRecognizer*)gestureRecognizer {
    [self.view bringSubviewToFront:[gestureRecognizer view]];
    CGPoint translatedPoint = [gestureRecognizer translationInView:[gestureRecognizer view]];
    
    CGFloat firstX;
    CGFloat firstY = 0.0;
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
//        firstX = [[gestureRecognizer view] center].x;
//        firstY = [[gestureRecognizer view] center].y;
        
         firstX = self.view.frame.size.width/6;
         firstY = 0.0;
    }
    
//    translatedPoint = CGPointMake(firstX+translatedPoint.x, firstY);
    
//    [[gestureRecognizer view] setCenter:translatedPoint];
    
//    if((self.view.frame.size.width/6)+translatedPoint.x)
    if(translatedPoint.x >0){
        [[gestureRecognizer view] setFrame:CGRectMake((self.view.frame.size.width/6)+translatedPoint.x, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height)];

    }
    
    
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = (0.2*[gestureRecognizer velocityInView:self.view].x);
        
        
        CGFloat finalX = translatedPoint.x + velocityX;
        CGFloat finalY = firstY;// translatedPoint.y + (.35*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
        
        if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
            if (finalX < 0) {
                //finalX = 0;
            } else if (finalX > 768) {
                //finalX = 768;
            }
            
            if (finalY < 0) {
                finalY = 0;
            } else if (finalY > 1024) {
                finalY = 1024;
            }
        } else {
            if (finalX < 0) {
                //finalX = 0;
            } else if (finalX > 1024) {
                //finalX = 768;
            }
            
            if (finalY < 0) {
                finalY = 0;
            } else if (finalY > 768) {
                finalY = 1024;
            }
        }
        
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
        
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:animationDuration];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDidStopSelector:@selector(animationDidFinish)];
//        [[gestureRecognizer view] setCenter:CGPointMake(finalX, finalY)];
//        [UIView commitAnimations];
    }
    
    
}

- (void) animationDidFinish {
    
    if (self.childViewControllers.count != 0){
         self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
        [self.modal.view removeFromSuperview];
        [self.modal removeFromParentViewController];
        self.modal = nil;
       
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
