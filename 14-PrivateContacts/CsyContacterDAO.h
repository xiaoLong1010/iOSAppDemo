//
//  CsyContacterDAO.h
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CsyContacter;

@interface CsyContacterDAO : NSObject

+ (CsyContacterDAO *)sharedContacterDAO;

- (void)create:(CsyContacter *)contacter;

- (NSMutableArray *)findAll;

- (void)delete:(CsyContacter *)contacter;

- (void)deleteWithIndex:(NSInteger)index;

- (void)updateContacterWithContacter:(CsyContacter *)contacter WithIndex:(NSIndexPath *)indexPath;
@end
