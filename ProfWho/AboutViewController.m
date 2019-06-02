//
//  AboutViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/8/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aboutLogo;
@property (weak, nonatomic) IBOutlet UIImageView *aboutNanyangLogo;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong,nonatomic) UIViewController *modal;

@end

@implementation AboutViewController
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
    
    UIView *aboutView = [self.view viewWithTag:1];
    
    UIImage *logoImage = [UIImage imageNamed:@"AppIcon-1"];
    
    [self.aboutLogo setImage:logoImage];
    
    
    UIImage *nanyangLogo = [UIImage imageNamed:@"logo-NTU"];
    
    [self.aboutNanyangLogo setImage:nanyangLogo];
    

    
    
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    scroll.pagingEnabled = NO;
    
    [scroll addSubview:aboutView];
    
    scroll.contentSize = CGSizeMake(aboutView.frame.size.width, aboutView.frame.size.height);
    
   
    self.view.backgroundColor = [UIColor colorWithRed:1.0/255 green:17.0/255 blue:1.0/255 alpha:1];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [self.view addSubview:scroll];
    [self.view addSubview:self.menuButton];
    
    
    
    
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
