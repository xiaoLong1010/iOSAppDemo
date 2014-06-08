//
//  CsyContacterDAO.m
//  iOSAppDemo
//
//  Created by csy on 6/6/14.
//  Copyright (c) 2014 cl. All rights reserved.
//

#import "CsyContacterDAO.h"
#import "CsyContacter.h"

static CsyContacterDAO *contacterDAO = nil;

@implementation CsyContacterDAO

//存放plist的完整路径
- (NSString *)applicationDocumentsDirectoryFile
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [dir stringByAppendingPathComponent:@"contacts.plist"];
    
    return filePath;
}

+ (CsyContacterDAO *)sharedContacterDAO
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        contacterDAO = [[CsyContacterDAO alloc] init];
    });
    
    return contacterDAO;
}

-(void)create:(CsyContacter *)contacter
{
    //1 获取数据
    NSDictionary *dict = @{@"name":contacter.name,@"phoneNum":contacter.phoneNum};
    //2 获取文件path
    NSString *path = [self applicationDocumentsDirectoryFile];
    //3 获取文件已经存在的数据
    NSMutableArray *datas = [NSMutableArray arrayWithContentsOfFile:path];
    if (!datas) {
        datas = [NSMutableArray array];
    }
    //4 将数据写入到array
    [datas insertObject:dict atIndex:0];
    
    //5 写入数据到文件
    [datas writeToFile:path atomically:YES];
    
}

//删除数据
- (void)delete:(CsyContacter *)contacter
{
    NSMutableArray *contacters = [self findAll];
    
    for (CsyContacter *contact in contacters) {
        if ([contact isEqual:contacter]) {
            
        }
    }
}

- (void)deleteWithIndex:(NSInteger)index
{
    //1 删掉指定的数据
    NSMutableArray *contacters = [self findAll];
    [contacters removeObjectAtIndex:index];

    //2 获取文件path
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    //3 写入数据到文件,先转换成NSDictonary
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:contacters.count];
    for (CsyContacter *contacter in contacters) {
        NSDictionary *dict = @{@"name":contacter.name,@"phoneNum":contacter.phoneNum};
        [datas addObject:dict];
    }
    [datas writeToFile:path atomically:YES];
}

//查询数据
- (NSMutableArray *)findAll
{
    //1 获取文件path
    NSString *path = [self applicationDocumentsDirectoryFile];
    //2 获取文件已经存在的数据,dicts
    NSArray *dicts = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:dicts.count];
    
    //3 遍历数组,生成所有的contacter
    for (NSDictionary *dict in dicts) {
        CsyContacter *contacter = [CsyContacter contacterWithDictionary:dict];
        [datas addObject:contacter];
    }
    
    return datas;
}

- (void)updateContacterWithContacter:(CsyContacter *)contacter WithIndex:(NSIndexPath *)indexPath;
{
    //1 获取文件,并更新数据
    NSMutableArray *contacters = [self findAll];
    
    [contacters[indexPath.row] setName:contacter.name];
    [contacters[indexPath.row] setPhoneNum:contacter.phoneNum];
    
    //2 获取文件path
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    //3 写入数据到文件,先转换成NSDictonary
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:contacters.count];
    for (CsyContacter *contacter in contacters) {
        NSDictionary *dict = @{@"name":contacter.name,@"phoneNum":contacter.phoneNum};
        [datas addObject:dict];
    }
    [datas writeToFile:path atomically:YES];
    
    
}

@end
