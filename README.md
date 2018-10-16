## XWLivingThread (常驻线程管理器)

提供三种方式快速使用常驻线程执行自己想执行的任何操作：

### 功能1：创建一个全局常驻线程用以执行某些操作

```objc
/**
 在默认全局常驻线程中执行操作 (只要调用,默认线程即创建且不会销毁)

 @param task 操作
 */
+ (void)executeTask:(XWLivingThreadTask)task;
```

##### 使用：

```objc
[XWLivingThread executeTask:^{
    NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(self.class),[NSThread currentThread]);
}];
```

### 功能2：根据标示符创建对应的全局常驻线程用以执行某些操作

```objc
/**
 在自定义全局常驻线程中执行操作 (根据 identity 创建自定义线程,且创建后不会销毁)
 
 @param task 操作
 @param identity 自定义线程唯一标识
 */
+ (void)executeTask:(XWLivingThreadTask)task identity:(NSString *)identity;

```
##### 使用：

```objc
[XWLivingThread executeTask:^{
    NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(self.class),[NSThread currentThread]);
} identity:@"123"];
```

### 功能3：创建和管理器生命周期相同的常驻线程执行某些操作

```objc
/**
 在默认常驻线程中执行操作 (线程需随当前对象创建或销魂)
 
 @param task 操作
 */
- (void)executeTask:(XWLivingThreadTask)task;

```
##### 使用：

```objc
@property (nonatomic, strong) XWLivingThread *livingThread;

- (void)viewDidLoad {
    [super viewDidLoad];    
    /// 初始化实例对象, 会跟随当前控制器销魂而自动销魂常驻线程
    self.livingThread = [[XWLivingThread alloc] init];
}

- (void)doSomething {
    /// ⚠️⚠️⚠️ 此处一定注意避免产生循环引用
    __weak typeof(self) weakSelf = self;
    [self.livingThread executeTask:^{
        NSLog(@"在 %@ 控制器, 执行某操作 在 %@ 线程",NSStringFromClass(weakSelf.class),[NSThread currentThread]);
    }];
}
```


