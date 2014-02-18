//
//  MyoActivatorAppDelegate.h
//  MyoActivator
//
//  Created by Conrad Kramer on 2/17/14.
//  Copyright (c) 2013 Conrad Kramer. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MAEventNameCloseFist;
extern NSString * const MAEventNameSpreadFingers;
extern NSString * const MAEventNameWaveIn;
extern NSString * const MAEventNameWaveOut;

@interface MyoActivatorAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
