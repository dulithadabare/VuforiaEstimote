//
//  BeaconViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 10/18/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "BeaconViewController.h"
#import "RestAPITest.h"
#import "CustomBeaconTableViewCell.h"
#import "DashboardRootViewController.h"

#import <EstimoteSDK/EstimoteSDK.h>

double lastBeaconSearchTime;
BOOL firstBeaconDidRangeCall;

@interface BeaconViewController () <ESTBeaconManagerDelegate,CBCentralManagerDelegate, UITableViewDataSource>

@property (nonatomic) ESTBeaconManager *beaconManager;
@property (nonatomic) CLBeaconRegion *beaconRegion;
@property (nonatomic) NSArray *beaconArray;
@property (nonatomic) NSMutableArray *discoveredBeaconCellArray;
@property (nonatomic) NSMutableArray *downloadedBeaconCellArray;
@property (weak, nonatomic) IBOutlet UILabel *dotLoadingLabel;
@property (nonatomic) NSTimer *myTimer;
@property (nonatomic) CBCentralManager *centralManager;

@end

@implementation BeaconViewController

-(void)setDownloadedBeaconArray:(NSArray *)downloadedBeaconArray{
    if(_downloadedBeaconArray != downloadedBeaconArray) {
        _downloadedBeaconArray = downloadedBeaconArray;
    }
    self.downloadedBeaconCellArray = [NSMutableArray new];
    
//    [self.tableView reloadData];
    
    for (NSDictionary *assignedBeaconDictionary in downloadedBeaconArray) {
        CustomBeaconTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"beaconCell"];
        
//        NSDictionary *beaconData = [self.discoveredBeaconArray objectAtIndex:indexPath.row];
        cell.profileData = assignedBeaconDictionary;
        cell.nameLabel.text = assignedBeaconDictionary[@"name"];
        cell.descriptionLabel.text = assignedBeaconDictionary[@"description"];
        UIImage *temporaryThumbnailImage = [UIImage imageNamed:@"Profile-1"];
        cell.thumbnailImageView.image = temporaryThumbnailImage;
        
        NSString *threadName = [NSString stringWithFormat:@"com.profwho.beacon%@",assignedBeaconDictionary[@"name"]];
        const char *c = [threadName UTF8String];
        
        
        //    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        
        if(![assignedBeaconDictionary[@"profile_picture"] isEqual:[NSNull null]]){
            
            dispatch_async(dispatch_queue_create(c, NULL), ^{
                
                //                NSURL *url = [NSURL URLWithString:beaconData[@"profile_picture"]];
                
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:assignedBeaconDictionary[@"profile_picture"]]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //                [self.profilePic setImage:image];
                    cell.thumbnailImageView.image = image;
                });
                
                
            });
        }
        
        [self.downloadedBeaconCellArray addObject:cell];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.discoveredBeaconCellArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"beaconCell"];
    
 
    return self.discoveredBeaconCellArray[indexPath.row];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:21.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:21.0/255 green:51.0/255 blue:51.0/255 alpha:1];
    
    [self startLoadingAnimation];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 82;
    
    lastBeaconSearchTime = [[NSDate date] timeIntervalSince1970];
    firstBeaconDidRangeCall = YES;
    
    RestAPITest *beaconREST = [[RestAPITest alloc] init];
    [beaconREST getAssignedBeaconsFor:self];
    
    self.beaconManager = [ESTBeaconManager new];
    self.beaconManager.delegate = self;
  
    self.beaconRegion = [[CLBeaconRegion alloc]
                         initWithProximityUUID:[[NSUUID alloc]
                                                initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]
                         identifier:@"ranged region"];
    
    //look into using when-in-use when requesting authorization
    [self.beaconManager requestWhenInUseAuthorization];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if([segue.identifier isEqualToString:@"openDashboardFromBeacon"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DashboardRootViewController *dashboardViewController = segue.destinationViewController;
        
        CustomBeaconTableViewCell *cell = self.discoveredBeaconCellArray[indexPath.row];
        dashboardViewController.profileData = cell.profileData;
    }
}


-(void)beaconManager:(id)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons inRegion:(CLBeaconRegion *)region {
    
//     startTime = [[NSDate date] timeIntervalSince1970];
    
    
    if (!firstBeaconDidRangeCall) {
        
        
        double presentTime = [[NSDate date] timeIntervalSince1970];
        
        if (presentTime - lastBeaconSearchTime > 2) {
            //2 seconds have passed
            
            self.beaconArray = beacons;
            
            self.discoveredBeaconCellArray = [NSMutableArray new];
            
            if(self.downloadedBeaconCellArray.count != 0){
                
                for (CLBeacon *beacon in beacons) {
                    for (CustomBeaconTableViewCell *downloadedBeaconCell in self.downloadedBeaconCellArray) {
                        NSString *beaconMajor = [NSString stringWithFormat:@"%@", beacon.major];
                        if([beaconMajor isEqualToString:downloadedBeaconCell.profileData[@"major"]]){
                            [self.discoveredBeaconCellArray addObject:downloadedBeaconCell];
                        }
                        //                  [self.discoveredBeaconCellArray addObject:downloadedBeaconCell];
                        
                    }
                    
                }
                NSLog(@"%lu",(unsigned long)self.discoveredBeaconCellArray.count);
                [self.tableView reloadData];
                
            }
            
            // update the time counter
            lastBeaconSearchTime = [[NSDate date] timeIntervalSince1970];

        }

    }else{
        firstBeaconDidRangeCall = NO;
        self.beaconArray = beacons;
        
        self.discoveredBeaconCellArray = [NSMutableArray new];
        
        if(self.downloadedBeaconCellArray.count != 0){
            
            for (CLBeacon *beacon in beacons) {
                for (CustomBeaconTableViewCell *downloadedBeaconCell in self.downloadedBeaconCellArray) {
                    NSString *beaconMajor = [NSString stringWithFormat:@"%@", beacon.major];
                    if([beaconMajor isEqualToString:downloadedBeaconCell.profileData[@"major"]]){
                        [self.discoveredBeaconCellArray addObject:downloadedBeaconCell];
                    }
                    //                  [self.discoveredBeaconCellArray addObject:downloadedBeaconCell];
                    
                }
                
            }
            NSLog(@"%lu",(unsigned long)self.discoveredBeaconCellArray.count);
            [self.tableView reloadData];
            
        }
    }
    
    
}

- (void)startLoadingAnimation {
    self.dotLoadingLabel.text = @".";
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(updateLoadingLabel) userInfo:nil repeats:YES];
}

- (void)updateLoadingLabel {
    NSString *ellipses = @".  .  .";
    
    if ([self.dotLoadingLabel.text rangeOfString:ellipses].location == NSNotFound) {
        [self.dotLoadingLabel setText:[NSString stringWithFormat:@"%@  .",self.dotLoadingLabel.text]];
    } else {
        [self.dotLoadingLabel setText:@"."];
    }
}

- (void)endLoadingAnimation {
    [self.myTimer invalidate];
    self.myTimer = nil;
    [self.dotLoadingLabel setText:@" "];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {
        //Do what you intend to do
        NSLog(@"Bluetooth turned on");
    } else if(central.state == CBCentralManagerStatePoweredOff) {
        //Bluetooth is disabled. ios pops-up an alert automatically
        NSLog(@"Bluetooth turned off");
    }
}

@end
