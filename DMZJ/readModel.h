//
//  readModel.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/3.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface readModel : NSObject

@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *comic_id;
@property(nonatomic,strong)NSString *chapter_name;
@property(nonatomic,strong)NSString *chapter_order;
@property(nonatomic,strong)NSArray *page;
@property(nonatomic,strong)NSArray *size;



@end

@interface pageModel : NSObject
@property(nonatomic,strong)NSString *num;

@end

@interface sizeModel : NSObject
@property(nonatomic,strong)NSString *width;
@property(nonatomic,strong)NSString *heigth;

@end
