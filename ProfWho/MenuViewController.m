//
//  MenuViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "MenuViewController.h"
#import "UIColor+ProfWhoColor.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *menuLogo;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor pwLightGray];
    
    
    UIImage *logoImage = [UIImage imageNamed:@"Logo2"];
    
    [self.menuLogo setImage:logoImage];
    
    self.navigationController.navigationBar.hidden = YES;
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
