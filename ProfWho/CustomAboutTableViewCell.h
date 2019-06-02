//
//  CustomAboutTableViewCell.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/31/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAboutTableViewCell : UITableViewCell

@property (nonatomic)   UIView *aboutView;

@property (weak, nonatomic) IBOutlet UILabel *aboutTitle;
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;

@property (nonatomic) BOOL readMoreCliked;
@property (nonatomic) NSArray *aboutTextArray;
@property (nonatomic) UITableView *tableView;

@end
