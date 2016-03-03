//
//  searchResultViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/24.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "searchResultViewController.h"
#import "searchResultModel.h"
#import "detailsViewController.h"
@interface searchResultViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    searchResultModel *sRmodel;
    UITableView *searchTableV;
 
}
@end

@implementation searchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initUI];
    [self getHttpData];
    
}



-(void)initUI
{
   
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
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIButton *backBtn =[[UIButton alloc]init];
    [backBtn setFrame:CGRectMake(10, 30, 40,30)];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationV addSubview:backBtn];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)getHttpData
{
    
    NSString *url =[_searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"http://api.dmzj.com/dynamic/comicsearch/%@.json?channel=ios&version=1.1.107",url] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sRmodel =[[searchResultModel alloc]mj_setKeyValues:operation.responseString];
        NSLog(@"%@",sRmodel);
        [self createTableView];
        [searchTableV reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)createTableView
{
    searchTableV =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
//    searchTableV.backgroundColor =[UIColor yellowColor];
    searchTableV.delegate =self;
    searchTableV.dataSource =self;
    if (sRmodel.seaData.count>=1) {
    
    [self.view addSubview:searchTableV];
    }
    else
    {
        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
        lab.center =self.view.center;
        lab.text =@"没有找到您要东西呢\n~~~~(>_<)~~~~ ";
        lab.textAlignment =NSTextAlignmentCenter;
        lab.numberOfLines =0;
        [self.view addSubview:lab];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *dvc =[[detailsViewController alloc]init];
    resultData* model =sRmodel.seaData[indexPath.row];
    dvc.ID =model.Id;
    [self.navigationController pushViewController:dvc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (sRmodel.seaData) {
        return sRmodel.seaData.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (sRmodel) {
        return 170;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CELLID =@"wocaonima";
    
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    
    UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 100, 150)];
    
    
    UILabel *nameLab =[[UILabel alloc]initWithFrame:CGRectMake(130, 15, 200, 30)];
    nameLab.text =@"cao";
//    nameLab.backgroundColor =[UIColor blueColor];
    
    
    UILabel *arther =[[UILabel alloc]initWithFrame:CGRectMake(130, 50, 200, 30)];
    arther.text =@"作者:";
    
    UILabel *style =[[UILabel alloc]initWithFrame:CGRectMake(130, 85, 200, 30)];
    style.text =@"类型:";
    
    UILabel *last_data =[[UILabel alloc]initWithFrame:CGRectMake(130, 120, 200, 30)];
    last_data.text =@"最后更新:";
    
    [cell addSubview:img];
    [cell addSubview:nameLab];
    [cell addSubview:arther];
    [cell addSubview:style];
    [cell addSubview:last_data];
    
    if (sRmodel) {
        
        
        resultData* model =sRmodel.seaData[indexPath.row];
        nameLab.text =model.title;
        
        [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover]]];
        
        arther.text =[NSString stringWithFormat:@"作者:%@",model.authors];
        
        style.text =[NSString stringWithFormat:@"类型:%@",model.types];
        
        last_data.text =[NSString stringWithFormat:@"最后更新:%@",model.last_update_chapter_name];

    }
    
    
    return cell;
    
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
