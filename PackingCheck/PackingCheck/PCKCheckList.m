//
//  PCKCheckList.m
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKCheckList.h"
#import "FMDatabase.h"
#import "PCKCommon.h"
#import "DBUtils.h"
#import "PCKItem.h"

@implementation PCKCheckList
@synthesize name=_name, listId=_listId, imageName=_imageName;
- (id)initWithId:(int)listId name:(NSString*)name imageName:(NSString*)imageName
{
    self = [super init];
    if (self) {
        self.listId = listId;
        self.name = name;
        self.imageName = imageName;
    }
    return self;

}

- (id)initWithResultSet:(FMResultSet*)rs
{
    self = [self initWithId:[(NSNumber *)[rs objectForColumnName:@"id"] intValue]  
                       name:[rs objectForColumnName:@"name"] 
                    imageName:[rs objectForColumnName:@"image_name"]];
    return self;
}

- (void)increaseOpens
{
    NSLog(@"incr");
    FMDatabase* db = [PCKCommon database];
    [db executeUpdate:@"UPDATE check_list SET opens=opens+1 WHERE id=?", [NSNumber numberWithInt:self.listId]];
}

- (NSMutableArray*) items
{
    return [[PCKItem class] find:@"SELECT i.* FROM item i INNER JOIN list_item l ON i.id=l.item_id AND l.list_id=?", [NSNumber numberWithInt:self.listId]];
}

+ (NSMutableArray*) all
{
    return [self find:@"SELECT * FROM check_list ORDER BY opens DESC"];
}

+ (PCKCheckList*)createWithName:(NSString*)name imageName:(NSString*)imageName
{
    FMDatabase* db = [PCKCommon database];
    [db executeUpdate:@"INSERT INTO check_list(name, image_name) VALUES (?, ?)", name, imageName];
    int listId = [db lastInsertRowId];
    PCKCheckList* checkList = [[PCKCheckList alloc]initWithId:listId name:name imageName:imageName];
    return checkList;
}
@end
