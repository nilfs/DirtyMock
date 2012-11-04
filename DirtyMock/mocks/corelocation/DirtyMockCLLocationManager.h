//
//  DirtyMockCLLocationManager.h
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012 nilfs_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DirtyMockCLLocationManager : NSObject

+(DirtyMockCLLocationManager*)mock;

-(void)switchMock;
-(void)alwaysUpdateLocation:(CLLocation*)location;

@property BOOL locationServicesEnabled;

@end
