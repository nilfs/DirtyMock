//
//  DirtyMockMethod.m
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012 nilfs_dev. All rights reserved.
//

#import "DirtyMockMethod.h"

@interface DirtyMockMethod()

@end

@implementation DirtyMockMethod

+(DirtyMockMethod *)method:(Method)originalMethod :(Method)mockMethod{
    return [[DirtyMockMethod alloc] initWithMethod:originalMethod :mockMethod];
}

-(void)dealloc{
    [self switchOriginal];
}

-(id)initWithMethod:(Method)originalMethod :(Method)mockMethod{
    self = [self init];
    if (self != nil) {
        _isMock = NO;
        _originalMethod = originalMethod;
        _mockMethod = mockMethod;
    }
    
    return self;
}

-(void)switchMock{
    if ( _isMock == NO ){
        _isMock = YES;
        method_exchangeImplementations(_originalMethod, _mockMethod);
    }
}

-(void)switchOriginal{
    if ( _isMock ){
        _isMock = NO;
        method_exchangeImplementations(_originalMethod, _mockMethod);
    }
}

@end

