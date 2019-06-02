//
//  TutorialTwoPageContentViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "TutorialTwoPageContentViewController.h"

@interface TutorialTwoPageContentViewController ()

@end

@implementation TutorialTwoPageContentViewController

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:21.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    
    self.tutorialTwoImageView.image = [UIImage imageNamed:@"BluetoothDetection-3"];
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

@end
