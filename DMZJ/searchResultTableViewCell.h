//
//  searchResultTableViewCell.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/24.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *last_name_lable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *arther_lable;
@property (weak, nonatomic) IBOutlet UILabel *sytleLable;
@property (weak, nonatomic) IBOutlet UILabel *last_update_lable;


@end
