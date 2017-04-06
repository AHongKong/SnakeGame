//
//  SnakeView.h
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/4.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Snake.h"

@protocol SnakeViewDataSource <NSObject>
- (Snake *)deliverModelToSnakeView;

@end
@interface SnakeView : UIView

@property (nonatomic, weak) id dataSource;
@property (nonatomic, assign) Direction direction;

@end
