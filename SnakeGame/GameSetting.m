//
//  GameSetting.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/5.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "GameSetting.h"

@implementation GameSetting
    //单例供全局访问
+ (instancetype)shareInstance {
    static GameSetting *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GameSetting alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.timeInterval = 0.25;
        self.bodySize = CGSizeMake(10, 10);
        self.snakeColor = [UIColor blackColor];
        self.direction = [self randomDirection];
        self.originalSnackNum = 2;
        self.increaseSnackNum = 2;
    }
    return self;
}

- (int)randomDirection{
    int i = arc4random() % 3;
    return (int)pow(2, i);
}
@end
