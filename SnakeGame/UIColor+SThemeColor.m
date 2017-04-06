//
//  UIColor+SThemeColor.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/6.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "UIColor+SThemeColor.h"

@implementation UIColor (SThemeColor)
+ (UIColor *)randomColor {
    
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    
    return rgbColor(r, g, b);
}

+ (UIColor *)buttonColor {
    return rgbColor(255, 236, 144);

}
+ (UIColor *)buttonTitleColor {
    return rgbColor(255, 156, 114);
}


+ (UIColor *)controlViewColor {
    return rgbColor(235, 255, 143);

}

+ (UIColor *)themeColor {
    return rgbColor(255, 255, 204);
}
@end
