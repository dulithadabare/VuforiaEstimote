//
//  BeaconViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/18/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BeaconViewController : UIViewController 

@property (nonatomic) NSArray *downloadedBeaconArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
