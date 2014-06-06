//
//  _4_PrivateContactsTests.m
//  14-PrivateContactsTests
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CsyContacter.h"
#import "CsyContacterDAO.h"

@interface _4_PrivateContactsTests : XCTestCase

@property (strong,nonatomic) CsyContacter *contacter;
@property (strong,nonatomic) CsyContacterDAO *contacterDAO;

@end

@implementation _4_PrivateContactsTests

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
    
    [_contacterDAO create:contacter];
}

@end
