//
//  MoreViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *TabV;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =YES;
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [self.view addSubview:navigationV];
    
    
    UILabel *lab =[[UILabel alloc]init];
    lab.text =@"更多";
    lab.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    lab.font =[UIFont systemFontOfSize:20];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    [navigationV addSubview:lab];
    [self configUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)configUI
{
    TabV =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 610) style:UITableViewStyleGrouped];
    TabV.backgroundColor =[UIColor colorWithWhite:0.927 alpha:1.000];
    TabV.contentSize =CGSizeMake(self.view.bounds.size.width, 667);
    TabV.bounces =YES;
    TabV.directionalLockEnabled =YES;
    TabV.showsVerticalScrollIndicator = NO;
    TabV.showsHorizontalScrollIndicator = NO;
    TabV.dataSource =self;
    TabV.delegate =self;
    
    [self.view addSubview:TabV];
    
//    UITableViewCell *TVCell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabCell"];


}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabCell"];
    if (indexPath.section ==0&&indexPath.row ==0) {
        cell.textLabel.text =@"设置";
    }
    if(indexPath.section ==1)
    {
        if(indexPath.row ==0)
        {
        cell.textLabel.text =@"意见反馈";
        }
        if(indexPath.row ==1)
        {
        cell.textLabel.text =@"清除在线缓存(%d)";
        }
        if(indexPath.row ==2)
        {
        cell.textLabel.text =@"清除浏览记录";
        }
    }
    if(indexPath.section ==2)
    {
    cell.textLabel.text =@"关于我们";
    }
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0&&indexPath.row ==0)
    {
        
    }
    if(indexPath.section ==1)
    {
        if(indexPath.row ==0)
        {
        }
        if(indexPath.row ==1)
        {
        }
        if(indexPath.row ==2)
        {
        }
    }
    if(indexPath.section ==2)
    {
        aboutUsViewController *avc =[[aboutUsViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    if (section ==1) {
        return 3;
    }
    else {
        return 1;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
