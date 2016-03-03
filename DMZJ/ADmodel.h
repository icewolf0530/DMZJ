//
//  ADmodel.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/14.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADmodel : NSObject

@property(nonatomic,strong)NSArray *data;

@end

@interface ADdata : NSObject
@property (nonatomic, strong) NSNumber *object_id;
@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *object_url;
@end