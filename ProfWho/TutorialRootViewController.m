//
//  TutorialRootViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "TutorialRootViewController.h"
#import "MenuViewController.h"

@interface TutorialRootViewController ()

@property (strong,nonatomic) UIViewController *modal;
@end

@implementation TutorialRootViewController
- (IBAction)menu:(id)sender {
    
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:21.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    
    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
    _pageImages = @[@"Tutorial01", @"Tutorial01", @"Tutorial01", @"Tutorial01"];
    
    self.tutorialPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialPageViewController"];
    self.tutorialPageViewController.dataSource = self;
    
    TutorialOnePageContentViewController *startingViewController = (TutorialOnePageContentViewController *)[self viewControllerAtIndex:0];
  
    [startingViewController setTutorialRootViewController:self];
    
    NSArray *viewControllers = @[startingViewController];
    [self.tutorialPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.tutorialPageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_tutorialPageViewController];
    [self.view addSubview:_tutorialPageViewController.view];
    [self.tutorialPageViewController didMoveToParentViewController:self];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (TutorialPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 4) {
        return nil;
    }
    
    
    if(index == 0){
        TutorialOnePageContentViewController *tutorialPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialOnePageContentViewController"];
        tutorialPageContentViewController.pageIndex = index;
        [tutorialPageContentViewController setTutorialRootViewController:self];
        return tutorialPageContentViewController;
    }
    else if (index == 1){
        TutorialTwoPageContentViewController *tutorialPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialTwoPageContentViewController"];
       tutorialPageContentViewController.pageIndex = index;
        [tutorialPageContentViewController setTutorialRootViewController:self];
        return tutorialPageContentViewController;
    }
    else if (index == 2){
        TutorialThreePageContentViewController *tutorialPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialThreePageContentViewController"];
        tutorialPageContentViewController.pageIndex = index;
        [tutorialPageContentViewController setTutorialRootViewController:self];
        return tutorialPageContentViewController;
    }else{
        TutorialFourPageContentViewController *tutorialPageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialFourPageContentViewController"];
        tutorialPageContentViewController.pageIndex = index;
        [tutorialPageContentViewController setTutorialRootViewController:self];
        return tutorialPageContentViewController;
    }
    
    // Create a new view controller and pass suitable data.
    
   
    
    
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == 4) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    
    return 4;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    
    return 0;
}

-(void)callMenuChildView {
    
    // this should be == 0
    
    
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
@end


