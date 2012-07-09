//
//  PCKCheckList.h
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 tukeQ.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCKCheckList : NSObject
@property(nonatomic) NSInteger listId;
@property(strong, nonatomic) NSString * name;
@property(strong, nonatomic) NSString * imageName;
- (id)initWithId:(NSInteger)listId name:(NSString*)name imageName:(NSString*)imageName;
@end