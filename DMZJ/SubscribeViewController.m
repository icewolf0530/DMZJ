//
//  SubscribeViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SearchViewController.h"
#import "fastNewTableViewCell.h"
#import "fastNewModel.h"
@interface SubscribeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSMutableArray *ADLBarr;
    ADmodel *adModel;
    ADLBView *adV;
    UITableView *TableView;
    fastNewModel *fNModel;
    NSMutableArray *fnArr;
}
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
    

    UILabel *lab =[[UILabel alloc]init];
    lab.text =@"快讯";
    lab.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    lab.font =[UIFont systemFontOfSize:20];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    [navigationV addSubview:lab];
//    UISegmentedControl *Sc =[[UISegmentedControl alloc]initWithItems:@[@"订阅",@"浏览记录"]];
//    Sc.frame =CGRectMake(self.view.frame.size.width/2-75, 25, 150,35);
//    Sc.backgroundColor =[UIColor colorWithRed:0.290 green:0.786 blue:1.000 alpha:1.000];
//    Sc.momentary =NO;
//    Sc.tintColor =[UIColor whiteColor];
//    Sc.selectedSegmentIndex = 0;
//    
//    [Sc addTarget:self action:@selector(choose:) forControlEvents:UIControlEventValueChanged];
//    [navigationV addSubview:Sc];
    
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame =CGRectMake(330*self.view.frame.size.width/375, 20, 35, 35);
    [searchBtn setImage:[UIImage imageNamed:@"recommendBtn6"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationV addSubview:searchBtn];
//    [self getHttpData];
    [self getHttpData];
    [self getHttpNewsdata];

    [self configScrollViewAndTableView];
}

-(void)configScrollViewAndTableView
{
    
    
    TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    TableView.bounces =NO;
    TableView.delegate =self;
    TableView.dataSource =self;
    
    [self.view addSubview:TableView];
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    return adV;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200*self.view.frame.size.height/667;
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (fnArr) {
        
        return fnArr.count;
        
    }
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDfine =@"adadad";
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDfine];
    
    
    if (fnArr) {
        if(indexPath.row ==0)
        {
            [cell addSubview:adV];
        }
        else
        {
        fastNewModel *sbsbs =fnArr[indexPath.row-1];
        
       UIImageView *iconView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 30, 30)];
       UILabel *nameLab =[[UILabel alloc]initWithFrame:CGRectMake(40, 10, 150, 30)];
        UILabel * updateTime =[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.size.width-60, 10, 100, 30)];
       UILabel *contentLab =[[UILabel alloc]initWithFrame:CGRectMake(5, 50,TableView.frame.size.width/2-10, 250*[UIScreen mainScreen].bounds.size.height/667)];
       UIImageView * imgView =[[UIImageView alloc]initWithFrame:CGRectMake(TableView.frame.size.width/2+5, 50, TableView.frame.size.width/2-10, 250*[UIScreen mainScreen].bounds.size.height/667)];
        
        [iconView setImageWithURL:[NSURL URLWithString:sbsbs.cover]];
        nameLab.text =sbsbs.nickname;
        updateTime.text =[NSString stringWithFormat:@"%ld",sbsbs.updatetime];
        
        contentLab.text =sbsbs.content;
        contentLab.numberOfLines =0;
            contentLab.font =[UIFont systemFontOfSize:17*[UIScreen mainScreen].bounds.size.height/667];
        [imgView setImageWithURL:[NSURL URLWithString:sbsbs.img]];
        
        [cell addSubview:iconView];
        [cell addSubview:nameLab];
        [cell addSubview:updateTime];
        [cell addSubview:contentLab];
        [cell addSubview:imgView];
        }
        
    }
    return cell;
    
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (fnArr) {
        if (indexPath.row ==0) {
            return 200*[UIScreen mainScreen].bounds.size.height/667;
        }
        else{
        return 320*[UIScreen mainScreen].bounds.size.height/667;
        }
    }
    return 100;
}



-(void)getHttpNewsdata
{
    fnArr =[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:@"http://v2.api.dmzj.com/message/list/0.json?channel=ios&version=2.0.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *list = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in list) {
            fNModel =[[fastNewModel alloc]mj_setKeyValues:dic];
            [fnArr addObject:fNModel];
        }
        [TableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


-(void)searchClick
{
    SearchViewController *svc =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}


//-(void)choose:(UISegmentedControl *)sender
//{
//    if (sender.selectedSegmentIndex==0)
//    {
//        NSLog(@"11");
//        
//    }else if (sender.selectedSegmentIndex ==1)
//    {
//        NSLog(@"22");
//    }
//}


-(void)getHttpData
{
    ADLBarr =[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:@"http://v2.api.dmzj.com/article/recommend/header.json?channel=ios&version=2.0.1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        adModel =[[ADmodel alloc]mj_setKeyValues:operation.responseString];
        for (ADdata *arr in adModel.data)
        {
            UIImage *img =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr.pic_url]]];
        [ADLBarr addObject:img];
        }
        CGRect i =CGRectMake(0, 0, self.view.frame.size.width, 200*self.view.frame.size.height/667);
        adV =[[ADLBView alloc]initWithFrame:i withImages:ADLBarr withCallBack:^(NSInteger chooseIndex) {
                
            }];
         
            adV.boardColor =[UIColor orangeColor];
//            [backGroundScr addSubview:adV];
         [TableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
