//
//  readModel.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/3.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface readModel : NSObject

@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,copy)NSString *comic_id;
@property(nonatomic,copy)NSString *chapter_name;
@property(nonatomic,copy)NSString *chapter_order;
@property(nonatomic,strong)NSArray *page;
@property(nonatomic,strong)NSArray *size;



@end

@interface pageModel : NSObject
@property(nonatomic,copy)NSString *num;

@end

@interface sizeModel : NSObject
@property(nonatomic,assign)NSInteger width;
@property(nonatomic,assign)NSInteger heigth;

@end
