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
    
    NSMutableArray *arrImg;
    NSMutableArray *beforeArrImg;
}
@end

@implementation ReaderViewController

- (void)viewDidLoad {
//    [self getHttpDataWith];
    [super viewDidLoad];
   
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
    background.backgroundColor =[UIColor redColor];
    background.delegate =self;
    background.dataSource =self;
    
    [self.view addSubview:background];

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
    
    
    cell.imageView.image=arrImg[indexPath.row];
    NSLog(@"%@",arrImg[indexPath.row]);
    cell.backgroundColor =[UIColor yellowColor];
//    }
    
      return cell;
    

}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height-100;
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
    
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:
//     [NSString stringWithFormat:@"http://api.dmzj.com/dynamic/comicread/%ld/%ld.json?channel=ios&version=1.1.107",_ID,_COMICID]
     [NSString stringWithFormat:@"http://api.dmzj.com/dynamic/comicread/21153/41841.json?channel=ios&version=1.1.107"]
      parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        readmodel=[[readModel alloc]mj_setKeyValues:operation.responseString];
        
        NSString *url=[readmodel.page[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"url-%@",url);
        AFHTTPRequestOperationManager * manager2 = [AFHTTPRequestOperationManager manager];
        manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager2.requestSerializer setValue:@"http://images.dmzj.com/" forHTTPHeaderField:@"Referer"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImageView *imgV =[[UIImageView alloc]initWithFrame:self.view.frame];
            NSLog(@"333333");
            UIImage *image = [UIImage imageWithData:responseObject];
            imgV.image =image;
            [arrImg addObject:image];
            

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"网络错误%@",error);
        }];
        
//        }
     [background reloadData];
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
