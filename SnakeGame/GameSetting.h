//
//  GameSetting.h
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/5.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GameSetting : NSObject
    //定时器的时间间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
    //每个格子的大小
@property (nonatomic, assign) CGSize bodySize;
    //蛇的初始颜色
@property (nonatomic, strong) UIColor *snakeColor;
    //蛇的初始运动方向－随机
@property (nonatomic, assign) NSInteger direction;
    //初始界面零食的个数
@property (nonatomic, assign) NSInteger originalSnackNum;
    //零食的增长个数
@property (nonatomic, assign) NSInteger increaseSnackNum;

+ (instancetype)shareInstance;

@end
