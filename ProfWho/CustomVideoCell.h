//
//  CustomVideoCell.h
//  ProfWho
//
//  Created by Dulitha Dabare on 10/11/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface CustomVideoCell : UICollectionViewCell

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@end
