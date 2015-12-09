//
//  aboutUsViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/6.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "aboutUsViewController.h"

@interface aboutUsViewController ()

@end

@implementation aboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav];
    [self CreartMain];
}

-(void)initNav
{
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBarHidden =YES;
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    //    view.backgroundColor =[UIColor colorWithRed:0.290 green:0.786 blue:1.000 alpha:1.000];
   
    
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:view.frame];
    [imgV setImage:[UIImage imageNamed:@"111"]];
    [view addSubview:imgV];
    [self.view addSubview:view];
    
    UILabel *lab =[[UILabel alloc]init];
    lab.text =@"关于我们";
    lab.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    lab.font =[UIFont systemFontOfSize:20];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    [imgV addSubview:lab];
    UIButton *backBtn =[[UIButton alloc]init];
    [backBtn setFrame:CGRectMake(20, 30, 40,30)];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)CreartMain
{
    UILabel *aboutUsLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    aboutUsLab.center =self.view.center;
    aboutUsLab.text =@"狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n狼💗羊,老婆我爱你\n";
    aboutUsLab.textAlignment =NSTextAlignmentCenter;
    aboutUsLab.numberOfLines =0;
    [self.view addSubview:aboutUsLab];
    
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
