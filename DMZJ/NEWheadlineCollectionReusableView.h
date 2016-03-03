//
//  NEWheadlineCollectionReusableView.h
//  DMZJ
//
//  Created by 谅 陈 on 15/11/30.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEWheadlineCollectionReusableView : UICollectionReusableView

@property(nonatomic,assign)NSInteger Id;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)UIImageView * headView;
@property(nonatomic,strong)UILabel * summary;
    

@property (nonatomic,copy) void(^turn_block)(NSString * Id,NSString * title);
@end
