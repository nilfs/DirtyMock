//
//  DirtyMockCLLocationManagerTest.m
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012年 nilfs_dev. All rights reserved.
//

#import "DirtyMockCLLocationManagerTest.h"
#import "DirtyMockCLLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface DirtyMockCLLocationManagerTest() <CLLocationManagerDelegate>

@property CLLocation* expectedLocation;

@end

@implementation DirtyMockCLLocationManagerTest

-(void)testReceiveFixResult{
    
    _expectedLocation = [[CLLocation alloc] initWithLatitude:10.f longitude:20.f];
    
    DirtyMockCLLocationManager* mock = [DirtyMockCLLocationManager mock];
    
    [mock switchMock];
    mock.locationServicesEnabled = YES;
    [mock alwaysUpdateLocation:_expectedLocation];
    
    CLLocationManager* locationManager;
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    } else {
        STFail(@"");
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    STAssertEqualsWithAccuracy(_expectedLocation.coordinate.latitude, newLocation.coordinate.latitude, 0.01, @"");
    STAssertEqualsWithAccuracy(_expectedLocation.coordinate.longitude, newLocation.coordinate.longitude, 0.01, @"");
}

@end
