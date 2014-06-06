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

@end
