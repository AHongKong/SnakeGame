//
//  SThemeButton.h
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/6.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SThemeButton : UIButton

+ (instancetype)themeBtnWithTitle:(NSString *)title selector:(SEL)sel target:(id)target;
@end
