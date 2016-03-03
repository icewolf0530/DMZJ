//
//  DowlLoadViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "DowlLoadViewController.h"
#import "SearchViewController.h"
@interface DowlLoadViewController ()
{
    readModel *readmodel;
    
    UIScrollView *scrv;
}
@end

@implementation DowlLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden =YES;
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [self.view addSubview:navigationV];
    
    
    UILabel *lab =[[UILabel alloc]init];
    lab.text =@"下载";
    lab.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    lab.font =[UIFont systemFontOfSize:20];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    [navigationV addSubview:lab];
    
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame =CGRectMake(330*self.view.frame.size.width/375, 20, 35, 35);
    [searchBtn setImage:[UIImage imageNamed:@"recommendBtn6"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationV addSubview:searchBtn];
    
    UILabel *labtext =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    labtext.center =self.view.center;
    labtext.text =@"下载版权正在申请中\n敬请期待!O(∩_∩)O哈哈~";
    labtext.textAlignment=NSTextAlignmentCenter;
    labtext.numberOfLines =0;
    [self.view addSubview:labtext];
}



-(void)searchClick
{
    SearchViewController *Svc =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:Svc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

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
