//
//  NEWCollectionViewCell.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/27.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "NEWCollectionViewCell.h"

@implementation NEWCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _coverImgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20)];
    _lastUpdate =[[UILabel alloc]initWithFrame:CGRectMake(20, frame.size.height-40, 60, 20)];
    _title =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    _title.backgroundColor =[UIColor whiteColor];
    _title.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *bgLine =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 20)];
    bgLine.image =[UIImage imageNamed:@"recommend_headlineTitleBg"];
    
    _lastUpdate.textAlignment =NSTextAlignmentRight;
    _lastUpdate.textColor =[UIColor whiteColor];
    _lastUpdate.font =[UIFont systemFontOfSize:13];
    _title.font =[UIFont systemFontOfSize:13];
    
    [bgLine addSubview:_lastUpdate];
    [_coverImgView addSubview:bgLine];
    [view addSubview:_title];
    [view addSubview:_coverImgView];
    [self addSubview:view];
    return self;
}


@end
