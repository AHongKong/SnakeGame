//
//  SnakeView.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/4.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "SnakeView.h"

@interface SnakeView ()

@end
@implementation SnakeView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        for (int i = 0; i < 4; i++) {
            UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeDirection:)];
            [swipe setDirection:(int)pow(2, i)];
            [self addGestureRecognizer:swipe];

        }
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if ([self.dataSource respondsToSelector:@selector(deliverModelToSnakeView)]) {
        Snake *snake = [self.dataSource deliverModelToSnakeView];
            //绘制零食
        for (int j = 0; j < snake.snacks.count; j++) {
            SnackPoint *snack = snake.snacks[j];
            [snack.color setFill];
            [self drawPathWithPoint:snack size:snake.bodySize];
            
        }

        [snake.snakeColor setFill];
            //绘制蛇身
        for (int i = 0; i < snake.points.count; i++) {
            SnakePoint *point = snake.points[i];
            [self drawPathWithPoint:point size:snake.bodySize];
        }
            //单一零食版本
//        [snake.snackPoint.color setFill];
//        [self drawPathWithPoint:snake.snackPoint size:snake.bodySize];


    }

}

- (void)drawPathWithPoint:(SnakePoint *)point size:(CGSize)size{
    CGRect bodyRect = CGRectMake(point.x, point.y, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bodyRect];
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:bodyRect cornerRadius:size.width > size.height ? size.height : size.width];
    [path fill];

}

- (void)changeDirection:(UISwipeGestureRecognizer *)swipeGesture {

    switch (swipeGesture.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            self.direction = right;
            
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            self.direction = left;
            
            break;
        case UISwipeGestureRecognizerDirectionUp:

            self.direction = up;
            
            break;
        case UISwipeGestureRecognizerDirectionDown:

            self.direction = down;
            
            break;
   
        default:
            break;
    }
}

@end
