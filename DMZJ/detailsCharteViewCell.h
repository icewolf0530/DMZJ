//
//  detailsCharteViewCell.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/4.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailsCharteViewCell : UIView

@property (nonatomic, copy) NSString *comic_id;
@property (nonatomic, copy) NSString *filesize;
@property (nonatomic, assign) NSInteger ID;
@property(nonatomic,strong) UIButton *charpte_btn;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *chapter_order;
@property (nonatomic, copy) NSString *createtime;



@end
