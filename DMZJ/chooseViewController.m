//
//  chooseViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/7.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "chooseViewController.h"
#import "chooseModel.h"
#define CHOOSE_API @"http://api.dmzj.com/dynamic/comicclassify/update/54/0.json?channel=ios&version=1.1.107"
@interface chooseViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILabel *lab;
    chooseModel *cModel;
    choosedata *cdata;
    NEWCollectionViewCell *cell;
    UIScrollView *ScrV ;
    UIView *line;
    UICollectionView *DMC;
    
}
@property (nonatomic,strong)NSMutableArray *List;
@end

@implementation chooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self configUI];
    [self getHttpDate];
}


-(void)configUI
{
    
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [self.view addSubview:navigationV];
    
    
    lab =[[UILabel alloc]init];
    
    lab.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    lab.font =[UIFont systemFontOfSize:20];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    [navigationV addSubview:lab];
    
    UIButton *backBtn =[[UIButton alloc]init];
    [backBtn setFrame:CGRectMake(20, 30, 40,30)];
    
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navigationV addSubview:backBtn];
    
    ScrV =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 700)];
    ScrV.backgroundColor =[UIColor colorWithWhite:0.927 alpha:1.000];
    ScrV.contentSize =CGSizeMake(self.view.bounds.size.width*5, 700);
    ScrV.bounces =NO;
    ScrV.directionalLockEnabled =YES;
    ScrV.showsVerticalScrollIndicator = NO;
    ScrV.showsHorizontalScrollIndicator = NO;
    ScrV.pagingEnabled =YES;
    ScrV.delegate =self;
    
   
        
        UICollectionViewFlowLayout *DMLay =[[UICollectionViewFlowLayout alloc]init];
        DMLay.sectionInset =UIEdgeInsetsMake(10, 15, 10, 15);
        DMLay.itemSize =CGSizeMake(100*self.view.bounds.size.width/375, 170*self.view.bounds.size.height/667);
        DMLay.minimumInteritemSpacing =10;
        DMLay.minimumLineSpacing =10;
        
        DMC =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:DMLay];
        
        [DMC registerClass:[NEWCollectionViewCell class] forCellWithReuseIdentifier:@"newCell"];
        DMC.delegate =self;
        DMC.dataSource =self;
        DMC.backgroundColor =[UIColor whiteColor];

        
        [ScrV addSubview:DMC];
    
    [self.view addSubview:ScrV];

}

-(void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cModel.Arrdata.count;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{   static NSString *NEWCELL =@"newCell";
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:NEWCELL forIndexPath:indexPath];
    
        cdata=cModel.Arrdata[indexPath.row];
        cell.nameID =cdata.Id;
        cell.title.text =cdata.title;
        cell.lastUpdate.text =cdata.last_update_chapter_name;
        NSString *imgUrl =[cdata.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImgView setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"IMG_0007.jpg"]];
        
        [cell addSubview:cell.title];
        [cell.coverImgView addSubview:cell.lastUpdate];
        [cell addSubview:cell.coverImgView];
        return cell;

        
    
    
}

//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   detailsViewController *dvc =[[detailsViewController alloc]init];
    NSLog(@"%ld",indexPath.row);
        choosedata * cdata1 = _List[indexPath.row];
    
        dvc.ID = cdata1.Id ;
        NSLog(@"recID%ld",cdata1.Id);
        [self.navigationController pushViewController:dvc animated:YES];
    
    
    
}
//

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)getHttpDate
{
    _List =[NSMutableArray array];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:CHOOSE_API] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        cModel=[[chooseModel alloc]mj_setKeyValues:operation.responseString];
        [_List addObject:cModel.Arrdata];
        [DMC reloadData];
        cdata =cModel.Arrdata[1];
        lab.text =cdata.types;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
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
