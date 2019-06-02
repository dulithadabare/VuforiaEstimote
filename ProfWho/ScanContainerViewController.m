//
//  ScanContainerViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 11/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ScanContainerViewController.h"

BOOL menuIsChildViewFlag;
UITapGestureRecognizer *singleFingerTap;

@interface ScanContainerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *beaconButton;
@property (weak, nonatomic) IBOutlet UIButton *imageRecButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong,nonatomic) UIViewController *modal;
@property (strong,nonatomic) UIViewController *menuModal;
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end

@implementation ScanContainerViewController
- (IBAction)beacon:(id)sender {
    
    
//    self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"CloudRecoViewController"];
    if (self.childViewControllers.count != 0) {
        [self.beaconButton setUserInteractionEnabled:NO];
        [self.imageRecButton setUserInteractionEnabled:YES];
        
        UIImage *imageRecUnselectedImage = [UIImage imageNamed:@"tabBarImageRecUnselected"];
        UIImage *beaconSelectedImage = [UIImage imageNamed:@"tabBarBeaconSelected"];
        
        [self.imageRecButton setImage:imageRecUnselectedImage forState:UIControlStateNormal];
        [self.beaconButton setImage:beaconSelectedImage forState:UIControlStateNormal];
        
        [self dismissMenuChildViewAnimated];
        
        [self loadingChildViewWithFlag:YES];
        
        
    }else{
        
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"BeaconViewController"];
        [self addChildViewController:self.modal];
        self.modal.view.frame = CGRectMake(0, 0, self.modal.view.frame.size.width, self.view.frame.size.height-self.buttonView.frame.size.height);
        [self.view addSubview:self.modal.view];
   
        
        [self.modal didMoveToParentViewController:self];
        
    
    }
    
    
}
- (IBAction)imageRec:(id)sender {
   
    if (self.childViewControllers.count != 0) {
        [self.beaconButton setUserInteractionEnabled:YES];
        [self.imageRecButton setUserInteractionEnabled:NO];
        
//        UIImage *imageRecSelectedImage = [UIImage imageNamed:@"tabBarImageRecSelected"];
         UIImage *imageRecSelectedImage = [UIImage imageNamed:@"ImageRec-2"];
        UIImage *beaconUnselectedImage = [UIImage imageNamed:@"tabBarBeaconUnselected"];
        
        [self.imageRecButton setImage:imageRecSelectedImage forState:UIControlStateNormal];
        [self.beaconButton setImage:beaconUnselectedImage forState:UIControlStateNormal];
        
        [self dismissMenuChildViewAnimated];
        [self loadingChildViewWithFlag:NO];
        
    }
}
- (IBAction)menu:(id)sender {
  
    self.menuModal = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self addChildViewController:self.menuModal];
    self.menuModal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.menuModal.view.frame.size.width, self.menuModal.view.frame.size.height);
    [self.view addSubview:self.menuModal.view];
    //        self.view.layer.zPosition = 1;
    //        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.modal.view];
    
    // add gesture for dragging left to dismiss the childView
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissChildView:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.menuModal.view addGestureRecognizer:panRecognizer];
    
    singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.menuModal.view.frame = CGRectMake(self.view.frame.size.width/6, 0, self.menuModal.view.frame.size.width, self.menuModal.view.frame.size.height);;
    } completion:^(BOOL finished) {
        [self.menuModal didMoveToParentViewController:self];
        menuIsChildViewFlag = YES;
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.beaconButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    menuIsChildViewFlag = NO;
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadingChildViewWithFlag:(BOOL) childViewFlag{
    
    /*
     if the childView dismissal  needs to be animated
     
     [UIView animateWithDuration:0.5 animations:^{
     self.modal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);
     } completion:^(BOOL finished) {
     [self.modal.view removeFromSuperview];
     [self.modal removeFromParentViewController];
     self.modal = nil;
     }];
     */
  
    
    [self.modal willMoveToParentViewController:nil];
    [self.modal.view removeFromSuperview];
    [self.modal removeFromParentViewController];
    self.modal = nil;
    
    if (childViewFlag) {
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"BeaconViewController"];
    }else{
        self.modal = [self.storyboard instantiateViewControllerWithIdentifier:@"CloudRecoViewController"];
    }
    
    [self addChildViewController:self.modal];
    self.modal.view.frame = CGRectMake(0, 0, self.modal.view.frame.size.width, self.view.frame.size.height - self.buttonView.frame.size.height);
    [self.view addSubview:self.modal.view];
    
    
    /*
     
     if the childView appearence needs to be animated
     
     [UIView animateWithDuration:0.5 animations:^{
     self.modal.view.frame = CGRectMake(self.view.frame.size.width/6, 0, self.modal.view.frame.size.width, self.modal.view.frame.size.height);;
     } completion:^(BOOL finished) {
     [self.modal didMoveToParentViewController:self];
     }];
     
     */
    
    [self.modal didMoveToParentViewController:self];
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    //    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    [self dismissMenuChildViewAnimated];
    
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
        [[gestureRecognizer view] setFrame:CGRectMake((self.view.frame.size.width/6)+translatedPoint.x, 0, self.menuModal.view.frame.size.width, self.menuModal.view.frame.size.height)];
        
    }
    
    
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        CGFloat velocityX = (0.2*[gestureRecognizer velocityInView:self.view].x);
        
        CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;
        
        
        
        if([gestureRecognizer view].frame.origin.x < self.view.center.x){
            [UIView animateWithDuration:animationDuration animations:^{
                self.menuModal.view.frame = CGRectMake(self.view.frame.size.width/6, 0, self.menuModal.view.frame.size.width, self.menuModal.view.frame.size.height);
            } completion:^(BOOL finished) {
                
            }];
            
        }else{
            [UIView animateWithDuration:animationDuration animations:^{
                self.menuModal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.menuModal.view.frame.size.width, self.menuModal.view.frame.size.height);
            } completion:^(BOOL finished) {
                [self.menuModal.view removeFromSuperview];
                [self.menuModal removeFromParentViewController];
                self.menuModal = nil;
            }];
            
        }
        
        
        NSLog(@"the duration is: %f", animationDuration);
        
    }
    
    
}

-(void) dismissMenuChildViewAnimated{
    
    if (menuIsChildViewFlag == YES){
        [self.view removeGestureRecognizer:singleFingerTap];
        [UIView animateWithDuration:0.5 animations:^{
            self.menuModal.view.frame = CGRectMake(self.view.frame.size.width, 0, self.menuModal.view.frame.size.width, self.menuModal.view.frame.size.height);
            
        } completion:^(BOOL finished) {
            [self.menuModal.view removeFromSuperview];
            [self.menuModal removeFromParentViewController];
            self.menuModal = nil;
            
        }];
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
