//
//  UIAboutView.m
//  ProfWho
//
//  Created by Dulitha Dabare on 9/22/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import "UIAboutView.h"

IB_DESIGNABLE

@implementation UIAboutView

- (IBAction)readMore:(id)sender {
    
    if(self.readMoreCliked){
        
      
        self.prevAboutTextViewHeight = self.aboutTextView.frame.size.height;
        self.aboutTextView.text = self.aboutTextArray[1];
      //  [self.aboutText sizeToFit];
//        self.aboutTextView.text = test1;
        [self setReadMoreCliked:NO];
        [self.readMoreButton setTitle:@">> Tap to show more" forState:UIControlStateNormal];
        [self resizeAboutContentView];
        
    }else{
        
        self.prevAboutTextViewHeight = self.aboutTextView.frame.size.height;
        self.aboutTextView.text = self.aboutTextArray[0];
      //  [self.aboutText sizeToFit];
        
//        self.aboutTextView.text = test;
        [self setReadMoreCliked:YES];
        [self.readMoreButton setTitle:@"<< Tap to show less" forState:UIControlStateNormal];
        [self resizeAboutContentView];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibObjects=[[NSBundle mainBundle] loadNibNamed:@"CustomAboutView" owner:self options:nil];
        [self addSubview:[nibObjects objectAtIndex:0]];
    }
    return self;
}

- (void)resizeAboutContentView{
    
     self.mainView.frame = CGRectMake(0, self.yOffset, self.mainView.frame.size.width, self.mainView.frame.size.height + (self.aboutTextView.frame.size.height - self.prevAboutTextViewHeight));
    
    CGFloat aboutContentViewHeight = 0;
    
    for (UIAboutView *widget in self.aboutContentView.subviews) {
        if(widget != self){
            widget.frame = CGRectMake(0, widget.yOffset + (self.aboutTextView.frame.size.height - self.prevAboutTextViewHeight), widget.mainView.frame.size.width, widget.mainView.frame.size.width);
        }
        aboutContentViewHeight = aboutContentViewHeight + widget.mainView.frame.size.height;
    }
    
    self.aboutContentView.frame = CGRectMake(0, 10, self.aboutContentView.frame.size.width, aboutContentViewHeight);
    
     self.scrollView.contentSize = CGSizeMake(self.aboutContentView.frame.size.width, self.aboutContentView.frame.size.height);
}


@end
