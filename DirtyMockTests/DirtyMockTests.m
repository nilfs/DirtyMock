//
//  DirtyMockTests.m
//  DirtyMockTests
//
//  Created by nilfs on 12/11/04.
//  Copyright (c) 2012年 nilfs_dev. All rights reserved.
//

#import "DirtyMockTests.h"
#import "DirtyMock.h"

@implementation DirtyMockTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testCallOriginalMethod
{
    DirtyMock* mock = [DirtyMock mock:[NSString class]];
    DirtyMockMethod* mockMethod = [mock mockMethod:@selector(lowercaseString) :^(id self, SEL _cmd){
        
        if([self isEqualToString:@"Hoge"]){
            return [self performSelector:@selector(lowercaseStringOrg)];
        }
        
        return [NSString stringWithString:@"mocktest" ];
    }];
    
    [mockMethod switchMock];
    
    NSString* str = [NSString stringWithUTF8String:"Hoge"];
    STAssertEqualObjects([str lowercaseString], @"hoge", @"一致するはず");
    
    str = [NSString stringWithUTF8String:"NotHoge"];
    STAssertEqualObjects([str lowercaseString], @"mocktest", @"一致するはず");
}

@end
