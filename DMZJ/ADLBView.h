//
//  ADLBView.h
//  day15-03-广告轮播封装
//
//  Created by Aaron on 15/10/23.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLBView : UIView
@property (nonatomic,assign) UIEdgeInsets boardWidth;
@property (nonatomic,strong) UIColor *boardColor;
@property(nonatomic,strong)UILabel *title;
-(instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images withCallBack:(void(^)(NSInteger chooseIndex))callBack;
@end
