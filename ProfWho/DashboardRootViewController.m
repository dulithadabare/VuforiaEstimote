//
//  DashboardRootViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "DashboardRootViewController.h"
#import "RestAPITest.h"
#import "AboutPageContentViewController.h"
#import "ProfilePageContentViewController.h"
#import "ImagesPageContentViewController.h"
#import "VideosPageContentViewController.h"
#import "UIColor+ProfWhoColor.h"
#import "MenuViewController.h"

@interface DashboardRootViewController ()
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property (strong,nonatomic) UIViewController *modal;
@property(nonatomic, getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;

@end

@implementation DashboardRootViewController
- (IBAction)menu:(id)sender {

    NSLog(@"Can touch the menu button");
    
    BOOL menuIsChildFlag = NO;
    
    for (UIViewController *childViewController in self.childViewControllers) {
        
        if (childViewController.class == [MenuViewController class]) {
            menuIsChildFlag = YES;
        }
    }
    
    if (!menuIsChildFlag) {
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        [self addChildViewController:self.modal];
        self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
        [self.view addSubview:self.modal.view];
        //        self.view.layer.zPosition = 1;
        //        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.modal.view];
        
        // add gesture for dragging left to dismiss the childView
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

-(void)setProfilePicFlag:(BOOL)profilePicFlag {
    _profilePicFlag =  profilePicFlag;
    
    if(_profilePicFlag){
        
        self.profilePageInstance.profilePic.image = self.profilePicImage;
        self.aboutPageInstance.profilePic.image = self.profilePicImage;
        self.imagesPageInstance.profilePic.image = self.profilePicImage;
        self.videosPageInstance.profilePic.image = self.profilePicImage;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor pwPaleBlue];
    
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
//    UIPageViewController *dashboardPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardPageViewController"];
    
//            self.menuButton.view.layer.zPosition = 1;
    
//    self.menuButton.layer.zPosition = 1;
//     [self.view bringSubviewToFront:self.menuButton];
    
    
    
    UIPageViewController *dashboardPageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:dashboardPageViewController];
    
     ViewController *profilePageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfilePageContentViewController"];
     ViewController *aboutPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutPageContentViewController"];
     ViewController *imagesPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImagesPageContentViewController"];
     ViewController *videosPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VideosPageContentViewController"];
    
//    ProfilePageContentViewController *test = (ProfilePageContentViewController *) profilePageContentViewController;
    
    self.profilePageInstance = (ProfilePageContentViewController *)profilePageContentViewController;
    [self.profilePageInstance setDashboardViewController:self];
    
    self.aboutPageInstance = (AboutPageContentViewController *) aboutPageContentViewController;
    [self.aboutPageInstance setDashboardViewController:self];
    
    self.imagesPageInstance = (ImagesPageContentViewController *)imagesPageContentViewController;
    [self.imagesPageInstance setDashboardViewController:self];
    
    self.videosPageInstance = (VideosPageContentViewController *)videosPageContentViewController;
    [self.videosPageInstance setDashboardViewController:self];
    
    RestAPITest *profDetailsGET = [[RestAPITest alloc] init];
    [profDetailsGET getDetailsFor:self.profileData[@"data_id"] ofProfileType:@"professor" profileViewController:self.profilePageInstance aboutViewController:self.aboutPageInstance imagesViewController:self.imagesPageInstance videosViewController:self.videosPageInstance];
    

    
    [navigationController.viewControllerArray addObjectsFromArray:@[profilePageContentViewController, aboutPageContentViewController, imagesPageContentViewController, videosPageContentViewController]];
    
 //   self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
 //   self.window.rootViewController = navigationController;
 //   [self.window makeKeyAndVisible];
    
    [self addChildViewController:navigationController];
    [self.view addSubview:navigationController.view];
    [self.navigationController didMoveToParentViewController:self];
    [self.view addSubview:self.menuButton];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callMenuChildView {
    
    // functionality moved to menu button call

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
