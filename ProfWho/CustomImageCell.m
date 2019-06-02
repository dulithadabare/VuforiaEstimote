//
//  CustomImageCell.m
//  ProfWho
//
//  Created by Dulitha Dabare on 10/10/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "CustomImageCell.h"

@implementation CustomImageCell

-(void) setProfImageData:(NSDictionary *)profImageData {
    
    if(_profImageData != profImageData) {
        _profImageData = profImageData;
    }
    self.imageView.image = profImageData[@"image"];
}

@end
