//
//  tabBarViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "tabBarViewController.h"

@interface tabBarViewController ()

@end

@implementation tabBarViewController

- (void)viewDidLoad {
    
    
    
    
    [super viewDidLoad];
    [self initTabBarItem];
    self.navigationController.navigationBar.backgroundColor=[UIColor blueColor];
    // Do any additional setup after loading the view.
}

-(void)initTabBarItem
{
    NSArray *name =@[@"pub_classify",@"pub_recommend",@"pub_favouriate",@"pub_download",@"pub_more"];
    
    NSArray *title =@[@"分类",@"推荐",@"快讯",@"下载",@"更多"];
    int i =0;
    
    
    for (UINavigationController *nav in self.viewControllers) {
         UIViewController *vc =nav.viewControllers.firstObject;
        
        NSString *itemName =name[i];
        NSString *itemImageName =[NSString stringWithFormat:@"%@",itemName];
        NSString *itemSelectedName =[NSString stringWithFormat:@"%@Selected",itemName];
        
        UIImage *itemImage =[UIImage imageNamed:itemImageName];
        UIImage *selectedImage =[UIImage imageNamed:itemSelectedName];
//        去掉渲染
        itemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //渲染后的图片添加到tabbar Item
        vc.tabBarItem =[[UITabBarItem alloc]initWithTitle:title[i] image:[UIImage imageNamed:itemImageName] selectedImage:[UIImage imageNamed:itemSelectedName]];
        
        i++;
    }
    self.tabBar.tintColor =[UIColor colorWithRed:0.290 green:0.786 blue:1.000 alpha:1.000];
    
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
