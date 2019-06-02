//
//  ScanTabBarController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 10/20/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ScanTabBarController.h"

@interface ScanTabBarController ()

@end

@implementation ScanTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
     UIView *v = [[UIView alloc] initWithFrame:frame];
    
    [v setBackgroundColor:[UIColor colorWithRed:21.0/255 green:51.0/255 blue:51.0/255 alpha:1]];
    
    [self.tabBar insertSubview:v atIndex:0];
    
     UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];
    
    
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
