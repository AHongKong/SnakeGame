//
//  ControlView.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/5.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "ControlView.h"
#import "UIColor+SThemeColor.h"

@interface ControlView ()

@end
@implementation ControlView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor controlViewColor];

        [self addSubview:self.startBtn];
        [self addSubview:self.settingBtn];
        [self addSubview:self.aboutBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space_V = 30;
    CGFloat space_H = 30;
    CGFloat width = self.frame.size.width - 2 * space_H;
    CGFloat height = (self.frame.size.height - 4 * space_V) / 3;
    self.startBtn.frame = CGRectMake(space_H, space_V, width, height);
    self.settingBtn.frame = CGRectMake(space_H, CGRectGetMaxY(self.startBtn.frame) + space_V, width, height);
    self.aboutBtn.frame = CGRectMake(space_H, CGRectGetMaxY(self.settingBtn.frame) + space_V, width, height);

}

- (void)start:(SThemeButton *)btn {
    if ([self.delegate respondsToSelector:@selector(startGame:)]) {
        [self.delegate startGame:btn];
        
    }
}

- (void)setting:(SThemeButton *)btn {
    if ([self.delegate respondsToSelector:@selector(settingGame:)]) {
        [self.delegate settingGame:btn];
        
    }
}

- (void)about:(SThemeButton *)btn {
    if ([self.delegate respondsToSelector:@selector(aboutGame:)]) {
        [self.delegate aboutGame:btn];
        
    }
}

- (SThemeButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [SThemeButton themeBtnWithTitle:@"开始游戏" selector:@selector(start:) target:self];

    }
    return _startBtn;
}

- (SThemeButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [SThemeButton themeBtnWithTitle:@"游戏设置" selector:@selector(setting:) target:self];

    }
    return _settingBtn;
}

- (SThemeButton *)aboutBtn {
    if (!_aboutBtn) {
        _aboutBtn = [SThemeButton themeBtnWithTitle:@"关于游戏" selector:@selector(about:) target:self];
    }
    return _aboutBtn;
}

@end
