//
//  Snake.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/4.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "Snake.h"
#import "UIColor+SThemeColor.h"

@implementation SnakePoint
#pragma mark 定义蛇身的点
+(instancetype)pointWithX:(NSInteger)x y:(NSInteger)y {
    SnakePoint *point = [[SnakePoint alloc] init];
    point.x = x;
    point.y = y;
    return point;
}

@end

#pragma mark 定义零食的点，继承自SnakePoint，自己特有的color属性
@implementation SnackPoint
    //定义蛇身的点
+(instancetype)pointWithX:(NSInteger)x y:(NSInteger)y {
    SnackPoint *point = [[SnackPoint alloc] init];
    point.x = x;
    point.y = y;
    point.color = [UIColor randomColor];
    return point;
    
}

@end

#pragma mark 蛇模型

@interface Snake ()
@property (nonatomic, assign) int maxW;
@property (nonatomic, assign) int maxH;
@property (nonatomic, assign) int totalAmount;

@end
@implementation Snake
- (instancetype)init {
    if (self = [super init]) {
        GameSetting *setting = [GameSetting shareInstance];
        self.bodySize = setting.bodySize;
        _direction = setting.direction;
        self.snakeColor = setting.snakeColor;
        _gameOver = NO;
        
        self.maxH = [self maxHeight];
        self.maxW = [self maxWidth];
        self.totalAmount = [self MaxAMountOfBody];
    }
    return self;

}
    //控制方向，只有横向可以和竖直方向相互变化
- (void)setDirection:(Direction)direction {
    
    switch (direction) {
        case up:
        case down:
            if (_direction == right || _direction == left) {
                _direction = direction;

            }
            break;
        case left:
        case right:
            if (_direction == up || _direction == down) {
                _direction = direction;
                
            }
            break;
   
        default:
            _direction = direction;

            break;
    }
    
}

- (NSMutableArray *)snacks {
    if (!_snacks) {
        _snacks = [NSMutableArray array];
        GameSetting *setting = [GameSetting shareInstance];
        [self enLargeSnackAmountWithNumber:setting.originalSnackNum];
    }
    return _snacks;
}

    //蛇神默认有一个点的身体
- (NSMutableArray *)points {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
        SnakePoint *point = [self fetchNewSnackPoint];
        
        [_points addObject:point];
        
    }
    return _points;
}

    //定时器触发的移动方法
- (void)move {
    SnakePoint *firstPoint = [self.points firstObject];
    SnakePoint *point = nil;
    switch (self.direction) {
        case up:
        {
            //边界判断，可穿越边界
            int curentY = 0;
        
            if (firstPoint.y == 0) {
                curentY = self.maxH - self.bodySize.height;

            } else {
                curentY = firstPoint.y - self.bodySize.height;

            }

            point = [SnakePoint pointWithX:firstPoint.x y:curentY];
        }
            break;
        case down:
        {
            int curentY = 0;

            if (firstPoint.y == self.maxH) {
                curentY = 0 + self.bodySize.height;

            } else {
                curentY = firstPoint.y + self.bodySize.height;

            }
            point = [SnakePoint pointWithX:firstPoint.x y:curentY];
        }
            break;
        case left:
        {
            int currentX = 0;
            if (firstPoint.x == 0) {
                currentX = self.maxW - self.bodySize.width;
            } else {
                currentX = firstPoint.x - self.bodySize.width;

            }
            point = [SnakePoint pointWithX:currentX y:firstPoint.y];
        }
            break;
        case right:
        {
            int currentX = 0;
            if (firstPoint.x == self.maxW) {
                currentX = 0 + self.bodySize.width;
            } else {
                currentX = firstPoint.x + self.bodySize.width;
                
            }

            point = [SnakePoint pointWithX:currentX y:firstPoint.y];
        }
            break;
        default:
            point = [SnakePoint pointWithX:firstPoint.x y:firstPoint.y - self.bodySize.height];

            break;
    }
        //判断是否结束游戏
    if ([self headHitBody:point]) {
        self.gameOver = YES;
        
    }
        //判断是否要加长蛇身
    if (self.points) {
            //添加新的头点
        [self.points insertObject:point atIndex:0];
    }
    NSDictionary *dic = [self changeToLonger:point];
    BOOL flag = [[dic objectForKey:@"flag"] boolValue];
    SnackPoint *snack = (SnackPoint *)[dic objectForKey:@"snack"];
    if (flag) {
            //改变蛇身颜色
        self.snakeColor = snack.color;
            //移除被吃的零食
        [self removeAteSnackWithPoint:snack];
            //添加新的零食
        GameSetting *setting = [GameSetting shareInstance];
        BOOL isfull = (self.snacks.count + self.points.count) >= self.totalAmount;
        BOOL isNeedToSlowDown = self.snacks.count > self.totalAmount * 0.3;
        if (isfull) {
            
        }else {
            if (isNeedToSlowDown) {
                [self enLargeSnackAmountWithNumber:1];

            }else {
                [self enLargeSnackAmountWithNumber:setting.increaseSnackNum];

            }
        }
        
            //单一零食版本
//        self.snackPoint = [self fetchNewSnackPoint];

    } else {
        [self.points removeLastObject];

    }
    
}

#pragma mark 是否要加长蛇身
- (NSDictionary *)changeToLonger:(SnakePoint *)p {
    BOOL flag = NO;
    
    SnackPoint *temp = nil;
    for (SnackPoint *point in self.snacks) {
        if (point.x == p.x && point.y == p.y) {
            temp = point;
            flag = YES;

            break;
        }
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:flag],@"flag" ,temp,@"snack", nil];

    return dic;
}

#pragma mark 增加snack数量
- (void)enLargeSnackAmountWithNumber:(NSInteger)num {
        //添加新的零食
    for (int i = 0; i < num; i++) {
        SnackPoint *snack = [self fetchNewSnackPoint];
        [self.snacks addObject:snack];

    }
}

#pragma mark 移除被吃的点
- (void)removeAteSnackWithPoint:(SnackPoint *)p {
        //移除被吃的零食
    [self.snacks removeObject:p];
}
#pragma mark 蛇的头没有碰到蛇身体
- (BOOL)headHitBody:(SnakePoint *)point {
    
    return [self pointsInCludedPoint:point];
}

#pragma mark 零食的位置不可以在蛇身体
- (BOOL)pointsInCludedPoint:(SnakePoint *)p{
    BOOL flag = NO;
    for (SnakePoint *point in self.points) {
        if (point.x == p.x && point.y == p.y) {
            flag = YES;
            break;
        }
        
    }
    
    return flag;
}

- (SnackPoint *)fetchNewSnackPoint {
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
        //制定看不见的网格，蛇身的位置
    int width = screenWidth / self.bodySize.width;
    int height = screenHeight / self.bodySize.height;
    
    int x = 0;
    int y = 0;
    SnackPoint *point = nil;
    BOOL isInPoints = NO;
    do {
        x = arc4random() % width;
        y = arc4random() % height;
        point = [SnackPoint pointWithX:x * self.bodySize.width y:y * self.bodySize.height];
        isInPoints = [self pointsInCludedPoint:point];
    } while (isInPoints);
    
    return point;
}

#pragma mark 用于边界判断
- (int)maxWidth{
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    int width = screenWidth / self.bodySize.width;
    return width * self.bodySize.width;
}

- (int)maxHeight {
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    int height = screenHeight / self.bodySize.height;
    return height * self.bodySize.height;
}

- (int)MaxAMountOfBody {
    int area = [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].bounds.size.width;
    int areaPerBody = self.bodySize.width * self.bodySize.height;
    int amount = area / areaPerBody;
    return amount;
}

@end
