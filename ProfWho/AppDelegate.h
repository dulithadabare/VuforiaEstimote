//
//  AppDelegate.h
//  ProfWho
//
//  Created by Dulitha Dabare on 9/2/16.
//  Copyright © 2016 Dulitha Dabare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleGLResourceHandler.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) id<SampleGLResourceHandler> glResourceHandler;


@end

