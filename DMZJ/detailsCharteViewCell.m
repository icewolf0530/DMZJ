//
//  detailsCharteViewCell.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/4.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "detailsCharteViewCell.h"

@implementation detailsCharteViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        _charpte_btn =[UIButton buttonWithType:UIButtonTypeCustom];
        _charpte_btn.frame =CGRectMake(0, 0, super.frame.size.width, 10);
        [_charpte_btn setTitle:@"加载中" forState:UIControlStateNormal];
//        [_charpte_btn addTarget:self action:@selector(_charpte:) forControlEvents:UIControlEventTouchUpInside];
        _charpte_btn.backgroundColor =[UIColor blueColor];
        self.backgroundColor =[UIColor blackColor];
        [self addSubview:_charpte_btn];
        
        
    }
    return self;
}

-(void)_charpte:(UIButton *)sender
{
    NSLog(@"初始化");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
