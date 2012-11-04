//
//  DirtyMock.h
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012 nilfs_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "DirtyMockMethod.h"

@interface DirtyMock : NSObject

+(DirtyMock*)mock:(Class)klass;

-(DirtyMockMethod*)mockClassMethod:(SEL)sel :(id)block;
-(DirtyMockMethod*)mockMethod:(SEL)sel :(id)block;

-(void)switchMockAllMethod;
-(void)switchOriginalAllMethod;

@property Class holdedKlass;

@end
