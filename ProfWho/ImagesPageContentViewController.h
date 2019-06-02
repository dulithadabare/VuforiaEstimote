//
//  ImagesPageContentViewController.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ViewController.h"
#import "DashboardRootViewController.h"

@interface ImagesPageContentViewController : ViewController < UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property NSMutableArray *profImageDictionaryArray;

- (void) loadImagesWithArray: (NSArray *) imagesArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@property (nonatomic) DashboardRootViewController *dashboardViewController;

@end
