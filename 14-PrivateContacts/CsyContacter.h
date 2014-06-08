//
//  CsyContacter.h
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CsyContacter : NSObject

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *phoneNum;

- (instancetype) initWithDictionary:(NSDictionary *)dict;
+ (instancetype) contacterWithDictionary:(NSDictionary *)dict;

//重写相等的判断标准
- (BOOL)isEqual:(id)object;

@end
