//
//  Sqlite3Manager.m
//  ExperimentWeek
//
//  Created by Bule on 2019/6/11.
//  Copyright © 2019 Bule. All rights reserved.
//

#import "Sqlite3Manager.h"
#import "FMDatabase.h"

@implementation Sqlite3Manager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDB ];
        [self openDB];
        
    }
    return self;
}

- (void) createDB {
    NSString * path = [NSString stringWithFormat:@"%@/Documents/app.db",NSHomeDirectory()];
    self.database = [FMDatabase databaseWithPath:path];
}
- (void) openDB {
    //如果打开成功
    if ([self.database open])
    {
        NSString * sql = @"create table if not exists t_humen ( \
        id integer primary key autoincrement, \
        name varchar(30), \
        number varchar(30), \
        sex varchar(10) )";
        //NSLog( sql );
        if ([self.database executeUpdate:sql])
        {
            NSLog(@"创建表成功");
        }
        else
        {
            NSLog(@"创建失败！");
        }
    }
    else
    {
        NSLog(@"打开失败！");
    }
}
-(NSMutableArray*)getAll
{
    NSString * sql = @"select * from t_humen";

    FMResultSet * resultSet = [self.database executeQuery:sql];
    
    NSMutableArray* res = [[NSMutableArray alloc] init ];
    
    while ([resultSet next])
    {
        //用字典接收
        NSDictionary * temp_dict = [resultSet resultDictionary];
        [res addObject:temp_dict];
    }
    return res;
}
-(BOOL)addWithName: (NSString*) name Number: (NSString*)number Sex: (NSString*)sex
{
    NSString* sql = [NSString stringWithFormat:@"insert into t_humen values(NULL,'%@', '%@','%@')",name,number,sex];
    if ([self.database executeUpdate:sql] ) {
        NSLog(@"插入成功！");
        return true;
    } else {
        NSLog(@"插入失败！");
        return false;
    }
}
-(BOOL)deleteById: (NSInteger)index
{
    NSString * sql = [NSString stringWithFormat:@"delete from t_humen where id=%ld",index];
    
    if ([self.database executeUpdate:sql]) {
        NSLog(@"删除成功！");
        return true;
    } else {
        NSLog(@"删除失败！");
        return false;
    }
}

-(BOOL)updateWithId: (NSInteger)index Name: (NSString*)name Number: (NSString*)number Sex: (NSString*)sex
{
    NSString * sql = [NSString stringWithFormat:@"update t_humen set name='%@',number='%@',sex='%@' where id=%ld",name,number,sex,index];
    
    if ([self.database executeUpdate:sql])
    {
        NSLog(@"更新成功！");
        return true;
    }
    else
    {
        NSLog(@"更新失败！");
        return false;
    }
}

-(NSMutableArray*)getByName: (NSString *)name
{
    NSMutableArray* arr = [self getAll];
    NSMutableArray* del = [ [NSMutableArray alloc] init ];
    for( NSDictionary* d in arr ) {
        if( ![[d objectForKey:@"name"] isEqualToString:name] ) {
            [del addObject:d];
        }
    }
    for( NSDictionary* d in del ) {
        [arr removeObject:d];
    }
    return arr;
}

- (BOOL) deleteAll {
    NSString * sql = [NSString stringWithFormat:@"delete from t_humen" ];
    
    if ([self.database executeUpdate:sql]) {
        NSLog(@"删除成功！");
        return true;
    } else {
        NSLog(@"删除失败！");
        return false;
    }
}

- (void) showById: (NSInteger)index {
    NSMutableArray* arr = [self getAll];
    for( NSDictionary* d in arr ) {
        NSInteger _id = [[d objectForKey:@"id"] intValue];
        if( _id == index ) {
            NSLog(@"id is %ld, name is %@, number is %@ and sex is %@", (long)_id, [d objectForKey:@"name"], [d objectForKey:@"number"], [d objectForKey:@"sex"] );
            return;
        }
    }
}

-(void)dealloc
{
    //关闭数据库
    [self.database close];
}

@end
