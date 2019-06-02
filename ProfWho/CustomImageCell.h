//
//  CustomImageCell.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/10/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSDictionary *profImageData;


@end
