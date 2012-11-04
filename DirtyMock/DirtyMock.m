//
//  DirtyMock.m
//  DirtyMock
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012 nilfs_dev. All rights reserved.
//

#import "DirtyMock.h"

static const char* s_Suffix = "Org";

@interface DirtyMock()

@property NSMutableArray* mockMethods;

@end

@implementation DirtyMock

+(DirtyMock *)mock:(Class)klass{
    return [[DirtyMock alloc] initWithClass:klass];
}

-(DirtyMockMethod *)mockClassMethod:(SEL)sel :(id)block{
    //  look original method by mock method caller
    SEL orgMethodSel = NSSelectorFromString( [NSString stringWithFormat:@"%@%s", NSStringFromSelector(sel), s_Suffix] );
    
    Method orgMethod = class_getClassMethod(_holdedKlass, sel);
    IMP mockImp = imp_implementationWithBlock(block);
    
    if( class_addMethod(_holdedKlass, orgMethodSel, mockImp, method_getTypeEncoding(orgMethod)) ){
        
        Method mockMethod = class_getClassMethod(_holdedKlass, orgMethodSel);
        
        DirtyMockMethod* dirtyMockMethod = [DirtyMockMethod method:orgMethod :mockMethod];
        [_mockMethods addObject:dirtyMockMethod];
        return dirtyMockMethod;
    }
    
    return nil;    
}

-(DirtyMockMethod *)mockMethod:(SEL)sel :(id)block{
    //  look original method by mock method caller
    SEL orgMethodSel = NSSelectorFromString( [NSString stringWithFormat:@"%@%s", NSStringFromSelector(sel), s_Suffix] );
    
    Method orgMethod = class_getInstanceMethod(_holdedKlass, sel);
    IMP mockImp = imp_implementationWithBlock(block);
    
    if( class_addMethod(_holdedKlass, orgMethodSel, mockImp, method_getTypeEncoding(orgMethod)) ){
        
        Method mockMethod = class_getInstanceMethod(_holdedKlass, orgMethodSel);
        
        DirtyMockMethod* dirtyMockMethod = [DirtyMockMethod method:orgMethod :mockMethod];
        [_mockMethods addObject:dirtyMockMethod];
        return dirtyMockMethod;
    }
    
    return nil;
}

-(id)initWithClass:(Class)klass{
    if(self = [super init]){
        _holdedKlass = klass;
        _mockMethods = [NSMutableArray array];
    }
    return self;
}

-(void)dealloc{
}

-(void)switchMockAllMethod{
    for( int i=0; i< [_mockMethods count]; ++i ){
        DirtyMockMethod* mockMethod = [_mockMethods objectAtIndex:i];
        [mockMethod switchMock];
    }
}

-(void)switchOriginalAllMethod{
    for( int i=0; i< [_mockMethods count]; ++i ){
        DirtyMockMethod* mockMethod = [_mockMethods objectAtIndex:i];
        [mockMethod switchOriginal];
    }
}

@end
