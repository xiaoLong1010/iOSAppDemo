//
//  CsyContacterService.m
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyContacterService.h"
#import "CsyContacterDAO.h"
#import "CsyContacter.h"

static CsyContacterService *contacterService = nil;

@interface CsyContacterService ()

@property (strong,nonatomic) NSMutableArray *contacters;

@end

@implementation CsyContacterService


+ (CsyContacterService *)sharedContacterService
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        contacterService = [[CsyContacterService alloc] init];
//        contacterService.contacters = [[CsyContacterDAO sharedContacterDAO] findAll];
    });
    
    return contacterService;
}

- (void)create:(CsyContacter *)contacter
{
    [[CsyContacterDAO sharedContacterDAO] create:contacter];
    
    //将添加数据
//    _contacters = nil;
    [_contacters insertObject:contacter atIndex:0];
    
}

/**
 *  所有数据的数量
 */
- (NSUInteger)numOfContacters
{

    return self.contacters.count;
}

//懒加载
- (NSMutableArray *)contacters
{
    if (!_contacters) {
        _contacters = [[CsyContacterDAO sharedContacterDAO] findAll];
    }
    return _contacters;
}

/**
 *  根据索引获得数据
 */
- (CsyContacter *)contacterWithIndex:(NSInteger)index;
{
//    if (index < self.contacters.count) {
//        return self.contacters[index];
//    }
//    return nil;
    
    return (index < self.contacters.count) ? (self.contacters[index]) : (nil);
}

//根据索引,删掉数据
- (void)deleteContacterWithIndex:(NSInteger)index
{
    [_contacters removeObjectAtIndex:index];
    
    //删除数据库的数据   
    [[CsyContacterDAO sharedContacterDAO] deleteWithIndex:index];
}

- (void)updateContacterWithContacter:(CsyContacter *)contacter WithIndex:(NSIndexPath *)indexPath
{
    //1 更新模型
//    [_contacters[indexPath.row] setName:contacter.name];
//    [_contacters[indexPath.row] setPhoneNum:contacter.phoneNum];
    
    //2 更新数据库
    [[CsyContacterDAO sharedContacterDAO] updateContacterWithContacter:contacter WithIndex:indexPath];
}

@end
