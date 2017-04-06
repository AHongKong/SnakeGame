//
//  UIColor+SThemeColor.h
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/6.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rgbColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface UIColor (SThemeColor)

+ (UIColor *)randomColor;
+ (UIColor *)buttonColor;
+ (UIColor *)buttonTitleColor;
+ (UIColor *)controlViewColor;
+ (UIColor *)themeColor;


@end
