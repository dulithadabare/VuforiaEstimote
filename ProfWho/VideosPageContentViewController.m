//
//  VideosPageContentViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "VideosPageContentViewController.h"
#import "CustomVideoCell.h"
#import "UIColor+ProfWhoColor.h"


@interface VideosPageContentViewController ()
@property (weak, nonatomic) IBOutlet UIView *notificationView;

@end

@implementation VideosPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *profilePicImage = [UIImage imageNamed:@"Profile-1"];
    
    [self.profilePic setImage:profilePicImage];
    
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

-(void)loadVideosWithArray:(NSArray *)videosArray{
    
    self.profVideoDictionaryArray = [NSMutableArray arrayWithCapacity:videosArray.count];
    
    for (NSDictionary *videoDictionary in videosArray) {
        
        NSString * videoURL =videoDictionary[@"video_url"];
        NSString * thumbnailURL = videoDictionary[@"thumbnail"];
       
        

        
        NSDictionary *videoDataDictionary = @{
                                              @"videoURL" : videoURL,
                                              @"thumbnailURL" : thumbnailURL,
                                              };
        
        [self.profVideoDictionaryArray addObject:videoDataDictionary];
        
    }
    
    NSLog(@"Videos loaded");
//    if (videosArray.count != 0) {
//        [self.collectionView setHidden:NO];
//        [self.notificationView setHidden:YES];
//    }
    [self.collectionView setHidden:NO];
    
    //        [self setImagesLoadedFlag:1];
    [self.collectionView reloadData];
    
 
    
    

    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSLog(@"The images loaded flag value is %ld",(long)self.imagesLoadedFlag);
//    return self.profImageDictionaryArray.count;
    return self.profVideoDictionaryArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
//    cell.profImageData = self.profImageDictionaryArray[indexPath.row];
//    UIImage *testImage = cell.profImageData[@"image"];
//    [cell.imageView setImage:testImage];
    
    NSDictionary *videoData = self.profVideoDictionaryArray[indexPath.row];
    NSString *videoURL = videoData[@"videoURL"];
    
    NSArray *stringArray = [videoURL componentsSeparatedByString:@"="];
    NSString *videoID = stringArray[1];
    
//    NSString *threadName = [NSString stringWithFormat:@"com.profwho.beacon%@",videoID];
//    const char *c = [threadName UTF8String];
//    
//    dispatch_async(dispatch_queue_create(c, NULL), ^{
//            [cell.playerView loadWithVideoId:videoID];
//        
////        dispatch_async(dispatch_get_main_queue(), ^{
////            //                [self.profilePic setImage:image];
////            cell.thumbnailImageView.image = image;
////        });
//        
//        
//    });
    
    [cell.playerView loadWithVideoId:videoID];
   
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *selectedImageData = self.profImageDictionaryArray[indexPath.row];
//    [self performSegueWithIdentifier:@"ShowSelectedImage"
//                              sender:selectedImageData];
//    [self.collectionView
//     deselectItemAtIndexPath:indexPath animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
