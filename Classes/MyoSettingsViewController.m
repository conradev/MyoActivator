//
//  MyoSettingsViewController.m
//  MyoActivator
//
//  Created by Conrad Kramer on 2/17/14.
//  Copyright (c) 2013 Conrad Kramer. All rights reserved.
//

#import <MyoKit/MyoKit.h>

#import "MyoSettingsViewController.h"
#import "MyoActivatorAppDelegate.h"

@interface LASettingsViewController (Private) <UITableViewDataSource, UITableViewDelegate>
@end

@implementation MyoSettingsViewController

#pragma mark - UIViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"MyoActivator";

        UIBarButtonItem *connectItem = [[UIBarButtonItem alloc] initWithTitle:@"Connect" style:UIBarButtonItemStylePlain target:self action:@selector(connect)];
        self.navigationItem.leftBarButtonItem = connectItem;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTrainButton) name:TLMHubDidConnectDeviceNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTrainButton) name:TLMHubDidDisconnectDeviceNotification object:nil];
        [self updateTrainButton];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MyoSettingsViewController

- (void)connect {
    UINavigationController *navController = [TLMSettingsViewController settingsInNavigationController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)train {
    TLMMyo *device = [[[TLMHub sharedHub] myoDevices] firstObject];
    [device presentTrainerFromViewController:self];
}

- (void)updateTrainButton {
    UIBarButtonItem *trainItem = nil;
    if ([[[TLMHub sharedHub] myoDevices] count] > 0) {
        trainItem = [[UIBarButtonItem alloc] initWithTitle:@"Train" style:UIBarButtonItemStylePlain target:self action:@selector(train)];
    }
    self.navigationItem.rightBarButtonItem = trainItem;
}

- (NSString *)eventNameForIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return MAEventNameCloseFist;
        case 1:
            return MAEventNameSpreadFingers;
        case 2:
            return MAEventNameWaveIn;
        case 3:
            return MAEventNameWaveOut;
        case 4:
            return MAEventNameTwistIn;
        default:
            return nil;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *eventName = [self eventNameForIndexPath:indexPath];
    cell.textLabel.text = [LASharedActivator localizedTitleForEventName:eventName];
    cell.detailTextLabel.text = [LASharedActivator localizedDescriptionForEventName:eventName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSString *eventName = [self eventNameForIndexPath:indexPath];
    UIViewController *viewController = [[LAEventSettingsController alloc] initWithModes:LASharedActivator.availableEventModes eventName:eventName];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
