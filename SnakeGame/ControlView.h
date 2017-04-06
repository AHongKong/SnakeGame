//
//  ControlView.h
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/5.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SThemeButton.h"

@protocol ControlViewDelegate <NSObject>
-(void)startGame:(UIButton *)btn;
-(void)settingGame:(UIButton *)btn;
-(void)aboutGame:(UIButton *)btn;

@end
@interface ControlView : UIView
@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) SThemeButton *startBtn;
@property (nonatomic, strong) SThemeButton *settingBtn;
@property (nonatomic, strong) SThemeButton *aboutBtn;

@end
