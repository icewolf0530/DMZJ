//
//  fastNewTableViewCell.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/14.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fastNewModel.h"
@interface fastNewTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *updateTime;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIImageView *imgView;
-(void)getDataFrom :(fastNewModel *)model;
@end
