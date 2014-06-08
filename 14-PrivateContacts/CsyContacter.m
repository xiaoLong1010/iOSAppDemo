//
//  CsyContacter.m
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyContacter.h"

@implementation CsyContacter

- (instancetype) initWithDictionary:(NSDictionary *)dict;
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) contacterWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
    
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {   //同一个对象
        return YES;
    }else if (![object isKindOfClass:[CsyContacter class]]){     //不是同一个类型
        return NO;
    }else {
        CsyContacter *contacter = (CsyContacter *)object;
        if ([self.name isEqualToString:contacter.name] && [self.phoneNum isEqualToString:contacter.phoneNum]) {
            return YES;
        }
    }
    return NO;
    
}

@end
