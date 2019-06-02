//
//  UIAboutLabel.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/22/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "UIAboutLabel.h"

@implementation UIAboutLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setReadMoreCliked:NO];
    }
    return self;
}

@end
