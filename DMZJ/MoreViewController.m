//
//  MoreViewController.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/23.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *TabV;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden =YES;
    UIImageView *navigationV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationV.image =[UIImage imageNamed:@"111"];
    navigationV.userInteractionEnabled =YES;
    [self.view addSubview:navigationV];
    
    [TabV reloadData];
    
    UILabel *lab =[[UILabel alloc]init];
    lab.text =@"更多";
    lab.frame =CGRectMake(self.view.frame.size.width/2-50, 22, 100, 44);
    lab.font =[UIFont systemFontOfSize:20];
    lab.textAlignment =NSTextAlignmentCenter;
    lab.textColor =[UIColor whiteColor];
    [navigationV addSubview:lab];
    [self configUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)configUI
{
    TabV =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 610) style:UITableViewStyleGrouped];
    TabV.backgroundColor =[UIColor colorWithWhite:0.927 alpha:1.000];
    TabV.contentSize =CGSizeMake(self.view.bounds.size.width, 667);
    TabV.bounces =YES;
    TabV.directionalLockEnabled =YES;
    TabV.showsVerticalScrollIndicator = NO;
    TabV.showsHorizontalScrollIndicator = NO;
    TabV.dataSource =self;
    TabV.delegate =self;
    
    [self.view addSubview:TabV];
    
//    UITableViewCell *TVCell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabCell"];


}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabCell"];
//    if (indexPath.section ==0&&indexPath.row ==0) {
////        cell.textLabel.text =@"设置";
//    }
    if(indexPath.section ==0)
    {
        
        if(indexPath.row ==0)
        {
        cell.textLabel.text =[NSString stringWithFormat:@"清除在线缓存%.1fM",[self filePath]];
        }
        
    }
    if(indexPath.section ==1)
    {
    cell.textLabel.text =@"关于我们";
    }
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (indexPath.section ==0&&indexPath.row ==0)
//    {
//        
//    }
    if(indexPath.section ==0)
    {
        if(indexPath.row ==0)
        {
            [self clearFile];
        }
//        if(indexPath.row ==1)
//        {
//            
//        }
//        if(indexPath.row ==2)
//        {
//            [TabV reloadData];
//        }
    }
    if(indexPath.section ==1)
    {
        aboutUsViewController *avc =[[aboutUsViewController alloc]init];
        [self.navigationController pushViewController:avc animated:YES];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section ==0) {
//        return 1;
//    }
    if (section ==0) {
        return 1;
    }
    else {
        return 1;
    }

}



-( float )filePath
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}
// 清理缓存

- (void)clearFile
{

    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    
}

- (void)clearCachSuccess
{
    UIAlertView *Alv =[[UIAlertView alloc]initWithTitle:@"清理成功" message:@"缓存已清理" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    
    [Alv show];
    NSLog ( @" 清理成功 " );
    
    [TabV reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [TabV reloadData];
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
