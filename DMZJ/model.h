//
//  model.h
//  model
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 you are my sunshine. All rights reserved.
//
#import "MJExtension.h"
#import <Foundation/Foundation.h>

@class indexDetail;
@interface model : NSObject
@property(nonatomic,strong)indexDetail *index;
@property(nonatomic,strong)indexDetail *MyNew;
@property(nonatomic,strong)indexDetail *lianzai;
@property(nonatomic,strong)indexDetail *wanjie;
@property(nonatomic,strong)indexDetail *yuanchuang;

@end


@class headlines;
@interface indexDetail : NSObject
@property(nonatomic,strong)headlines *headlines;
@property(nonatomic,strong)NSArray *episode;
@end

@interface headlines : NSObject
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subtitle;

@end


@interface epiDetail : NSObject
@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *last_update_chapter_name;

@end


















