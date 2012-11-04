//
//  DirtyMockMethod.h
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012 nilfs_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface DirtyMockMethod : NSObject

+(DirtyMockMethod*)method:(Method)originalMethod :(Method)mockMethod;

/**
 * exchange mock method
 */
-(void)switchMock;

/**
 * exchange original method
 */
-(void)switchOriginal;

@property BOOL isMock;
@property Method originalMethod;
@property Method mockMethod;

@end

