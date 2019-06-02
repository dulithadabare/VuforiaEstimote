//
//  OutsideTutorialOnePageContentViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 10/13/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "OutsideTutorialOnePageContentViewController.h"

@interface OutsideTutorialOnePageContentViewController ()

@end

@implementation OutsideTutorialOnePageContentViewController
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:1];
    
    self.imageView.image = [UIImage imageNamed:@"5-Tutorial03-1"];
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
