//
//  ClassifyViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "ClassifyViewController.h"
#import "customView.h"
#import "chooseViewController.h"
@interface ClassifyViewController ()

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect = CGRectMake(0, 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);

    UIImageView *dog =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.38, self.view.frame.size.height)];
    dog.image =[UIImage imageNamed:@"cat"];
    [self.view addSubview:dog];
    UILabel *dogLab =[[UILabel alloc]initWithFrame:CGRectMake(30, 200, 170, 150)];
    dogLab.text =@"快推回去,~~(>_<)~~ ";
    dogLab.textColor =[UIColor whiteColor];
    [dog addSubview:dogLab];
    
    UILabel *dogLab2 =[[UILabel alloc]initWithFrame:CGRectMake(15, 150, 210, 150)];
    dogLab2.text =@"被发现了...这里还没做好啦";
    dogLab2.textColor =[UIColor whiteColor];
    [dog addSubview:dogLab2];
    
    
    UIView *contentView = [[UIView alloc] initWithFrame:rect];
    contentView.backgroundColor =[UIColor whiteColor];
    
    customView *pushView = [[customView alloc]initWithView:contentView parentView:self.view];
        [[pushView layer] setShadowOffset:CGSizeMake(10, 10)];
        [[pushView layer] setShadowRadius:20];
        [[pushView layer] setShadowOpacity:1];
        [[pushView layer] setShadowColor:[UIColor blackColor].CGColor];
        
        [self.view addSubview:pushView];
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, pushView.bounds.size.width, 64)];
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:view.frame];
    [imgV setImage:[UIImage imageNamed:@"111"]];
    imgV.userInteractionEnabled =YES;
    [view addSubview:imgV];
    [pushView addSubview:view];
    
    UIImageView *imgVb =[[UIImageView alloc]initWithFrame:CGRectMake(0, (pushView.frame.size.height-64)/2, 5, 70)];
    imgVb.image =[UIImage imageNamed:@"111"];
    [pushView addSubview:imgVb];
    
    
    self.navigationController.navigationBarHidden =YES;
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [pushView addSubview:navigationV];
    
    
    UILabel *title =[[UILabel alloc]init];
    title.text =@"分类";
    title.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    title.font =[UIFont systemFontOfSize:20];
    title.textAlignment =NSTextAlignmentCenter;
    title.textColor =[UIColor whiteColor];
    [navigationV addSubview:title];
    NSArray *switchArr =@[@"冒险",@"搞笑",@"格斗",@"科幻",@"爱情",@"侦探",@"竞技",@"魔法",@"东方神鬼",@"校园",@"恐怖",@"其他"];
    
    for (int i =0; i<12; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(ClassViewClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag =54+i;
        btn.frame =CGRectMake(20+self.view.frame.size.width/3*(i%3), 64+15+(self.view.frame.size.width/3)*(i/3), self.view.frame.size.width/3-35, self.view.frame.size.width/3-35);
        btn.backgroundColor =[UIColor colorWithRed:0.05*i green:0.05*i blue:0.05*i alpha:i];
        UILabel *nameLab =[[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x,btn.frame.origin.y+btn.frame.size.height+5,btn.frame.size.width,20)];
        nameLab.text =[NSString stringWithFormat:@"%@",switchArr[i]];
        nameLab.textColor =[UIColor orangeColor];
        nameLab.textAlignment =NSTextAlignmentCenter;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+7800]] forState:UIControlStateNormal];
        [pushView addSubview:nameLab];
        [pushView addSubview:btn];
    }
}

-(void)ClassViewClick:(UIButton *)sender
{
    chooseViewController *cvc =[[chooseViewController alloc]init];
    cvc.lei =sender.tag;
    
    [self.navigationController pushViewController:cvc animated:YES];
}
    
-(void)configUI
{


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
