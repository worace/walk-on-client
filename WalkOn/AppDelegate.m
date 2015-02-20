//
//  AppDelegate.m
//  WalkOn
//
//  Created by Horace Williams on 2/19/15.
//  Copyright (c) 2015 WoracesWorkshop. All rights reserved.
//

#import "AppDelegate.h"
#import "WOLastPlayedTracker.h"
#import "WOSongPlayer.h"

@interface AppDelegate ()
@property (nonatomic, strong) CLLocationManager* locationManager;
@end

@implementation AppDelegate

- (NSUUID *) beaconUUID {
    return [[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"];
}

- (void) initLastPlayedTime {
    [WOLastPlayedTracker initLastPlayed];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initLastPlayedTime];
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
                                    initWithProximityUUID:[self beaconUUID]
                                    identifier:@"turing-beacon"];
    NSLog(@"will monitor for region %@", beaconRegion);
    
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startUpdatingLocation];


    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
//    NSLog(@"did range beacons %@, will try to play our song", beacons);
    if ([WOLastPlayedTracker canPlay]) {
        NSLog(@"************** CAN PLAY VIA BEACON *************");
        [WOLastPlayedTracker updateLastPlayed];
        [WOSongPlayer playSongOfName:@"imperial_march"];
    }
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"ranging beacons did fail %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    NSLog(@"did determine state %@ for regeion %@", [self statusForRegionState:state], region);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
      _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

-(NSString *)statusForRegionState:(CLRegionState)state {
    switch (state) {
        case CLRegionStateInside:
            return @"inside";
        case CLRegionStateOutside:
            return @"outside";
        case CLRegionStateUnknown:
            return @"unknown";
        default:
            return @"Invalid State ??";
    }
}



@end
