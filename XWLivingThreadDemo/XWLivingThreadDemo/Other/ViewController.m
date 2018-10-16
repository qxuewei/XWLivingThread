//
//  ViewController.m
//  XWLivingThreadDemo
//
//  Created by 邱学伟 on 2018/10/16.
//  Copyright © 2018 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "OtherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一个控制器";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - private

- (IBAction)toOtherViewController:(UIButton *)sender {
    [self.navigationController pushViewController:[OtherViewController new] animated:YES];
}

@end
