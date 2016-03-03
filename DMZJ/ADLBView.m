//
//  ADLBView.m
//  day15-03-广告轮播封装
//
//  Created by Aaron on 15/10/23.
//  Copyright (c) 2015年 Aaron. All rights reserved.
//

#import "ADLBView.h"
@interface ADLBView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *adView;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) void (^callBack)(NSInteger chooseIndex);

@end

@implementation ADLBView

-(instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images withCallBack:(void(^)(NSInteger chooseIndex))callBack
{
    if(self = [super initWithFrame:frame])
    {
        _images = images;
        _callBack = callBack;
        [self configUI];
        [self createBtn];
        [self startScroll];
    }
    return self;

}

-(void)startScroll
{
    if(!_timer)
    {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}

-(void)timerRun
{
    [UIView animateWithDuration:0.5 animations:^{
        _adView.contentOffset = CGPointMake(_adView.bounds.size.width*2, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:_adView];
    }];
}

-(void)chooseOne:(UITapGestureRecognizer *)tap
{
    _callBack(_currentIndex);
}

-(void)configUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseOne:)];
    [self addGestureRecognizer:tap];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    _adView = scrollView;

    _imageViews = [NSMutableArray array];
    for(int i = 0; i < 3; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        [scrollView addSubview:imgView];
        [_imageViews addObject:imgView];
        _title =[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
        _title.backgroundColor =[UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *bgLine =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
        bgLine.image =[UIImage imageNamed:@"recommend_headlineTitleBg"];
        [bgLine addSubview:_title];
        [imgView addSubview:bgLine];
        
        
    }
    
    
    scrollView.bounces = NO;

    scrollView.showsHorizontalScrollIndicator = NO;

    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width*3, scrollView.bounds.size.height);

    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);

    scrollView.pagingEnabled = YES;

    scrollView.delegate = self;

    [self showImageByIndex:_currentIndex];
}

-(void)createBtn
{
    _btnArray = [NSMutableArray array];
    for(int i = 0; i <= _images.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //btn.backgroundColor = [UIColor redColor];
        if(i != _images.count)
        {
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_n"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
        }
//        else
//        {
//            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_del"] forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(dismissMe:) forControlEvents:UIControlEventTouchUpInside];
//        }
        [self addSubview:btn];
        [_btnArray addObject:btn];
    }

    [self reloadBtn];

    [self changePageImageByIndex:_currentIndex];
}

-(void)dismissMe:(UIButton *)sender
{
    [self removeFromSuperview];
}

-(void)changePageImageByIndex:(NSInteger)index
{
    for(int i = 0; i < _images.count;i++)
    {
        UIButton *btn = _btnArray[i];
        if(i == index)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_h"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"feedAd_n"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

-(void)reloadBtn
{
    for(NSInteger i = 0; i < _btnArray.count; i++)
    {
        UIButton *btn = _btnArray[_btnArray.count-1-i];
        btn.frame = CGRectMake(self.bounds.size.width-_boardWidth.right-20-10-(5+10)*i, self.bounds.size.height-_boardWidth.bottom-10-10, 10, 10);
    }
}


-(NSInteger)trueIndexFromIndex:(NSInteger)index
{
    if(index==-1)
    {
        return _images.count-1;
    }
    else if(index == _images.count)
    {
        return 0;
    }
    return index;
}

-(void)showImageByIndex:(NSInteger)index
{
    for(int i = -1;i <= 1; i++)
    {
        UIImageView *imgView = _imageViews[i+1];
        imgView.image = _images[[self trueIndexFromIndex:index+i]];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint contentOffset = scrollView.contentOffset;

    if(contentOffset.x == 0)
    {
        _currentIndex = [self trueIndexFromIndex:_currentIndex-1];
    }
    else if(contentOffset.x == scrollView.bounds.size.width*2)
    {
        _currentIndex = [self trueIndexFromIndex:_currentIndex+1];
    }
    [self showImageByIndex:_currentIndex];
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
    [self changePageImageByIndex:_currentIndex];
}


#pragma mark --setter方法
-(void)setBoardWidth:(UIEdgeInsets)boardWidth
{
    _boardWidth = boardWidth;
    _adView.frame = CGRectMake(_boardWidth.left, _boardWidth.top, self.bounds.size.width-_boardWidth.left-_boardWidth.right, self.bounds.size.height-_boardWidth.bottom-_boardWidth.top);

    for(int i = 0; i < _imageViews.count;i++)
    {
        UIImageView *imageView = _imageViews[i];
        imageView.frame = CGRectMake(_adView.bounds.size.width*i, 0, _adView.bounds.size.width, _adView.bounds.size.height);
    }

    _adView.contentOffset = CGPointMake(_adView.bounds.size.width, 0);

    _adView.contentSize = CGSizeMake(_adView.bounds.size.width*3, _adView.bounds.size.height);

    [self reloadBtn];
}

-(void)setBoardColor:(UIColor *)boardColor
{
    _boardColor = boardColor;
    self.backgroundColor = _boardColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
