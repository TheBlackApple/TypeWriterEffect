//
//  TypeWriterEffectLabel.m
//  TypeWriterEffect
//
//  Created by Charles Leo on 15/1/4.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "TypeWriterEffectLabel.h"

@implementation TypeWriterEffectLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hasSound = YES;
        self.typewriteTimeInterval = 0.3;
    }
    return self;
}

- (void)startTypewrite
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"typewriter" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)([NSURL fileURLWithPath:path]), &soundID);
    [NSTimer scheduledTimerWithTimeInterval:self.typewriteTimeInterval target:self selector:@selector(outPutWord:) userInfo:nil repeats:YES];
}

- (void)outPutWord:(id)timer
{
    if (self.text.length == self.currentIndex) {
        [timer invalidate];
        timer = nil;
        self.typewriteEffectBlock();
    }
    else
    {
        self.currentIndex ++;
        NSDictionary * dict = @{NSForegroundColorAttributeName :self.typewriteEffectColor};
        NSMutableAttributedString * mutableStr = [[NSMutableAttributedString alloc]initWithString:self.text];
        [mutableStr addAttributes:dict range:NSMakeRange(0, self.currentIndex)];
        [self setAttributedText:mutableStr];
        self.hasSound?AudioServicesPlaySystemSound(soundID):AudioServicesPlaySystemSound(0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
