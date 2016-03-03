//
//  fastNewTableViewCell.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/14.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "fastNewTableViewCell.h"

@implementation fastNewTableViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        _iconView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    _iconView.backgroundColor =[UIColor greenColor];
        _nameLab =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 150, 30)];
    _nameLab.backgroundColor =[UIColor blackColor];
        _updateTime =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-60, 10, 60, 30)];
    _updateTime.backgroundColor =[UIColor redColor];
        _contentLab =[[UILabel alloc]initWithFrame:CGRectMake(5, 50, self.frame.size.width-10, 300)];
    _contentLab.backgroundColor =[UIColor orangeColor];
        _imgView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 360, self.frame.size.width/2, 200)];
    _imgView.backgroundColor =[UIColor brownColor];
        [self addSubview:_iconView];
        [self addSubview:_nameLab];
        [self addSubview:_updateTime];
        [self addSubview:_contentLab];
        [self addSubview:_imgView];
        
    }
    return self;
}

-(void)getDataFrom :(fastNewModel *)model
{
    model =[[fastNewModel alloc]init];
    [_iconView setImageWithURL:[NSURL URLWithString:model.cover]];
    _nameLab.text =model.nickname;
    _updateTime.text =[NSString stringWithFormat:@"%ld",model.updatetime];
    _contentLab.text =model.content;
    [_imgView setImageWithURL:[NSURL URLWithString:model.img]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
