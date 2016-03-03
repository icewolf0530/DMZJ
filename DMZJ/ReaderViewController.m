//
//  ReaderViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/2.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "ReaderViewController.h"

@interface ReaderViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    readModel *readmodel;
    UITableView *background;
    
    UIView *rotateView;
    UIImageView *headBar;
    UIImageView *backgroundImageView;
    UIImageView *footBar;
    UILabel *title;
    UISlider *pageSlider;
    UILabel *page;
    UIButton * light;
    UIButton * rotate;//旋转屏幕
    UIButton * readStyle;
    UISlider * changelightControl;
    NSIndexPath * nowIndexPath;
    BOOL isDrag;
    BOOL isInitallze;
    BOOL isGetData;
    //    显示/隐藏 Tool手势
    UITapGestureRecognizer * tap;
    NSTimer * timer;
    //    预读图片
    UIImageView * prereadPicture;
    UIAlertView * alert;
    
    NSMutableArray *sizeArr;
    NSMutableArray *arrImg;
    NSMutableArray *beforeArrImg;
}
@end

@implementation ReaderViewController

- (void)viewDidLoad {
//    [self getHttpDataWith];
    [super viewDidLoad];
    [self hidden];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    arrImg=[NSMutableArray array];
    [self configUI];
    NSLog(@"%ld,%ld",_ID,_COMICID);
    [self getHttpDataWith];
}

-(void)configUI
{

    background=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    background.backgroundColor =[UIColor whiteColor];
    background.delegate =self;
    background.dataSource =self;
//    background.frame = backgroundImageView.bounds;
//    background.separatorStyle = UITableViewCellSeparatorStyleNone;
//    background.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setToolBar];
    [backgroundImageView addSubview:background];

}


-(void)setToolBar
{
    rotateView =[[UIView alloc]init];
    rotateView.center =self.view.center;
    rotateView.bounds =[UIScreen mainScreen].bounds;
    [self.view addSubview:rotateView];
    
    backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.userInteractionEnabled = YES;
    
    backgroundImageView.frame = rotateView.bounds;
    //    添加手势
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show_orHiddenToolBar)];
    [backgroundImageView addGestureRecognizer:tap];
    
    [rotateView addSubview:backgroundImageView];
    
    headBar =[[UIImageView alloc]init];
    headBar.userInteractionEnabled =YES;
    headBar.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    headBar.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44) ;
    
    [rotateView addSubview:headBar];
    
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(5,5, 39, 39);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [headBar addSubview:backBtn];
    
    title =[[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 20)];
    title.center =headBar.center;
    title.font =[UIFont systemFontOfSize:17];
    title.textColor =[UIColor whiteColor];
    title.textAlignment =NSTextAlignmentCenter;
    title.text =@"nima";
    [headBar addSubview:title];
    
    footBar =[[UIImageView alloc]init];
    footBar.userInteractionEnabled =YES;
    footBar.frame =CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44);
    footBar.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    [rotateView addSubview:footBar];
    
    isDrag = NO;//初始设为no
    pageSlider = [[UISlider alloc]initWithFrame:CGRectMake(10, 5, 80, 24)];
    [pageSlider addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    pageSlider.minimumValue = 1;
//    [footBar addSubview:pageSlider];
    [pageSlider setThumbImage:[UIImage imageNamed:@"hd_icmpv_thumb_light"] forState:UIControlStateNormal];
    pageSlider.minimumTrackTintColor =[UIColor colorWithRed:72/255 green:136/255 blue:242/255 alpha:1];
//    RGB(72, 136, 242);
    page = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 70, 44)];
    page.font = [UIFont systemFontOfSize:14];
    page.textColor = [UIColor whiteColor];
//    [footBar addSubview:page];
    
//    light = [[UIButton alloc]init];
//    light.frame =CGRectMake(0, 100, 40, 40);
//    light.backgroundColor =[UIColor yellowColor];
//    [footBar addSubview:light];
//    
//    [light setImage:[UIImage imageNamed:@"config_light"] forState:UIControlStateNormal];
//    [light addTarget:self action:@selector(showChangelightControl) forControlEvents:UIControlEventTouchUpInside];
//    light.selected = NO;
//    light.hidden = YES;
    //    转屏按钮
    rotate = [[UIButton alloc]initWithFrame:CGRectMake(250, 0, 44, 44)];
    [footBar addSubview:rotate];
    rotate.translatesAutoresizingMaskIntoConstraints = NO;
//    rotate.backgroundColor =[UIColor yellowColor];
    [rotate setImage:[UIImage imageNamed:@"read_orientationSelect"] forState:UIControlStateNormal];
    [rotate addTarget:self action:@selector(rotationView) forControlEvents:UIControlEventTouchUpInside];
}
-(void)showChangelightControl
{

}

-(void)changePage:(UISlider *)sl {
    isDrag = NO;
    //    NSLog(@"%f",sl.value);
    NSIndexPath * indexPaths = [NSIndexPath indexPathForRow:(@(sl.value).integerValue - 1) inSection:nowIndexPath.section];
    //    NSLog(@"%ld",indexPaths.row);
    pageSlider.maximumValue = ((NSArray *)arrImg[indexPaths.section]).count;
    if (indexPaths.row != nowIndexPath.row) {
        nowIndexPath = indexPaths;
        [background scrollToRowAtIndexPath:nowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        page.text = [NSString stringWithFormat:@"%@/%@",@(nowIndexPath.row + 1) ,@(pageSlider.maximumValue)];
    }
    [self setTimerToHiddenToolBar];
    
}

- (void)setTimerToHiddenToolBar {
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hiddenTool) userInfo:nil repeats:NO];
}

- (void)show_orHiddenToolBar {
    if (headBar.hidden == NO) {
        headBar.hidden = YES;
        footBar.hidden = YES;
        [timer invalidate];
        timer = nil;
    }
    else {
        headBar.hidden = NO;
        footBar.hidden = NO;
        [self setTimerToHiddenToolBar];
    }
}

//隐藏Tool
- (void)hiddenTool {
    headBar.hidden = YES;
    footBar.hidden = YES;
    [timer invalidate];
    timer = nil;
}


-(void)rotationView{
    [self setTimerToHiddenToolBar];
    if (rotate.selected == YES) {
        rotate.selected = NO;
        headBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        footBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44);
        rotateView.transform = CGAffineTransformMakeRotation(0);
        rotateView.bounds = [UIScreen mainScreen].bounds;
        backgroundImageView.frame = rotateView.bounds;
        background.frame = backgroundImageView.bounds;
        [background scrollToRowAtIndexPath:nowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [background reloadData];
    }
    else {
        rotate.selected = YES;
        headBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 44);
        footBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.width - 44, [UIScreen mainScreen].bounds.size.height, 44);
        rotateView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
        rotateView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        backgroundImageView.frame = rotateView.bounds;
        background.frame = backgroundImageView.bounds;
        [background scrollToRowAtIndexPath:nowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [background reloadData];
        
    }
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyID =@"image";
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyID];
//    if (arrImg.count>indexPath.row) {
    UIImageView *IMG =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    sizeModel *mo = sizeArr[indexPath.row];
    if (!mo) {
  
    if (rotate.selected == NO) {
        IMG.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * (mo.heigth/mo.width));
    }
    else {
        IMG.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height * (mo.heigth/mo.width));
        
    }
    }
    else {
        if (rotate.selected == NO) {
            IMG.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
        }
        else {
            IMG.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height);
        }
    }
    IMG.image =arrImg[indexPath.row];
    [cell addSubview:IMG];

    cell.backgroundColor =[UIColor yellowColor];
    
      return cell;
    

}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    title.text = titleArray[indexPath.section];
    sizeModel * mo = sizeArr[indexPath.row];
    if (!mo) {
        if (rotate.selected == NO) {
            return [UIScreen mainScreen].bounds.size.width * (mo.heigth/mo.width);
        }
        else {
            return [UIScreen mainScreen].bounds.size.height * (mo.heigth/mo.width);
        }
    }
    else {
        if (rotate.selected == NO) {
            return [UIScreen mainScreen].bounds.size.width;
        }
        else {
            return [UIScreen mainScreen].bounds.size.height;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"numberOfRow%ld",arrImg.count);
    return arrImg.count;
    
}


-(void)creatUI
{
   
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getHttpDataWith
{
    sizeArr =[[NSMutableArray alloc]init];
//    __weak typeof(*&self)weakSelf = self;
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:
     [NSString stringWithFormat:@"http://api.dmzj.com/dynamic/comicread/%ld/%ld.json?channel=ios&version=1.1.107",_ID,_COMICID]
      parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        readmodel=[[readModel alloc]mj_setKeyValues:operation.responseString];

          
          
          for (NSInteger i =0; i<readmodel.page.count; i++)
          {
              [self httpDataLoadwith:readmodel.page[i]];
              [sizeArr addObject:readmodel.size];
              
          }

          [background reloadData];
//
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

    
}


-(void)httpDataLoadwith :(NSString *)str
{
    NSString *url=[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url-%@",url);
    AFHTTPRequestOperationManager * manager2 = [AFHTTPRequestOperationManager manager];
    manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager2.requestSerializer setValue:@"http://images.dmzj.com/" forHTTPHeaderField:@"Referer"];
    [manager2 GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"333");
        UIImage *image = [UIImage imageWithData:responseObject];
        [arrImg addObject:image];
        NSLog(@"%@",arrImg.lastObject);
        [background reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络错误%@",error);
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
