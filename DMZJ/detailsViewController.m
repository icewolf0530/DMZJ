//
//  detailsViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/24.
//  Copyright (c) 2015年 wolf. All rights reserved.
//

#import "detailsViewController.h"
#import "detailsCharteViewCell.h"
@interface detailsViewController ()<UIScrollViewDelegate>
{
    
    detailsModel *detModel;
    UILabel *title;
    UIScrollView *ScrV;
    UIImageView *imgV;
    UILabel *authors;
    UILabel *zone;
    UILabel *status;
    UILabel *last_update_chapter_name;
    UILabel *description;
    NSInteger listNum;
    UITableView *backgroundtable;
    detailsCharteViewCell *detailscharteView;
    
}
@end

@implementation detailsViewController

- (void)viewDidLoad {
    [self getData];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBarHidden =NO;
    self.navigationItem.leftBarButtonItem.title =@"返回";
    
    
    [self initNavigationBar];
    
    [self creartUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self hidden];

    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self showTabBar];
}

-(void)hidden
{
   
        if (self.tabBarController.tabBar.hidden == YES) {
            return;
        }
        UIView *contentView;
        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
        else
            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
        self.tabBarController.tabBar.hidden = YES;
        
    
}

- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}


-(void)initNavigationBar
{
    self.navigationController.navigationBarHidden =YES;
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [self.view addSubview:navigationV];
    
    title =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44)];
    title.font =[UIFont systemFontOfSize:20];
    title.textAlignment =NSTextAlignmentCenter;
    title.textColor =[UIColor whiteColor];
    [navigationV addSubview:title];
    
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(5, 25, 50, 35)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationV addSubview:backBtn];
}



-(void)creartUI
{
    ScrV =[[UIScrollView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.bounds.size.height)];
    ScrV.backgroundColor =[UIColor whiteColor];
    ScrV.contentSize =CGSizeMake(self.view.bounds.size.width, 500+detModel.data.similar.count/3*30);
    NSLog(@"~~~~~~%f",ScrV.frame.size.height);
    NSLog(@"~~~##%F",ScrV.contentSize.height);
    ScrV.directionalLockEnabled =YES;
    ScrV.showsVerticalScrollIndicator = NO;
    ScrV.showsHorizontalScrollIndicator = NO;
    ScrV.delegate =self;
    [self.view addSubview:ScrV];
    
    imgV =[[UIImageView alloc]initWithFrame:CGRectMake(15*self.view.frame.size.width/375, 15, 90*self.view.frame.size.width/375, 120)];
    
    [ScrV addSubview:imgV];
    
    authors =[[UILabel alloc]initWithFrame:CGRectMake(115*self.view.frame.size.width/375, 15, 150, 15)];
    authors.font =[UIFont systemFontOfSize:13];
    authors.textColor =[UIColor grayColor];
    [ScrV addSubview:authors];
    
    zone =[[UILabel alloc]initWithFrame:CGRectMake(115*self.view.frame.size.width/375,35,150,15)];
    zone.font =[UIFont systemFontOfSize:13];
    zone.textColor =[UIColor grayColor];
    [ScrV addSubview:zone];
    
    status =[[UILabel alloc]initWithFrame:CGRectMake(115*self.view.frame.size.width/375, 55, 150, 15)];
    status.font =[UIFont systemFontOfSize:13];
    status.textColor =[UIColor grayColor];
    [ScrV addSubview:status];
    
    last_update_chapter_name =[[UILabel alloc]initWithFrame:CGRectMake(115*self.view.frame.size.width/375, 75, 150, 15)];
    last_update_chapter_name.font =[UIFont systemFontOfSize:13];
    last_update_chapter_name.textColor =[UIColor grayColor];
    [ScrV addSubview:last_update_chapter_name];
    
    UIButton *markBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [markBtn setFrame:CGRectMake(115*self.view.frame.size.width/375, 100, 110*self.view.frame.size.width/375, 35)];
    [markBtn setBackgroundImage:[UIImage imageNamed:@"pub_downloadSortBg"] forState:UIControlStateNormal];
    [markBtn setTitle:@"添加订阅" forState:UIControlStateNormal];
    
    [markBtn addTarget:self action:@selector(markClick) forControlEvents:UIControlEventTouchUpInside];
    [ScrV addSubview:markBtn];
    
    UIButton *readBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [readBtn setFrame:CGRectMake(240*self.view.frame.size.width/375, 100, 110*self.view.frame.size.width/375, 35)];
    [readBtn setBackgroundImage:[UIImage imageNamed:@"pub_downloadSortBg"] forState:UIControlStateNormal];
    [readBtn setTitle:@"开始阅读" forState:UIControlStateNormal];
    [readBtn addTarget:self action:@selector(readClick) forControlEvents:UIControlEventTouchUpInside];
    [ScrV addSubview:readBtn];
    
    description =[[UILabel alloc]initWithFrame:CGRectMake(15, 140, (ScrV.frame.size.width-10)*self.view.frame.size.width/375, 70)];
    description.numberOfLines =0;

    [ScrV addSubview:description];
}
-(void)backClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)readClick
{
    ReaderViewController *rvc =[[ReaderViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}
-(void)markClick
{

}

-(void)getData
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"http://api.dmzj.com/dynamic/comicinfo/%ld.json?channel=ios&version=1.1.107",_ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        detModel =[[detailsModel alloc]mj_setKeyValues:operation.responseString];
        [imgV setImageWithURL:[NSURL URLWithString:detModel.data.info.cover]];
        authors.text=[NSString stringWithFormat:@"作者:%@",detModel.data.info.authors];
        zone.text =[NSString stringWithFormat:@"地域:%@",detModel.data.info.zone];
        status.text =[NSString stringWithFormat:@"状态:%@",detModel.data.info.status];
        description.text =detModel.data.info.Description;
        
        last_update_chapter_name.text =[NSString stringWithFormat:@"最新更新:%@", detModel.data.info.last_update_chapter_name];
        
        
        title.text =detModel.data.info.title;
        NSLog(@"========%ld",detModel.data.list.count);
        for (int i =0 ; i<detModel.data.list.count; i++) {
            detailscharteView =[[detailsCharteViewCell alloc]init];
            detailscharteView.frame =CGRectMake(10+ScrV.frame.size.width/4*(i%4), 230+35*(i/4), ScrV.frame.size.width/4-20, 30);
//            detailscharteView.backgroundColor =[UIColor redColor];
            detailscharteView.userInteractionEnabled =YES;
            listDetails *listModel =detModel.data.list[i];
            
            detailscharteView.charpte_btn.frame =CGRectMake(0, 0, ScrV.frame.size.width/4-20, 30);
            [detailscharteView.charpte_btn setTitle:listModel.chapter_name forState:UIControlStateNormal];
            [detailscharteView.charpte_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [detailscharteView.charpte_btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [detailscharteView.charpte_btn addTarget:self action:@selector(startReadClick:) forControlEvents:UIControlEventTouchUpInside];
            detailscharteView.charpte_btn.tag =[listModel.ID integerValue];
            
            [ScrV addSubview:detailscharteView];
        }
//
            ScrV.contentSize=CGSizeMake(self.view.bounds.size.width, 250+detModel.data.list.count/3*30);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}



-(void)startReadClick:(UIButton *)sender
{
    NSLog(@"111");
    ReaderViewController *rvc =[[ReaderViewController alloc]init];
    rvc.COMICID =sender.tag;
    NSLog(@"%ld",sender.tag);
    rvc.ID =_ID;
    NSLog(@"%ld",_ID);
    [self.navigationController pushViewController:rvc animated:YES];
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
