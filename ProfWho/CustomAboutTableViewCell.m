//
//  CustomAboutTableViewCell.m
//  ProfWho
//
//  Created by Dulitha Dabare on 10/31/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "CustomAboutTableViewCell.h"

@implementation CustomAboutTableViewCell


- (IBAction)readMore:(id)sender {
    
    if(self.readMoreCliked){
    
        

        self.aboutTextView.text = self.aboutTextArray[1];
        
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
       
        NSLog(@"The height of the textview is %f", self.aboutTextView.frame.size.height);
        
        [self setReadMoreCliked:NO];
        [self.readMoreButton setTitle:@">> Tap to show more" forState:UIControlStateNormal];
//        [self.tableView reloadData];

        
    }else{
        

        self.aboutTextView.text = self.aboutTextArray[0];
        
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
        
        NSLog(@"The height of the textview is %f", self.aboutTextView.frame.size.height);
        
        [self setReadMoreCliked:YES];
        [self.readMoreButton setTitle:@"<< Tap to show less" forState:UIControlStateNormal];
//        [self.tableView reloadData];

    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
