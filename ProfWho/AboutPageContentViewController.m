//
//  AboutPageContentViewController.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/16/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "AboutPageContentViewController.h"
#import "CustomAboutTableViewCell.h"
#import "UIColor+ProfWhoColor.h"

BOOL backgroundColorFlag;

@interface AboutPageContentViewController () <UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic) BOOL readMoreCliked;
@property (nonatomic) NSArray *aboutTextArray;
@property (nonatomic) NSMutableArray *aboutCellArray;
@property (nonatomic) NSArray *aboutCellDetailsArray;
@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet UIView *aboutContentView;



@end

@implementation AboutPageContentViewController

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.aboutCellDetailsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"beaconCell"];
    CustomAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aboutCustomCell" forIndexPath:indexPath];
    
    NSDictionary *section = self.aboutCellDetailsArray[indexPath.row];
    
    
    if(backgroundColorFlag){
        cell.contentView.backgroundColor = [UIColor pwLightGray];
        cell.aboutTextView.backgroundColor = [UIColor pwLightGray];
        backgroundColorFlag = NO;
    }else{
        cell.contentView.backgroundColor = [UIColor pwGray];
        cell.aboutTextView.backgroundColor = [UIColor pwGray];
        backgroundColorFlag = YES;
    }
    
    [cell setReadMoreCliked:NO];
    cell.aboutTitle.text = section[@"section_title"];
    
    /* 
     Support for dynamic text styles
    cell.aboutTitle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.aboutTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
     */
    
    NSString *originalText = section[@"section_content"];
    NSString *attributedString;
    
    if (originalText.length > 400) {
        NSRange range = NSMakeRange(0,400);
        attributedString = [originalText substringWithRange:range];
        attributedString = [attributedString stringByAppendingString:@"..."];
    }else{
        attributedString = originalText;
    }
    
    
    NSArray *textArray = @[originalText,attributedString];
    
    cell.aboutTextArray = textArray;
    
    cell.aboutTextView.text = cell.aboutTextArray[1];
    
    NSLog(@"The height of the textview is %f", cell.aboutTextView.frame.size.height);
    cell.aboutTextView.delegate = self;
    cell.tableView = self.tableView;
    
    
    
    return cell;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *profilePicImage = [UIImage imageNamed:@"Profile-1"];
    
    [self.profilePic setImage:profilePicImage];
    
    self.tableView.backgroundColor = [UIColor pwLightGray];
    
    self.tableView.backgroundColor = [UIColor pwLightGray];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 303;
    
    if(self.dashboardViewController.profilePicFlag){
        self.profilePic.image = self.dashboardViewController.profilePicImage;
    }
    
//    [self.aboutContentView setHidden:YES];
    [self.notificationView setHidden:YES];
    self.notificationView.backgroundColor = [UIColor pwLightGray];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAboutDetailsWithDictionary:(NSArray *)profAboutArray{
    
//    if (profAboutArray.count != 0) {
//        
//        [self.aboutContentView setHidden:NO];
//        [self.notificationView setHidden:YES];
//    }
    
    /*
    NSInteger numberOfAboutSections = profAboutArray.count;
    
    UIColor *lightGray = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:1];
    UIColor *darkGray = [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1];
    
    //uiview intialization
    BOOL colorFlag = YES;
    
    int y = 10;
    int topMargin = 0;
    
    UIView *aboutView = [self.view viewWithTag:2];
//    UIView *profilePicView = [self.view viewWithTag:3];
//    UIView *aboutContentView = [self.view viewWithTag:4];
    
    aboutView.backgroundColor = lightGray;
    
    CGFloat aboutViewWidth = aboutView.frame.size.width;
    CGFloat aboutViewHeight = aboutView.frame.size.height;
    
    CGRect aboutContentViewFrame = CGRectMake(0, y, aboutViewWidth, 274 * numberOfAboutSections);
    
    UIView *aboutContentView = [[UIView alloc] initWithFrame:aboutContentViewFrame];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, aboutViewWidth, aboutViewHeight)];
    
    for (NSDictionary *section in profAboutArray) {

        CGRect frame = CGRectMake(0, y, aboutView.frame.size.width, 274);
        
        UIAboutView *widget = [[UIAboutView alloc] initWithFrame:frame];
        widget.yOffset = y;
        
        if(colorFlag){
            widget.mainView.backgroundColor = lightGray;
            widget.aboutTextView.backgroundColor = lightGray;
            colorFlag = NO;
        }else{
            widget.mainView.backgroundColor = darkGray;
            widget.aboutTextView.backgroundColor = darkGray;
            colorFlag = YES;
        }
        
        [widget setReadMoreCliked:NO];
        widget.aboutTitle.text = section[@"section_title"];
//        widget.aboutTextView.text = section[@"section_content"];
        
        NSString *originalText = section[@"section_content"];
        NSString *attributedString;
        
        if (originalText.length > 400) {
            NSRange range = NSMakeRange(0,400);
            attributedString = [originalText substringWithRange:range];
            attributedString = [attributedString stringByAppendingString:@"..."];
        }else{
            attributedString = originalText;
        }

        
        NSArray *textArray = @[originalText,attributedString];
        
        widget.aboutTextArray = textArray;
        
//        [widget setAboutTextArray:[self addReadMoreStringToUILabel:widget.aboutTextView]];
        widget.prevAboutTextViewHeight = widget.aboutTextView.frame.size.height;
        widget.aboutTextView.text = widget.aboutTextArray[1];
        
        [widget setAboutContentView:aboutContentView];
        [widget setScrollView:scroll];
        [widget resizeAboutContentView];
        
        y= y + widget.frame.size.height + topMargin;
        
        [aboutContentView addSubview:widget];

    
       
    }
    
    
    
    [scroll addSubview:aboutContentView];
    
    scroll.contentSize = CGSizeMake(aboutContentView.frame.size.width, aboutContentView.frame.size.height);
    
    [aboutView addSubview:scroll];
     
     */
  
    
    self.aboutCellDetailsArray = profAboutArray;
    backgroundColorFlag = YES;
    
    [self.tableView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    /*
     Testing for supporting dynamic data types
   
    NSNotificationCenter *dynamicType = [[NSNotificationCenter alloc] init];
    
    [dynamicType addObserverForName:UIContentSizeCategoryDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableView reloadData];
    }];
     
     */
    
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
