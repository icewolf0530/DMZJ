//
//  RecommendViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "RecommendViewController.h"
#import "NEWCollectionViewController.h"

@interface RecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    model *mymodel;
    
    UICollectionView *DMCollection;
    UIView *headLine;
    NEWCollectionViewCell *cell;
    UIScrollView *ScrV ;
    UIView *line;
    epiDetail * epiModel;
}
@property (nonatomic,strong)NSMutableArray *indexList;
@property (nonatomic,strong)NSMutableArray *myNewList;
@property (nonatomic,strong)NSMutableArray *lianzaiList;
@property (nonatomic,strong)NSMutableArray *wanjieList;
@property (nonatomic,strong)NSMutableArray *yuanchuangList;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBarButton];
    [self getHttpData];
    [self configUI];
    
}

-(void)initNavigationBarButton
{   line =[[UIView alloc]initWithFrame:CGRectMake(10, 60, self.view.bounds.size.width/6, 10)];
    line.backgroundColor=[UIColor colorWithRed:0.176 green:0.433 blue:1.000 alpha:1.000];
    
    
    self.navigationController.navigationBarHidden =YES;
    NSArray *nameArr =@[@"推荐",@"最新",@"连载",@"完结",@"原创",@""];
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:view.frame];
    [imgV setImage:[UIImage imageNamed:@"111"]];
    imgV.userInteractionEnabled =YES;
    [view addSubview:imgV];
    
    [self.view addSubview:view];
    for (int i=0; i<6; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(10+self.view.bounds.size.width/6*i, 25, self.view.bounds.size.width/6, 40);
        if (i==5) {
            btn.frame =CGRectMake(20+self.view.bounds.size.width/6*i, 35, 20, 20);
            [btn setBackgroundImage:[UIImage imageNamed:@"recommendBtn6"] forState:UIControlStateNormal];
        }
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:20];
//        UIImage *img =[UIImage imageNamed:[NSString stringWithFormat:@"recommendBtn%d",i+1]];
//        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"recommendSelectBar"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag =10000+i;
        [imgV addSubview:btn];
    }
    
    [imgV addSubview:line];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int i =ScrV.contentOffset.x/self.view.frame.size.width;
    line.frame=CGRectMake(10+self.view.bounds.size.width/6*i, 60, self.view.bounds.size.width/6, 10);
}

-(void)btnClick:(UIButton *)sender
{
    if(sender.tag ==10000)
    {
        ScrV.contentOffset =CGPointMake(0, 0);
        line.frame=CGRectMake(10, 60, self.view.bounds.size.width/6, 10);
        UIButton *btn =[self.view viewWithTag:10000];
        btn.highlighted =YES;
        NSLog(@"跳到index");
        
    }
    if(sender.tag ==10001)
    {
        ScrV.contentOffset =CGPointMake(self.view.frame.size.width, 0);
        line.frame=CGRectMake(10+self.view.bounds.size.width/6, 60, self.view.bounds.size.width/6, 10);
        UIButton *btn =[self.view viewWithTag:10001];
        btn.highlighted =YES;
        NSLog(@"跳到new");
    }
    if(sender.tag ==10002)
    {
        ScrV.contentOffset =CGPointMake(self.view.frame.size.width*2, 0);
        line.frame=CGRectMake(10+self.view.bounds.size.width/6*2, 60, self.view.bounds.size.width/6, 10);
        UIButton *btn =[self.view viewWithTag:10002];
        btn.highlighted =YES;
        NSLog(@"跳到lianzai");
    }
    if(sender.tag ==10003)
    {
        ScrV.contentOffset =CGPointMake(self.view.frame.size.width*3, 0);
        line.frame=CGRectMake(10+self.view.bounds.size.width/6*3, 60, self.view.bounds.size.width/6, 10);
        UIButton *btn =[self.view viewWithTag:10003];
        btn.highlighted =YES;
        NSLog(@"跳到wanjie");
    }
    if(sender.tag ==10004)
    {
        ScrV.contentOffset =CGPointMake(self.view.frame.size.width*4, 0);
        line.frame=CGRectMake(10+self.view.bounds.size.width/6*4, 60, self.view.bounds.size.width/6, 10);
        UIButton *btn =[self.view viewWithTag:10004];
        btn.highlighted =YES;
        NSLog(@"跳到yuanchuang");
    }
    if(sender.tag ==10005)
    {
        SearchViewController *SVc =[[SearchViewController alloc]init];
        [self.navigationController pushViewController:SVc animated:YES];
    }
}

-(void)configUI
{
    ScrV =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 700)];
    ScrV.backgroundColor =[UIColor colorWithWhite:0.927 alpha:1.000];
    ScrV.contentSize =CGSizeMake(self.view.bounds.size.width*5, 700);
    ScrV.bounces =NO;
    ScrV.directionalLockEnabled =YES;
    ScrV.showsVerticalScrollIndicator = NO;
    ScrV.showsHorizontalScrollIndicator = NO;
    ScrV.pagingEnabled =YES;
    ScrV.delegate =self;
   
    for (int i =0; i<5; i++) {
    
        UICollectionViewFlowLayout *DMLay =[[UICollectionViewFlowLayout alloc]init];
        DMLay.sectionInset =UIEdgeInsetsMake(10, 15, 10, 15);
        DMLay.itemSize =CGSizeMake(100*self.view.bounds.size.width/375, 170*self.view.bounds.size.height/667);
        DMLay.minimumInteritemSpacing =10;
        DMLay.minimumLineSpacing =10;
        DMLay.headerReferenceSize=CGSizeMake(self.view.bounds.size.width, 180*self.view.bounds.size.height/667);
        
        UICollectionView *DMC =[[UICollectionView alloc]initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:DMLay];
        
        [DMC registerClass:[NEWCollectionViewCell class] forCellWithReuseIdentifier:@"newCell"];
        [DMC registerClass:[NEWheadlineCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headCell"];
        [DMC registerClass:[NEWheadlineCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footCell"];
        DMC.delegate =self;
        DMC.dataSource =self;
        DMC.backgroundColor =[UIColor whiteColor];
        DMC.tag =10000+i;
        [_DMArray addObject:DMC];
        [ScrV addSubview:DMC];
    }
    [self.view addSubview:ScrV];

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NEWheadlineCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headCell" forIndexPath:indexPath] ;
    headerView.userInteractionEnabled =YES;
    if (collectionView.tag == 10000) {
        headerView.Id =mymodel.index.headlines.Id;
        NSString *img =[mymodel.index.headlines.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [headerView.headView setImageWithURL:[NSURL URLWithString:img]];
        headerView.summary.text=[NSString stringWithFormat:@"    <%@> %@",mymodel.index.headlines.title,mymodel.index.headlines.subtitle];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [headerView addGestureRecognizer:tap];
        return headerView ;
        
    }else if (collectionView.tag == 10001)
        {
            headerView.Id =mymodel.MyNew.headlines.Id;
        NSString *img =[mymodel.MyNew.headlines.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [headerView.headView setImageWithURL:[NSURL URLWithString:img]];
        headerView.summary.text=[NSString stringWithFormat:@"    <%@> %@",mymodel.MyNew.headlines.title,mymodel.MyNew.headlines.subtitle];
        
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [headerView addGestureRecognizer:tap];
            return headerView ;
        }else if (collectionView.tag == 10002)
        {
            headerView.Id =mymodel.lianzai.headlines.Id;
            NSString *img =[mymodel.lianzai.headlines.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [headerView.headView setImageWithURL:[NSURL URLWithString:img]];
            headerView.summary.text=[NSString stringWithFormat:@"    <%@> %@",mymodel.lianzai.headlines.title,mymodel.lianzai.headlines.subtitle];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [headerView addGestureRecognizer:tap];
            return headerView ;
        }
        else if (collectionView.tag == 10003)
        {
            headerView.Id =mymodel.wanjie.headlines.Id;
            NSString *img =[mymodel.wanjie.headlines.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [headerView.headView setImageWithURL:[NSURL URLWithString:img]];
            headerView.summary.text=[NSString stringWithFormat:@"    <%@> %@",mymodel.wanjie.headlines.title,mymodel.wanjie.headlines.subtitle];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [headerView addGestureRecognizer:tap];
            return headerView ;
        }
        else
        {
            headerView.Id =mymodel.yuanchuang.headlines.Id;
            NSString *img =[mymodel.yuanchuang.headlines.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [headerView.headView setImageWithURL:[NSURL URLWithString:img]];
            headerView.summary.text=[NSString stringWithFormat:@"    <%@> %@",mymodel.yuanchuang.headlines.title,mymodel.yuanchuang.headlines.subtitle];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [headerView addGestureRecognizer:tap];
            return headerView ;
        }
}

-(void)click:(NEWheadlineCollectionReusableView *)sender
{
    detailsViewController *dvc =[[detailsViewController alloc]init];
//    dvc.ID =sender.Id;
    [self.navigationController pushViewController:dvc animated:YES];
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 99;
}
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{   static NSString *NEWCELL =@"newCell";
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:NEWCELL forIndexPath:indexPath];
    epiModel=[[epiDetail alloc]init];
    if (collectionView.tag ==10000) {
        epiModel=mymodel.index.episode[indexPath.row];
        cell.nameID =epiModel.Id;
        cell.title.text =epiModel.title;
        cell.lastUpdate.text =epiModel.last_update_chapter_name;
        NSString *imgUrl =[epiModel.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImgView setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"IMG_0007.jpg"]];
        
        [cell addSubview:cell.title];
        [cell.coverImgView addSubview:cell.lastUpdate];
        [cell addSubview:cell.coverImgView];
        return cell;
    }else if (collectionView.tag ==10001) {
        cell.nameID =epiModel.Id;
        epiModel=mymodel.MyNew.episode[indexPath.row];
        cell.title.text =epiModel.title;
        cell.lastUpdate.text =epiModel.last_update_chapter_name;
        NSString *imgUrl =[epiModel.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImgView setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"IMG_0007.jpg"]];
        
        [cell addSubview:cell.title];
        [cell.coverImgView addSubview:cell.lastUpdate];
        [cell addSubview:cell.coverImgView];
        return cell;
    }
    else if (collectionView.tag ==10002) {
        cell.nameID =epiModel.Id;
        epiModel=mymodel.lianzai.episode[indexPath.row];
        cell.title.text =epiModel.title;
        cell.lastUpdate.text =epiModel.last_update_chapter_name;
        NSString *imgUrl =[epiModel.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImgView setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"IMG_0007.jpg"]];
        
        [cell addSubview:cell.title];
        [cell.coverImgView addSubview:cell.lastUpdate];
        [cell addSubview:cell.coverImgView];
        return cell;
    }
    else if (collectionView.tag ==10003) {
        cell.nameID =epiModel.Id;
        epiModel=mymodel.wanjie.episode[indexPath.row];
        cell.title.text =epiModel.title;
        cell.lastUpdate.text =epiModel.last_update_chapter_name;
        NSString *imgUrl =[epiModel.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImgView setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"IMG_0007.jpg"]];
        
        [cell addSubview:cell.title];
        [cell.coverImgView addSubview:cell.lastUpdate];
        [cell addSubview:cell.coverImgView];
        return cell;
    }else
    {
        cell.nameID =epiModel.Id;
        epiModel=mymodel.yuanchuang.episode[indexPath.row];
        cell.title.text =epiModel.title;
        cell.lastUpdate.text =epiModel.last_update_chapter_name;
        NSString *imgUrl =[epiModel.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.coverImgView setImageWithURL:[NSURL URLWithString:imgUrl]placeholderImage:[UIImage imageNamed:@"IMG_0007.jpg"]];
        
        [cell addSubview:cell.title];
        [cell.coverImgView addSubview:cell.lastUpdate];
        [cell addSubview:cell.coverImgView];
        return cell;
    }
    
}

//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   detailsViewController *dvc =[[detailsViewController alloc]init];
    if (collectionView.tag == 10000) {
        epiDetail * epiModel1 = _indexList[indexPath.row];
        
        dvc.ID = [epiModel1.Id integerValue];
        NSLog(@"recID%ld",[epiModel1.Id integerValue]);
        [self.navigationController pushViewController:dvc animated:YES];
    }
    else
    if (collectionView.tag == 10001) {
        epiDetail * epiModel1 = _myNewList[indexPath.row];
        
        dvc.ID = [epiModel1.Id integerValue];
        [self.navigationController pushViewController:dvc animated:YES];
    }else
    if (collectionView.tag == 10002) {
        epiDetail * epiModel1 = _lianzaiList[indexPath.row];
        
        dvc.ID = [epiModel1.Id integerValue];
        [self.navigationController pushViewController:dvc animated:YES];
    }else
    if (collectionView.tag == 10003) {
        epiDetail * epiModel1 = _wanjieList[indexPath.row];
        
        dvc.ID = [epiModel1.Id integerValue];
        [self.navigationController pushViewController:dvc animated:YES];
    }else
    if (collectionView.tag == 10004) {
        epiDetail * epiModel1 = _yuanchuangList[indexPath.row];
        
        dvc.ID = [epiModel1.Id integerValue];
        [self.navigationController pushViewController:dvc animated:YES];
    }
    
}
//

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getHttpData
{
    _indexList = [NSMutableArray array];
    _myNewList = [NSMutableArray array];
    _lianzaiList = [NSMutableArray array];
    _wanjieList = [NSMutableArray array];
    _yuanchuangList = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:@"http://api.dmzj.com/dynamic/index.json?channel=ios&version=1.1.107" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        mymodel = [[model alloc]mj_setKeyValues:operation.responseString];
        for (epiDetail *model in mymodel.index.episode) {
            [_indexList addObject:model];
        }
        for (epiDetail *model2 in mymodel.MyNew.episode) {
            [_myNewList addObject:model2];
        }
        for (epiDetail *model3 in mymodel.lianzai.episode) {
            [_lianzaiList addObject:model3];
        }
        for (epiDetail *model4 in mymodel.wanjie.episode) {
            [_wanjieList addObject:model4];
        }
        for (epiDetail *model5 in mymodel.yuanchuang.episode) {
            [_yuanchuangList addObject:model5];
        }
        for (int i =0; i<5; i++) {
            
        
        UICollectionView *DM =[ScrV viewWithTag:10000+i];
        
        [DM reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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
