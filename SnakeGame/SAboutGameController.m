//
//  SAboutGameController.m
//  SnakeGame
//
//  Created by 郑娇鸿 on 17/4/6.
//  Copyright © 2017年 郑娇鸿. All rights reserved.
//

#import "SAboutGameController.h"

@interface SAboutGameController ()

@end

@implementation SAboutGameController
- (IBAction)closeVc:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
