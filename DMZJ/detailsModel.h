//
//  detailsModel.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class data;
@interface detailsModel : NSObject

@property(nonatomic,strong)data *data;


@end

@class info;
@interface data : NSObject

@property(nonatomic,strong)info *info;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,strong)NSArray *similar;


@end

@interface info : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *zone;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *copyright;
@property (nonatomic, copy) NSString *authors;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *first_letter;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *last_updatetime;
@property (nonatomic, copy) NSString *islong;
@property (nonatomic, copy) NSString *types;
@property (nonatomic, copy) NSString *last_update_chapter_name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *direction;

@end

@interface listDetails : NSObject
@property (nonatomic, copy) NSString *comic_id;
@property (nonatomic, copy) NSString *filesize;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *chapter_name;
@property (nonatomic, copy) NSString *chapter_order;
@property (nonatomic, copy) NSString *createtime;

@end

@interface similarDetails : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *last_update_chapter_name;
@end






