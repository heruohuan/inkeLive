//
//  LLPBaseNavViewController.m
//  myInke
//
//  Created by He_bi on 2017/5/6.
//  Copyright © 2017年 He_bi. All rights reserved.
//

#import "LLPBaseNavViewController.h"

@interface LLPBaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LLPBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = RGB(0, 216, 201);
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationBar setBackgroundImage:[LLPUtils createImageWithColor:RGB(0, 216, 201)] forBarMetrics:UIBarMetricsDefault];
    
    // Do any additional setup after loading the view from its nib.
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];

    
    // 设置代理
    self.interactivePopGestureRecognizer.delegate = self;
    
    /**
     全屏触控返回
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;

    */
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //去除黑边
    [self.navigationBar setBackgroundImage:[LLPUtils createImageWithColor:RGB(0, 216, 201)]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[LLPUtils createImageWithColor:[UIColor clearColor]]];
}


#pragma mark - <UIGestureRecognizerDelegate>
/**
 * 每当用户触发[返回手势]时都会调用一次这个方法
 * 返回值:返回YES,手势有效; 返回NO,手势失效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
        if (self.childViewControllers.count == 1) return NO;
        return YES;
//    return self.childViewControllers.count > 1; // 处理后，就不会出现黑边效果的bug了。
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
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
