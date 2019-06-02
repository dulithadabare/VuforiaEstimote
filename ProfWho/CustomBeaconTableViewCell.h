//
//  CustomBeaconTableViewCell.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/20/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBeaconTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, strong) NSDictionary *profileData;

@end
