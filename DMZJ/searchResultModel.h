//
//  searchResultModel.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/24.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchResultModel : NSObject

@property(nonatomic,strong)NSArray *seaData;

@end

@interface resultData : NSObject

@property (nonatomic, copy) NSString *last_update_chapter_name;
@property (nonatomic, copy) NSString *authors;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *types;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sum_source;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *hot_hits;
@property (nonatomic, copy) NSString *sum_chapters;

@end