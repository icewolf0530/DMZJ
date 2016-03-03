//
//  SearchViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "SearchViewController.h"
#import "searchLabModel.h"
#import "searchResultViewController.h"

//#import "RecommendViewController.h"
#define search_API(ziduan) @"http://api.dmzj.com/dynamic/comicsearch/(ziduan).json?channel=ios&version=1.1.107"
@interface SearchViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    searchLabModel *slModel;
    UIScrollView *ScrV;
    searchResultViewController *srvc;
    
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHttpData];
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
    tf.delegate =self;
    tf.returnKeyType =UIReturnKeySearch;
//    [tf addTarget:self action:@selector(searchResult) forControlEvents:UIControlEventEditingChanged];
    
    
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
    img.image =[UIImage imageNamed:@"recommendBtn6"];
    tf.leftView =img;
    tf.leftViewMode =UITextFieldViewModeAlways;
    tf.contentMode =UIViewContentModeCenter;
    [view addSubview:tf];
    
    
    
    ScrV =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    ScrV.backgroundColor =[UIColor whiteColor];
    ScrV.contentSize =CGSizeMake(self.view.bounds.size.width, 700+slModel.seaLabData.count/3*30);
    NSLog(@"~~~~~~%f",ScrV.frame.size.height);
    NSLog(@"~~~##%F",ScrV.contentSize.height);
    ScrV.directionalLockEnabled =YES;
    ScrV.showsVerticalScrollIndicator = NO;
    ScrV.showsHorizontalScrollIndicator = NO;
    ScrV.delegate =self;
    
    UILabel *Hotlab =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 20)];
    Hotlab.text =@"热门搜索";
    Hotlab.textAlignment =NSTextAlignmentCenter;
    Hotlab.textColor =[UIColor grayColor];
    [ScrV addSubview:Hotlab];
    
    [self.view addSubview:ScrV];

    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
}

-(void)searchResult
{

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    srvc =[[searchResultViewController alloc]init];
    srvc.searchText =textField.text;
    [self.navigationController pushViewController:srvc animated:YES];
    return YES;
    
}


-(void)getHttpData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://api.dmzj.com/dynamic/comicsearchhot.json?channel=ios&version=1.1.107" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        slModel =[[searchLabModel alloc]mj_setKeyValues:operation.responseString];
        NSLog(@"%@",slModel);
        for (int i =0; i<slModel.seaLabData.count; i++) {
//            NSLog(@"~~~~~%ld",slModel.data.count);
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectMake(10+self.view.frame.size.width/3*(i%3),50+35*(i/3), self.view.frame.size.width/3-20, 30);
           
            searchData *sdate =slModel.seaLabData[i];
            [btn setTitle:[NSString stringWithFormat:@"%@",sdate.name] forState:UIControlStateNormal];
            btn.tag =sdate.Id;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(searchHotClick:) forControlEvents:UIControlEventTouchUpInside];
//            btn.backgroundColor =[UIColor colorWithRed:0.276 green:0.733 blue:1.000 alpha:1.000];
            if(i%4==0)
            {
                btn.backgroundColor =[UIColor orangeColor];
            }
            if (i%4==1) {
                btn.backgroundColor =[UIColor blueColor];
            }
            if (i%4==2) {
                btn.backgroundColor =[UIColor redColor];
            }
            if (i%4==3) {
                btn.backgroundColor =[UIColor greenColor];
            }
            
            
            [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            
            [ScrV addSubview:btn];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}








-(void)searchHotClick:(UIButton *)sender
{
    detailsViewController *dvc =[[detailsViewController alloc]init];
    dvc.ID =sender.tag;
    [self.navigationController pushViewController:dvc animated:YES];
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
