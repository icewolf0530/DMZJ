//
//  NEWheadlineCollectionReusableView.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/30.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "NEWheadlineCollectionReusableView.h"

@implementation NEWheadlineCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headView = [[UIImageView alloc]initWithFrame:self.bounds];
        _headView.userInteractionEnabled = YES;
        [self addSubview:_headView];
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
//        [_headView addGestureRecognizer:tap];
        UIImageView * summaryBackground = [[UIImageView alloc]init];
        summaryBackground.userInteractionEnabled = YES;
        summaryBackground.translatesAutoresizingMaskIntoConstraints = NO;
        summaryBackground.image = [UIImage imageNamed:@"recommend_headlineTitleBg"];
        [_headView addSubview:summaryBackground];
        NSArray * backConstrains1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[summaryBackground]|" options:0 metrics:nil views:@{@"summaryBackground": summaryBackground}];
        [_headView addConstraints:backConstrains1];
        NSArray * backConstrains2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[summaryBackground(36)]|" options:0 metrics:nil views:@{@"summaryBackground": summaryBackground}];
        [_headView addConstraints:backConstrains2];
        _summary = [[UILabel alloc]init];
        _summary.font = [UIFont boldSystemFontOfSize:14];
        _summary.textColor = [UIColor whiteColor];
        _summary.translatesAutoresizingMaskIntoConstraints = NO;
        [summaryBackground addSubview:_summary];
        NSArray * summaryConstrains1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[summary]-8-|" options:0 metrics:nil views:@{@"summary": _summary}];
        [summaryBackground addConstraints:summaryConstrains1];
        NSArray * summaryConstrains2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[summary]|" options:0 metrics:nil views:@{@"summary": _summary}];
        [summaryBackground addConstraints:summaryConstrains2];
    }
    return self;
}
- (void)click {
    NSLog(@"111");
}




@end
