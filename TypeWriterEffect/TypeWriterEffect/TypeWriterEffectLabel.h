//
//  TypeWriterEffectLabel.h
//  TypeWriterEffect
//
//  Created by Charles Leo on 15/1/4.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef void (^CLTypewriterEffectBlock)(void);
@interface TypeWriterEffectLabel : UILabel
{
    SystemSoundID soundID;
}

/**
 *  设置单个字打印间隔时间,默认0.3秒
 */
@property (nonatomic) NSTimeInterval typewriteTimeInterval;

/**
 *  打印的索引位置,默认为0
 */
@property (nonatomic) NSInteger currentIndex;

/**
 *  打印出字体的颜色
 */

@property (nonatomic,retain) UIColor * typewriteEffectColor;

/**
 *  是否有打印声音,默认是YES
 */

@property (nonatomic) BOOL hasSound;

/**
 *  打印完成后的回调block
 */

@property (nonatomic,copy) CLTypewriterEffectBlock typewriteEffectBlock;

/**
 *  开始打印的方法
 */

- (void)startTypewrite;

@end
