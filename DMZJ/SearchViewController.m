//
//  SearchViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "SearchViewController.h"
//#import "RecommendViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden =YES;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    //    view.backgroundColor =[UIColor colorWithRed:0.290 green:0.786 blue:1.000 alpha:1.000];
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:view.frame];
    [imgV setImage:[UIImage imageNamed:@"111"]];
    [view addSubview:imgV];
    [self.view addSubview:view];
    
    UIButton *backBtn =[[UIButton alloc]init];
    [backBtn setFrame:CGRectMake(self.view.bounds.size.width-50, 30, 40,30)];
 
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    
    UITextField *tf =[[UITextField alloc]initWithFrame:CGRectMake(5, 30, self.view.bounds.size.width-60, 30)];
    tf.backgroundColor =[UIColor colorWithRed:0.276 green:0.733 blue:1.000 alpha:1.000];
    tf.borderStyle =UITextBorderStyleRoundedRect;
    tf.tintColor =[UIColor whiteColor];
    tf.placeholder =@"漫画名/作者";
    
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 18, 18)];
    img.image =[UIImage imageNamed:@"recommendBtn6"];
    tf.leftView =img;
    tf.leftViewMode =UITextFieldViewModeAlways;
    [view addSubview:tf];
    
    
    
    UIImageView *searchHot =[[UIImageView alloc]initWithFrame:CGRectMake(-1, 100, self.view.frame.size.width, 402)];
    searchHot.image =[UIImage imageNamed:@"searchHot"];
    
    [self.view addSubview:searchHot];
    
    
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
}

-(void)back
{

    [self.navigationController popViewControllerAnimated:YES];

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
