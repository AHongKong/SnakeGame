//
//  Snake.h
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/4.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameSetting.h"

typedef NS_ENUM(NSUInteger, Direction) {
    left    = 1 << 0,
    up      = 1 << 1,
    right   = 1 << 2,
    down    = 1 << 3,
};

@interface SnakePoint : NSObject
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

+(instancetype)pointWithX:(NSInteger)x y:(NSInteger)y;

@end

@interface SnackPoint : SnakePoint
@property (nonatomic, strong) UIColor *color;
+(instancetype)pointWithX:(NSInteger)x y:(NSInteger)y;

@end

@interface Snake : NSObject
@property (nonatomic, strong) GameSetting *setting;

@property (nonatomic, strong) UIColor *snakeColor;
@property (nonatomic, assign) CGSize bodySize;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, assign) Direction direction;
    //单个零食版本
@property (nonatomic, strong) SnackPoint *snackPoint;
    //多个零食版本，零食个数可调
@property (nonatomic, strong) NSMutableArray *snacks;

@property (nonatomic, assign) BOOL gameOver;

- (void)move;

//- (BOOL)changeToLonger:(SnakePoint *)point;
//- (BOOL)headHitBody;


@end
