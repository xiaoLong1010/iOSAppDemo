//
//  CsyContacterService.h
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CsyContacter;

@interface CsyContacterService : NSObject


+ (CsyContacterService *)sharedContacterService;

- (NSUInteger)numOfContacters;

- (CsyContacter *)contacterWithIndex:(NSInteger)index;

- (void)create:(CsyContacter *)contacter;

- (void)deleteContacterWithIndex:(NSInteger)index;

- (void)updateContacterWithContacter:(CsyContacter*)contacter WithIndex:(NSIndexPath*)indexPath;

@end
