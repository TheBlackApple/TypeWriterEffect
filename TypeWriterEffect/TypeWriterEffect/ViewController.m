//
//  ViewController.m
//  TypeWriterEffect
//
//  Created by Charles Leo on 15/1/4.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "ViewController.h"
#import "TypeWriterEffectLabel.h"
@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    TypeWriterEffectLabel * typeWriteLabel = [[TypeWriterEffectLabel alloc]initWithFrame:CGRectMake(40, 30, kWidth - 80, 250)];
    typeWriteLabel.tag = 10;
    typeWriteLabel.backgroundColor = [UIColor clearColor];
    typeWriteLabel.numberOfLines = 0;
    typeWriteLabel.text = @"\t\t那一天,为什么要来,那一年,为什么要走,爱在最美时,我们松开手.睁开眼之间,伤口,这场梦,注定要发生,也注定,要这样结束,为了寻求永久我们放开手,之后发现已不能回头,永远爱你啊,在我的生命里,让我学会哭,却学不会忘记,永远爱你啊,在我的生命里,我想学会逃避,却逃不出孤寂.";
    typeWriteLabel.textColor = self.view.backgroundColor;
    typeWriteLabel.typewriteEffectColor = [UIColor greenColor];
    typeWriteLabel.hasSound = YES;
    typeWriteLabel.typewriteTimeInterval = .3;
    typeWriteLabel.typewriteEffectBlock= ^{
//        UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"" message:@"打印完成" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        
//        [alert show];
        
        UIView * alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        alertView.center = self.view.center;
        alertView.backgroundColor = [UIColor greenColor];
        alertView.layer.masksToBounds = YES;
        alertView.layer.cornerRadius = 8.0f;
        alertView.clipsToBounds = YES;
        UILabel * tip = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        tip.backgroundColor = [UIColor clearColor];
        tip.text = @"打印完毕";
        tip.textAlignment = NSTextAlignmentCenter;
        tip.textColor = [UIColor blackColor];
        [alertView addSubview:tip];
        [self.view addSubview:alertView];
        [self.view bringSubviewToFront:alertView];
        [self popupAnimation:alertView duration:1];
    };
    
    [self.view addSubview:typeWriteLabel];
    /**
     *  一秒后开始打印
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startOutPut];
    });
   
}
- (void)popupAnimation:(UIView *)outView duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    NSMutableArray * values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [outView.layer addAnimation:animation forKey:nil];
    
    /**
     *  2S后删除弹出视图
     *
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [outView removeFromSuperview];
    });
}

- (void)startOutPut
{
    TypeWriterEffectLabel * label = (TypeWriterEffectLabel *)[self.view viewWithTag:10];
    [label startTypewrite];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
