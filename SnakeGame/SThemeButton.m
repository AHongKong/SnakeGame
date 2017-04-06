//
//  SThemeButton.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/6.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "SThemeButton.h"
#import "UIColor+SThemeColor.h"

@implementation SThemeButton
+ (instancetype)themeBtnWithTitle:(NSString *)title selector:(SEL)sel target:(id)target{
    
    SThemeButton *btn = [SThemeButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor buttonColor];
    [btn setTitleColor:[UIColor buttonTitleColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
