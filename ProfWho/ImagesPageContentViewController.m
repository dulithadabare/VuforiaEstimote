//
//  ImagesPageContentViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "ImagesPageContentViewController.h"
#import "CustomImageCell.h"
#import "ImageViewController.h"
#import "UIColor+ProfWhoColor.h"

@interface ImagesPageContentViewController ()

@property NSInteger imagesLoadedFlag;
@property (weak, nonatomic) IBOutlet UIView *notificationView;

@end

@implementation ImagesPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *profilePicImage = [UIImage imageNamed:@"Profile-1"];
    
    [self.profilePic setImage:profilePicImage];
    
    self.imagesLoadedFlag = 0;
    
//    [self.collectionView registerClass:[CustomImageCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    
    if(self.dashboardViewController.profilePicFlag){
        self.profilePic.image = self.dashboardViewController.profilePicImage;
    }
    
//    [self.collectionView setHidden:YES];
    [self.notificationView setHidden:YES];
    self.notificationView.backgroundColor = [UIColor pwLightGray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadImagesWithArray:(NSArray *)imagesArray{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.profImageDictionaryArray = [NSMutableArray arrayWithCapacity:imagesArray.count];
    
    for (NSDictionary *imagesDictionary in imagesArray) {
        
        NSString * imageURL =imagesDictionary[@"image_url"];
//        imageURL = [imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        imageURL = [imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *imageCaption = imagesDictionary[@"caption"];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        
        NSDictionary *imageDataDictionary = @{
                                              @"image" : image,
                                              @"caption" : imageCaption,
                                              };
        
        [self.profImageDictionaryArray addObject:imageDataDictionary];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (imagesArray.count != 0) {
//            [self.collectionView setHidden:NO];
//            [self.notificationView setHidden:YES];
//        }
       
        NSLog(@"Images loaded");
        [self setImagesLoadedFlag:1];
            [self.collectionView reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    
    
    
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"The images loaded flag value is %ld",(long)self.imagesLoadedFlag);
    return self.profImageDictionaryArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    cell.profImageData = self.profImageDictionaryArray[indexPath.row];
    UIImage *testImage = cell.profImageData[@"image"];
    [cell.imageView setImage:testImage];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedImageData = self.profImageDictionaryArray[indexPath.row];
    [self performSegueWithIdentifier:@"ShowSelectedImage"
                              sender:selectedImageData];
    [self.collectionView
     deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
   
    // 2
    CGSize retval = CGSizeMake(100, 100);
    retval.height += 35; retval.width += 35; return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ShowSelectedImage"]) {
        ImageViewController *imageViewController = segue.destinationViewController;
        imageViewController.selectedImageData = sender;
    }
}


@end
