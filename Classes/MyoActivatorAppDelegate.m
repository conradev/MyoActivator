//
//  MyoActivatorAppDelegate.m
//  MyoActivator
//
//  Created by Conrad Kramer on 2/17/14.
//  Copyright (c) 2013 Conrad Kramer. All rights reserved.
//

#import <MyoKit/MyoKit.h>

#import "MyoActivatorAppDelegate.h"
#import "MyoSettingsViewController.h"

NSString * const MAEventNameCloseFist = @"com.conradkramer.myoactivator.close-fist";
NSString * const MAEventNameSpreadFingers = @"com.conradkramer.myoactivator.spread-fingers";
NSString * const MAEventNameWaveIn = @"com.conradkramer.myoactivator.wave-in";
NSString * const MAEventNameWaveOut = @"com.conradkramer.myoactivator.wave-out";

@interface MyoActivatorAppDelegate ()

@property (strong, nonatomic) MyoSettingsViewController *settingsViewController;

@end 

@implementation MyoActivatorAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TLMHub sharedHub];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePoseChange:) name:TLMMyoDidReceivePoseChangedNotification object:nil];

    self.settingsViewController = [[MyoSettingsViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.settingsViewController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MyoActivatorAppDelegate

- (LAEvent *)eventFromPose:(TLMPose *)pose {
	NSString *eventName = nil;
    switch (pose.type) {
        case TLMPoseTypeFist:
            eventName = MAEventNameCloseFist;
            break;
        case TLMPoseTypeFingersSpread:
            eventName = MAEventNameSpreadFingers;
            break;
        case TLMPoseTypeWaveIn:
            eventName = MAEventNameWaveIn;
            break;
        case TLMPoseTypeWaveOut:
            eventName = MAEventNameWaveOut;
            break;
        case TLMPoseTypeNone:
       		eventName = nil;
       		break;
    }

    return eventName ? [LAEvent eventWithName:eventName mode:LASharedActivator.currentEventMode] : nil;
}

- (void)didReceivePoseChange:(NSNotification *)notification {
    TLMPose *pose = notification.userInfo[kTLMKeyPose];
    LAEvent *event = [self eventFromPose:pose];
    if (event && self.settingsViewController.presentedViewController == nil) {
    	[LASharedActivator sendEventToListener:event];
	}
}

@end
