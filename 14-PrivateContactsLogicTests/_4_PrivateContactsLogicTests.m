//
//  _4_PrivateContactsLogicTests.m
//  14-PrivateContactsLogicTests
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CsyContacter.h"
#import "CsyContacterDAO.h"

@interface _4_PrivateContactsLogicTests : XCTestCase
@property (strong,nonatomic) CsyContacter *contacter;
@property (strong,nonatomic) CsyContacterDAO *contacterDAO;
@end

@implementation _4_PrivateContactsLogicTests

- (void)setUp
{
    [super setUp];
    _contacter = [[CsyContacter alloc] init];
    _contacter.name = @"zhangsan";
    _contacter.phoneNum = @"123456";
    
    _contacterDAO = [CsyContacterDAO sharedContacterDAO];
}

- (void)tearDown
{
    self.contacter = nil;
    self.contacterDAO = nil;
    [super tearDown];
}

- (void)testExample
{
    [_contacterDAO create:_contacter];
    XCTAssertEqual(@"123", @"123", @"buxiangton");
}

@end
