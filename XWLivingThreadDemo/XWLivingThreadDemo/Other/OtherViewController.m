//
//  OtherViewController.m
//  XWLivingThreadDemo
//
//  Created by 邱学伟 on 2018/10/16.
//  Copyright © 2018 邱学伟. All rights reserved.
//

#import "OtherViewController.h"
#import "XWLivingThread.h"

@interface OtherViewController ()
@property (nonatomic, strong) XWLivingThread *livingThread;
@end

@implementation OtherViewController

#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    /// 初始化实例对象, 会跟随当前控制器销魂而自动销魂常驻线程
    self.livingThread = [[XWLivingThread alloc] init];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    /// 功能1
//    [XWLivingThread executeTask:^{
//        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(self.class),[NSThread currentThread]);
//    }];
    
    /// 功能2
//    [XWLivingThread executeTask:^{
//        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(self.class),[NSThread currentThread]);
//    } identity:@"123"];
    
    /// 功能3
    __weak typeof(self) weakSelf = self;
    [self.livingThread executeTask:^{
        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(weakSelf.class),[NSThread currentThread]);
    }];
}

#pragma mark - private
- (void)setupUI {
    self.title = @"另外一个控制器";
    self.view.backgroundColor = [UIColor purpleColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击屏幕任意位置执行打印操作";
    label.textColor = UIColor.whiteColor;
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}
@end
