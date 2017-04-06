//
//  ViewController.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/4.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "ViewController.h"
#import "SnakeView.h"
#import "GameSetting.h"
#import "ControlView.h"
#import "SThemeButton.h"

#import "SettingController.h"
#import "SAboutGameController.h"

@interface ViewController ()<SnakeViewDataSource,UIAlertViewDelegate,ControlViewDelegate>
@property (nonatomic, strong) Snake *snake;

@property (nonatomic, strong) SnakeView *snakeView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) ControlView *controlView;
@property (nonatomic, strong) UIButton *suspendBtn;
@property (nonatomic, strong) UIButton *stopBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //界面控制
    [self.view addSubview:self.controlView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.suspendBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.stopBtn];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
        //双击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideNav:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];
    
        //self监听进入后台状态的通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(enterBackGround) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}
    //开始游戏
- (void)startGame:(UIButton *)btn {
        //添加游戏视图
    [self.view insertSubview:self.snakeView atIndex:0];
    [UIView transitionWithView:self.snakeView duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.controlView.transform = CGAffineTransformMakeRotation(M_PI * 0.25);
        self.controlView.center = CGPointMake(self.controlView.center.x,self.view.frame.size.height + self.controlView.bounds.size.height * 0.5);
        self.controlView.alpha = 0;
    
    } completion:^(BOOL finished) {
        [self reStart:NO];
        self.controlView.hidden = YES;
        self.controlView.transform = CGAffineTransformIdentity;
        self.controlView.center = CGPointMake(self.controlView.center.x,-self.controlView.bounds.size.height * 0.5);

    }];

}
    //用户手动结束游戏
- (void)stopAction:(UIButton *)btn {
        //移除视图keypath的监听
    [self removeKeyPathWhenSnckViewDeallocated];
        //移除视图，清空视图以及数据
    [self.snakeView removeFromSuperview];
    self.snakeView = nil;
    self.snake = nil;
    
        //暂停定时器
    [self.timer invalidate];
    self.timer = nil;
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    if ([self.suspendBtn.titleLabel.text isEqualToString:@"开始"]) {
        [self.suspendBtn setTitle:@"暂停" forState:UIControlStateNormal];
        
    }
        //显示控制界面
    self.controlView.hidden = NO;
    CGFloat ty = (self.view.bounds.size.height + self.controlView.frame.size.height) * 0.5;
    CATransform3D transform = CATransform3DMakeTranslation(0, -ty, 0);
    transform = CATransform3DRotate(transform, 40 * M_PI / 180, 0, 0, 1.0);
    self.controlView.layer.transform = transform;
    
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
        self.snakeView.alpha = 0;
        self.controlView.alpha = 1;
        self.controlView.center = self.view.center;
    self.controlView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.snakeView.alpha = 1;

    }];
    
}
    //进入设置控制器
- (void)settingGame:(UIButton *)btn {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main.storyboard" bundle:[NSBundle mainBundle]];//这里的bundle 写nil也可以代表是mainBundle
    SettingController *vc = [self.storyboard  instantiateViewControllerWithIdentifier:@"settingVC"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)aboutGame:(UIButton *)btn {
  
    SAboutGameController *vc = [self.storyboard  instantiateViewControllerWithIdentifier:@"Sabout"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];

}

    //双击控制navigationBar（暂停和结束的控制按钮）的显示与隐藏
- (void)showOrHideNav:(UITapGestureRecognizer *)tap {
    if (self.controlView.hidden) {
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];

        }else {
            [self.navigationController setNavigationBarHidden:YES animated:YES];

        }
    }
    
}
    //进入后台的情况下自动暂停
- (void)enterBackGround {
    if ([self.suspendBtn.titleLabel.text isEqualToString:@"暂停"]) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.suspendBtn setTitle:@"开始" forState:UIControlStateNormal];
        
    }
}
    //用户手动点击暂停
- (void)suspendAction:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"暂停"]) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [btn setTitle:@"开始" forState:UIControlStateNormal];
        
    } else {
        [self.timer setFireDate:[NSDate date]];
        [btn setTitle:@"暂停" forState:UIControlStateNormal];

    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"direction"]) {
            //必须强制类型转换
        self.snake.direction = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
    
    }else {
            //游戏结束
        BOOL isOver = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (isOver) {
            [self.timer invalidate];
            self.timer = nil;
            NSLog(@"Game Over");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"点击选择重新开始" delegate:self cancelButtonTitle:@"重新开始" otherButtonTitles:@"结束游戏", nil];
            [alertView show];
        }
    }
}

#pragma mark deliver Data To SnakeView
- (Snake *)deliverModelToSnakeView {
    return self.snake;
    
}

    //开始游戏或者重新开始的私有方法
- (void)reStart:(BOOL)flag {
    
    if (flag) {
//        self.snake.points = nil;
//        self.snake.snacks = nil;
        self.snake = nil;
    }
    [self.timer fire];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self reStart:YES];

    } else {
        [self stopAction:nil];
    }
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    [self removeKeyPathWhenSnckViewDeallocated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)removeKeyPathWhenSnckViewDeallocated{

    [_snakeView removeObserver:self forKeyPath:@"direction" context:NULL];
    [_snake removeObserver:self forKeyPath:@"gameOver" context:NULL];

}
    //隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (Snake *)snake {
    if (!_snake) {
        _snake = [[Snake alloc] init];
        [_snake addObserver:self forKeyPath:@"gameOver" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    return _snake;
}
- (SnakeView *)snakeView {
    if (!_snakeView) {
        _snakeView = [[SnakeView alloc] init];
        _snakeView.frame = self.view.bounds;
        _snakeView.dataSource = self;
        [_snakeView addObserver:self forKeyPath:@"direction" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
    }
    return _snakeView;
}

- (ControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ControlView alloc] init];
        _controlView.center = self.view.center;
        _controlView.bounds = CGRectMake(0, 0, self.view.frame.size.width * 0.6, self.view.frame.size.height * 0.35);
        _controlView.delegate = self;
    }
    return _controlView;
}

- (UIButton *)suspendBtn {
    if (!_suspendBtn) {
        _suspendBtn =  [SThemeButton themeBtnWithTitle:@"暂停" selector:@selector(suspendAction:) target:self];
        _suspendBtn.frame = CGRectMake(self.view.frame.size.width - 60, 30, 40, 30);
        
    }
    return _suspendBtn;
    
}

- (UIButton *)stopBtn {
    if (!_stopBtn) {
        _stopBtn = [SThemeButton themeBtnWithTitle:@"结束游戏" selector:@selector(stopAction:) target:self];
        _stopBtn.frame = CGRectMake(60, 30, 80, 30);
    }
    return _stopBtn;
}

- (NSTimer *)timer {
    if (!_timer) {
        //开启定时器-手动开启
        __weak typeof(self)weakSelf = self;
        GameSetting *setting = [GameSetting shareInstance];
        _timer =     [NSTimer timerWithTimeInterval:setting.timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf.snake move];
            [weakSelf.snakeView setNeedsDisplay];
            
        }];
        
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

            //        [NSTimer scheduledTimerWithTimeInterval:setting.timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [weakSelf.snake move];
//            [weakSelf.snakeView setNeedsDisplay];
//        }];

    }
    return _timer;
}

@end
