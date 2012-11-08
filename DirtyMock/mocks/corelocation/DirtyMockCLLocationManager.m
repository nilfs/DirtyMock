//
//  DirtyMockCLLocationManager.m
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012 nilfs_dev. All rights reserved.
//

#import "DirtyMockCLLocationManager.h"
#import "DirtyMock.h"

@interface DirtyMockCLLocationManager()

@property DirtyMock* dirtyMock;
@property BOOL isUpdatingLocation;
@property CLLocation* updateLocation;
@property id orgSelf;
@end

@implementation DirtyMockCLLocationManager

+(DirtyMockCLLocationManager *)mock{
    return [[DirtyMockCLLocationManager alloc] init];
}

-(id)init{
    self = [super init];
    if( self != nil){
        _dirtyMock = [DirtyMock mock:[CLLocationManager class]];
        
        [_dirtyMock mockClassMethod:@selector(locationServicesEnabled):^(){
            return _locationServicesEnabled;
        }];
        
        [_dirtyMock mockMethod:@selector(startUpdatingLocation) :^(id self, SEL _cmd){
            _isUpdatingLocation = YES;
            
            _orgSelf = self;
        }];

        [_dirtyMock mockMethod:@selector(stopUpdatingLocation) :^(){
            _isUpdatingLocation = NO;
        }];
/*
        [_dirtyMock mockMethod:@selector(startUpdatingHeading) :^(){
        }];
        
        [_dirtyMock mockMethod:@selector(stopUpdatingHeading) :^(){
        }];
 
        [_dirtyMock mockMethod:@selector(dismissHeadingCalibrationDisplay) :^(){
        }];
*/
        [_dirtyMock mockMethod:@selector(startMonitoringSignificantLocationChanges) :^(){
        }];
        
        [_dirtyMock mockMethod:@selector(stopMonitoringSignificantLocationChanges) :^(){
        }];
    
        [_dirtyMock mockMethod:@selector(startMonitoringForRegion) :^(CLRegion * region, CLLocationAccuracy accuracy) {
        }];
        [_dirtyMock mockMethod:@selector(stopMonitoringForRegion) :^(CLRegion * region){
        }];
        [_dirtyMock mockMethod:@selector(startMonitoringForRegion) :^(CLRegion * region){
        }];
        [_dirtyMock mockMethod:@selector(allowDeferredLocationUpdatesUntilTraveled) :^(CLLocationDistance distance, NSTimeInterval timeout){
        }];
        [_dirtyMock mockMethod:@selector(disallowDeferredLocationUpdates) :^(){
        }];
        [_dirtyMock mockMethod:@selector(deferredLocationUpdatesAvailable) :^(){
        }];
        
    }
    return self;
}

-(void)switchMock{
    [_dirtyMock switchMockAllMethod];
}

-(void)switchOriginal{
    [_dirtyMock switchOriginalAllMethod];
}

-(void)alwaysUpdateLocation:(CLLocation *)location{
    _updateLocation = location;
}

-(void)updateLocation:(CLLocation *)location{
    assert(_orgSelf != nil);
    
    id<CLLocationManagerDelegate> delegate = ((CLLocationManager*)_orgSelf).delegate;
    [delegate locationManager:_orgSelf didUpdateToLocation:location fromLocation:location];
}

@end
