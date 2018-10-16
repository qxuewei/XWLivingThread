//
//  OtherViewController.m
//  XWLivingThreadDemo
//
//  Created by 邱学伟 on 2018/10/16.
//  Copyright © 2018 邱学伟. All rights reserved.
//

#import "OtherViewController.h"
#import "XWLivingThread.h"

@interface XWThread2 : NSThread
@end
@implementation XWThread2

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end

@interface OtherViewController ()
@property (nonatomic, strong) XWLivingThread *livingThread;

@property (nonatomic, strong) XWThread2 *thread;
@end

@implementation OtherViewController

#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"另外一个控制器";
    self.view.backgroundColor = [UIColor purpleColor];
    
    /// 初始化实例对象, 会跟随当前控制器销魂而自动销魂常驻线程
    self.livingThread = [[XWLivingThread alloc] init];
    
//    self.thread = [[XWThread2 alloc] initWithTarget:self selector:@selector(threadMethod) object:nil];
//    [self.thread start];
}

- (void)threadMethod {
    NSLog(@"threadMethod");
    
    @autoreleasepool {
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    __weak typeof(self) weakSelf = self;
    
//    [self.livingThread executeTask:^{
//        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(weakSelf.class),[NSThread currentThread]);
//    }];
    
    
//    [XWLivingThread executeTask:^{
//        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(weakSelf.class),[NSThread currentThread]);
//    }];
    
    [XWLivingThread executeTask:^{
        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(weakSelf.class),[NSThread currentThread]);
    } identity:@"123"];
}

#pragma mark - private
@end
