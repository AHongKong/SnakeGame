//
//  SettingController.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/5.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "SettingController.h"
#import "GameSetting.h"

@interface SettingController ()
@property (nonatomic, strong) GameSetting *setting;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UIStepper *stepper0;

@property (weak, nonatomic) IBOutlet UIStepper *stepper1;
@property (weak, nonatomic) IBOutlet UIStepper *stepper2;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *increaseNumLabel;

@end

@implementation SettingController
/*
 initWithCoder:
 awakeFromNib
 loadView
 viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.speedLabel.text = [NSString stringWithFormat:@"%.2f",self.setting.timeInterval];
    self.slider1.value = self.setting.timeInterval;
    
    self.sizeLabel.text = [NSString stringWithFormat:@"%d",(int)self.setting.bodySize.width];
    self.stepper0.value = (int)self.setting.bodySize.width;
    
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)self.setting.originalSnackNum];
    self.stepper1.value = self.setting.originalSnackNum;
    
    self.increaseNumLabel.text = [NSString stringWithFormat:@"%ld",(long)self.setting.increaseSnackNum];
    self.stepper2.value = self.setting.increaseSnackNum;
    
    
    
}
- (IBAction)close:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}

- (IBAction)moveSpeed:(UISlider *)sender {
    self.speedLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
    self.setting.timeInterval = [self.speedLabel.text floatValue];
    
}
- (IBAction)bodySizeChange:(UIStepper *)sender {
    self.sizeLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    self.setting.bodySize = CGSizeMake((int)sender.value, (int)sender.value);
}
- (IBAction)amountOfSnack:(UIStepper *)sender {
    self.setting.originalSnackNum = (int)sender.value;
    self.amountLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];

}
- (IBAction)increaseSnack:(UIStepper *)sender {
    self.setting.increaseSnackNum = (int)sender.value;
    self.increaseNumLabel.text = [NSString stringWithFormat:@"%d",(int)sender.value];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GameSetting *)setting {
    if (!_setting) {
        _setting = [GameSetting shareInstance];
    }
    return _setting;
}
@end
