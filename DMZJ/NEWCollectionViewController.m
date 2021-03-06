//
//  NEWCollectionViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/28.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "NEWCollectionViewController.h"
#import "NEWCollectionViewCell.h"
@interface NEWCollectionViewController ()
{

    model *mymodel;
    
}
@end

@implementation NEWCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.view.bounds =CGRectMake(0, 0, 375, 660);
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset =UIEdgeInsetsMake(10, 15, 10, 15);
    layout.itemSize =CGSizeMake(100*self.view.bounds.size.width/375, 170*self.view.bounds.size.height/667);
    layout.minimumInteritemSpacing =10;
    layout.minimumLineSpacing =10;
    layout.headerReferenceSize=CGSizeMake(self.view.bounds.size.width, 180*self.view.bounds.size.height/667);
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 700) collectionViewLayout:layout];
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    self.collectionView.backgroundColor =[UIColor whiteColor];
//    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[NEWCollectionViewCell class] forCellWithReuseIdentifier:@"newCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"newHeadline"];
    // Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NEWCELL =@"newCell";
    NEWCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NEWCELL forIndexPath:indexPath];

    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerCell =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"newHeadline" forIndexPath:indexPath ];
    
    headerCell.frame=CGRectMake(0, 0, self.view.bounds.size.width, 180*self.view.bounds.size.height/667);
    headerCell.userInteractionEnabled =YES;
    
    
    
    UIImageView *imgV =[[UIImageView alloc]initWithFrame:headerCell.bounds];
    NSString *img =[mymodel.MyNew.headlines.cover stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [imgV setImageWithURL:[NSURL URLWithString:img]];
    
    imgV.userInteractionEnabled =YES;
    
    
    UILabel *TitleAndSubTitle =[[UILabel alloc]initWithFrame:CGRectMake(0, 150*self.view.bounds.size.height/667, self.view.bounds.size.width, 20)];
    TitleAndSubTitle.backgroundColor=[UIColor colorWithWhite:0.852 alpha:0.570];
    TitleAndSubTitle.text =[NSString stringWithFormat:@"    <%@> %@",mymodel.MyNew.headlines.title,mymodel.MyNew.headlines.subtitle];
    
    TitleAndSubTitle.textColor=[UIColor whiteColor];
    
    TitleAndSubTitle.font =[UIFont systemFontOfSize:13];
    [headerCell addSubview:imgV];
    [headerCell addSubview:TitleAndSubTitle];

    
    return headerCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
