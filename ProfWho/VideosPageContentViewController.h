//
//  VideosPageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ViewController.h"
#import "DashboardRootViewController.h"


@interface VideosPageContentViewController : ViewController < UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void) loadVideosWithArray: (NSArray *) videosArray;

@property NSMutableArray *profVideoDictionaryArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@property (nonatomic) DashboardRootViewController *dashboardViewController;


@end
