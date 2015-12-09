//
//  customView.m
//  DMZJ
//
//  Created by 谅 陈 on 15/11/27.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "customView.h"
#import <QuartzCore/QuartzCore.h>
#define OPENCENTERX 220.0
#define DIVIDWIDTH 70.0 // 对应确认是否打开或关闭的分界线。
@implementation customView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


-(id)initWithView:(UIView *)contentview parentView:(UIView *)parentview
{
    self =[super initWithFrame:CGRectMake(0, 0, contentview.frame.size.width, contentview.frame.size.height)];
    if (self) {
        self.contenView =contentview;
        self.parentView =contentview;
        
        [self addSubview:contentview];
        UIPanGestureRecognizer *panGestureRecognizer =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];
        
        UITapGestureRecognizer *tapGestureRecognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        openPointCenter =CGPointMake(self.contenView.center.x+OPENCENTERX, self.contenView.center.y);
        
        NSLog(@"openPointCenter:%f,%f",openPointCenter.x,openPointCenter.y);
        
    }
    return self;
    
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translaction =[recognizer translationInView:self.contenView];
    float x =self.center.x+translaction.x;
    
    if (x<self.contenView.center.x) {
        x =self.contenView.center.x;
        
    }
    self.center =CGPointMake(x, openPointCenter.y);
    
    if (recognizer.state ==UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.75
                              delay:0.01
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             
                             if (x>openPointCenter.x-DIVIDWIDTH) {
                                 self.center =openPointCenter;
                             }else
                             {
                                 self.center=CGPointMake(openPointCenter.x-OPENCENTERX, openPointCenter.y);
                             }
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    [recognizer setTranslation:CGPointZero inView:self.parentView];
    
}
-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    [UIView animateWithDuration:0.75
                          delay:0.01
                        options:UIViewAnimationTransitionCurlUp animations:^(void){
                            self.center = CGPointMake(openPointCenter.x - OPENCENTERX,
                                                      openPointCenter.y);
                        }completion:nil];
    
}


















@end
