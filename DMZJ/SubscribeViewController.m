//
//  SubscribeViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SearchViewController.h"
@interface SubscribeViewController ()

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden =YES;
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [self.view addSubview:navigationV];
    

    UISegmentedControl *Sc =[[UISegmentedControl alloc]initWithItems:@[@"订阅",@"浏览记录"]];
    Sc.frame =CGRectMake(self.view.frame.size.width/2-75, 25, 150,35);
    Sc.backgroundColor =[UIColor colorWithRed:0.290 green:0.786 blue:1.000 alpha:1.000];
    Sc.momentary =NO;
    Sc.tintColor =[UIColor whiteColor];
    Sc.selectedSegmentIndex = 0;
    
    [Sc addTarget:self action:@selector(choose:) forControlEvents:UIControlEventValueChanged];
    [navigationV addSubview:Sc];
    
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame =CGRectMake(330*self.view.frame.size.width/375, 20, 35, 35);
    [searchBtn setImage:[UIImage imageNamed:@"recommendBtn6"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationV addSubview:searchBtn];
//    UIButton *SBtn =[[UIButton buttonWithType:UIButtonTypeCustom]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [SBtn setImage:[UIImage imageNamed:@"recommendBtn6"] forState:UIControlStateNormal];
    
}

-(void)searchClick
{
    SearchViewController *svc =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}


-(void)choose:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        NSLog(@"11");
        
    }else if (sender.selectedSegmentIndex ==1)
    {
        NSLog(@"22");
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
